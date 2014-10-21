//
//  VGScriptGenerator.m
//  Vega
//
//  Created by Idriss on 11/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGScriptGenerator.h"

#import "VGUIAutomationOutputWriter.h"
#import "VGFeatureGenerator.h"
#import "VGStepsImportManager.h"
#import "VGJavascriptAutomationFormatter.h"
#import "VGTagCloud.h"

#import "VGFeature.h"

#import "NSString+VG.h"

@interface VGScriptGenerator ()

@property (nonatomic, strong) NSFileManager              *fileManager;
@property (nonatomic, strong) VGUIAutomationOutputWriter *outputWriter;
@property (nonatomic, strong) VGFeatureGenerator         *featureGenerator;
@property (nonatomic, strong) VGStepsImportManager       *stepImportManager;

@end

@implementation VGScriptGenerator

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    _fileManager = [NSFileManager defaultManager];
    
    _featureGenerator = [[VGFeatureGenerator alloc] init];
    
    _stepImportManager = [[VGStepsImportManager alloc] initWithFileManager:_fileManager];

    _outputWriter     = [[VGUIAutomationOutputWriter alloc] init];
    _outputWriter.imports = @[@"./core/core.js",
                              @"./core/internals.js"];
  }
  return self;
}

- (void)setStepDirectory:(NSString*)directory error:(NSError**)error
{
  BOOL isDirectory = NO;
  
  if(!directory) {
    NSString *errorDomain = @"vega.generator.stepimportsnil";
    NSInteger errorCode   = 1004;
    NSString *info        = NSLocalizedString(@"The steps directory not specified", @"step import directory nil");
    NSString *resolution  = NSLocalizedString(@"You need to specify a steps directory", @"step import directory nil resolution");
    
    NSError *nilDirectoryError = [NSError errorWithDomain:errorDomain
                                                     code:errorCode
                                                 userInfo:@{NSLocalizedDescriptionKey:info,
                                                            NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = nilDirectoryError;
    return;
  }
  
  if(![self.fileManager fileExistsAtPath:directory isDirectory:&isDirectory]) {
    
    NSString *errorDomain = @"vega.generator.stepimports";
    NSInteger errorCode   = 1002;
    NSString *info        = NSLocalizedString(@"The steps directory does not exists", @"step import directory not found error");
    NSString *resolution  = NSLocalizedString(@"Make sure the directory path is correct", @"step import directory error resolution");
    
    NSError *fnfError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:directory,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fnfError;
    return;

    
  } else if (!isDirectory) {
    
    NSString *errorDomain = @"vega.generator.stepimports";
    NSInteger errorCode   = 1003;
    NSString *info        = NSLocalizedString(@"The steps path exists but it's not a directory", @"step import path not directory");
    NSString *resolution  = NSLocalizedString(@"Make sure the path is a directory containing the steps", @"step import path error resolution");
    
    NSError *fnfError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:directory,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fnfError;
    return;

  }
  
  [self.stepImportManager stepsImportsForPath:directory];
  
}

- (void)setTagsString:(NSString*)tagsString
{
  VGTagCloud *tagCloud = [VGTagCloud new];
  
  NSArray *tags = [tagsString componentsSeparatedByString:@","];
  for (NSString *tag in tags) {
    if ([tag length] > 0) {
      NSString *trimmedTag = [tag stringbyTrimmingWhitespaces];
      if ([trimmedTag hasPrefix:@"~"]) {
        NSString *excludedTag = [trimmedTag stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        [tagCloud exludeTag:excludedTag];
      } else {
        [tagCloud includeTag:trimmedTag];
      }
    }
  }
  
  [self.outputWriter setTagCloud:tagCloud];
  
}


/*
 
*/
- (void)generateScriptWithFilename:(NSString*)file forFeatureFile:(NSString*)featureFile error:(NSError**)error
{
  
  if (![self.fileManager fileExistsAtPath:featureFile]) {
    
    NSString *errorDomain = @"vega.generator.featurefile";
    NSInteger errorCode   = 1001;
    NSString *info        = NSLocalizedString(@"Feature file not found", @"feature file not found error");
    NSString *resolution  = NSLocalizedString(@"Make sure the file exists", @"feature file error resolution");
    
    NSError *fnfError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:featureFile,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fnfError;
    return;
  }
  
  NSError *parsingError = nil;
  NSDictionary *rawFeature = [self.featureGenerator  parseFeatureFile:featureFile
                                                                error:&parsingError];
  if (parsingError) {
    *error = parsingError;
    return;
  }
  
  VGFeature *feature = [[VGFeature alloc] initWithDictionary:rawFeature];
  
  [self.outputWriter setStepsIncludes:[self.stepImportManager stepImports]];
  [self.outputWriter setScriptFormatter:[VGJavascriptAutomationFormatter new]];
  
  NSMutableString *automationScriptContent = [NSMutableString string];
  
  [automationScriptContent appendString:[self.outputWriter automationScriptHeader]];
  
  NSString *automationScript = [self.outputWriter automationScriptForFeature:feature];
  
  [automationScriptContent appendString:automationScript];
  
  [automationScriptContent appendString:[self.outputWriter automationScriptFooter]];
  
  NSError *writeError = nil;
  [automationScriptContent writeToFile:file
                     atomically:YES
                       encoding:NSUTF8StringEncoding
                          error:&writeError];
  
  if (writeError) {
    *error = writeError;
    return;
  }
  
}

- (void)generateScriptWithFilename:(NSString *)file forFeatureFiles:(NSString *)featureFiles error:(NSError **)error
{
  
  [self.outputWriter setStepsIncludes:[self.stepImportManager stepImports]];
  [self.outputWriter setScriptFormatter:[VGJavascriptAutomationFormatter new]];
  
  NSMutableString *automationScriptContent = [NSMutableString string];
  [automationScriptContent appendString:[self.outputWriter automationScriptHeader]];
  
  NSArray *featureFilesArray = [featureFiles componentsSeparatedByString:@","];
  
  for (NSString *featureFile in featureFilesArray) {
    NSString *featureFileFullPath = [featureFile stringByExpandingTildeInPath];
    NSError *featureFileError = nil;
    NSString *featureScript = [self generateScriptForFeatureFile:featureFileFullPath error:&featureFileError];
    if (featureFileError) {
      *error = featureFileError;
      return;
    }
    
    [automationScriptContent appendString:featureScript];
  }
  
  [automationScriptContent appendString:[self.outputWriter automationScriptFooter]];
  
  NSError *writeError = nil;
  [automationScriptContent writeToFile:file
                            atomically:YES
                              encoding:NSUTF8StringEncoding
                                 error:&writeError];
  
  if (writeError) {
    *error = writeError;
    return;
  }

  
}

- (NSString*)generateScriptForFeatureFile:(NSString*)featureFile error:(NSError**)error
{
  
  if (![self.fileManager fileExistsAtPath:featureFile]) {
    
    NSString *errorDomain = @"vega.generator.featurefile";
    NSInteger errorCode   = 1001;
    NSString *info        = NSLocalizedString(@"Feature file not found", @"feature file not found error");
    NSString *resolution  = NSLocalizedString(@"Make sure the file exists", @"feature file error resolution");
    
    NSError *fnfError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:featureFile,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fnfError;
    return nil;
  }
  
  NSError *parsingError = nil;
  NSDictionary *rawFeature = [self.featureGenerator  parseFeatureFile:featureFile
                                                                error:&parsingError];
  if (parsingError) {
    NSValue *rangeObjs    = [parsingError.userInfo valueForKey:@"range"];
    NSNumber *lineNumber  = [parsingError.userInfo valueForKey:@"lineNumber"];
    NSString *errorString =  parsingError.userInfo[@"NSLocalizedFailureReason"];
    
    if (rangeObjs && lineNumber) {
      NSInteger line = [lineNumber integerValue];
      NSRange range = [rangeObjs rangeValue];
      if (range.location != NSNotFound) {
        NSString *content = [[NSString alloc] initWithContentsOfFile:featureFile
                                                            encoding:NSUTF8StringEncoding
                                                               error:nil];
        if(content) {
          NSString *fault = [content substringWithRange:range];
          errorString = [NSString stringWithFormat:@"Parsing Error: Line %ld %@, found unexpected token: <%@>. Make sure you are not using a keyword where you are not supposed to.", line, parsingError.userInfo[@"range"], fault];
        }
      }
      
    }
    
    NSString *errorDomain = @"vega.generator.parsing";
    NSInteger errorCode   = 1005;
    NSString *info        = NSLocalizedString(@"Feature file couldn't be parsed.", @"feature file can't be parsed");
    NSString *resolution  = errorString;
    
    NSError *parsingError = [NSError errorWithDomain:errorDomain
                                                code:errorCode
                                            userInfo:@{NSLocalizedDescriptionKey:info,
                                                       NSFilePathErrorKey:featureFile,
                                                       NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = parsingError;
    return nil;
  }
  
  if (rawFeature != nil) {
    VGFeature *feature = [[VGFeature alloc] initWithDictionary:rawFeature];
    return [self.outputWriter automationScriptForFeature:feature];

  } else {
    NSString *errorDomain = @"vega.generator.parsing";
    NSInteger errorCode   = 1004;
    NSString *info        = NSLocalizedString(@"Feature couldn't be parsed", @"feature file can't be parsed");
    NSString *resolution  = NSLocalizedString(@"Correct the Feature file and try again", @"feature file can't be parsed resolution");
    
    NSError *fnfError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:featureFile,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fnfError;
    return nil;

  }
    
  
}


@end
