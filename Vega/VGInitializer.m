//
//  VGInitializer.m
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGInitializer.h"
#import "VGJavascriptCoreImports.h"

#define CORE_DIR @"core"
#define STEP_DIR @"steps"

#define COREJSCOREFILENAME      @"core.js"
#define COREJSINTERNALSFILENAME @"internals.js"

#define EXAMPLEFEATUREFILENAME  @"Feature1.feature"
#define EXAMPLESTEPFILENAME     @"ExampleSteps.js"

@interface VGInitializer ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation VGInitializer

- (instancetype)initWithFileManager:(NSFileManager*)fileManager
{
  self = [super init];
  if (self) {
    _fileManager = fileManager;
  }
  return self;
}

- (void)initializeDirectoryAtPath:(NSString*)path error:(NSError**)error
{
  
  NSString *stepsDir = [path stringByAppendingPathComponent:STEP_DIR];
 
  if (![self.fileManager fileExistsAtPath:stepsDir]) {
  
    NSError *fileError = nil;
    [self.fileManager createDirectoryAtPath:stepsDir
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:&fileError];
    if (fileError) {
      *error = fileError;
      return;
    }
    
  }

  
  
  NSString *coreDir = [path stringByAppendingPathComponent:CORE_DIR];
  
  if ([self.fileManager fileExistsAtPath:coreDir]) {
    
    NSString *errorDomain = @"vega.initialization.corelib";
    NSInteger errorCode   = 2001;
    NSString *info        = NSLocalizedString(@"This directory is already initialized: the Core folder already exists", @"Core lib already exists");
    NSString *resolution  = NSLocalizedString(@"Delete the Core folder if re-initializaiton is needed", @"Core lib exists resolution");

    NSError *fileExistsError = [NSError errorWithDomain:errorDomain
                                                   code:errorCode
                                               userInfo:@{NSLocalizedDescriptionKey:info,
                                                          NSFilePathErrorKey:coreDir,
                                                          NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = fileExistsError;
    return;
  }
  
  NSError *fileError = nil;
  [self.fileManager createDirectoryAtPath:coreDir
              withIntermediateDirectories:YES
                               attributes:nil
                                    error:&fileError];

  if (fileError) {

    *error = fileError;
    return;
  }
  
  [self injectCoreIntoDirectoryAtPath:coreDir error:&fileError];
  
  if (fileError) {
    *error = fileError;
    return;
  }
  
  [self createFeatureExampleAtPath:path error:&fileError];
  if (fileError) {
    *error = fileError;
    return;
  }
  
  NSString *stepPath = [path stringByAppendingPathComponent:STEP_DIR];
  [self createStepExampleAtPath:stepPath error:&fileError];
  if (fileError) {
    *error = fileError;
    return;
  }
  
}



- (void)injectCoreIntoDirectoryAtPath:(NSString*)directoryPath error:(NSError**)error
{

  NSData *coreJSData = [[NSData alloc] initWithBase64EncodedString:b64CoreJS
                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  NSString *coreFileName = [directoryPath stringByAppendingPathComponent:COREJSCOREFILENAME];
  
  NSError *fileWriteError = nil;
  [coreJSData writeToFile:coreFileName
                  options:NSDataWritingAtomic
                    error:&fileWriteError];
  if (fileWriteError) {
    
    return;
  }
  
  NSData *internalsJSData = [[NSData alloc] initWithBase64EncodedString:b64InternalsJS
                                                                options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  NSString *internalsFileName = [directoryPath stringByAppendingPathComponent:COREJSINTERNALSFILENAME];
  
  [internalsJSData writeToFile:internalsFileName
                  options:NSDataWritingAtomic
                    error:&fileWriteError];
  if (fileWriteError) {
    
    return;
  }
  
  
}

- (void)createFeatureExampleAtPath:(NSString*)directoryPath error:(NSError**)error
{
  NSData *featureData = [[NSData alloc] initWithBase64EncodedString:b64FeatureFile
                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  NSString *featureFileName = [directoryPath stringByAppendingPathComponent:EXAMPLEFEATUREFILENAME];
  
  NSError *fileWriteError = nil;
  [featureData writeToFile:featureFileName
                   options:NSDataWritingAtomic
                     error:&fileWriteError];
  if (fileWriteError) {
    
    return;
  }
  
}

- (void)createStepExampleAtPath:(NSString*)directoryPath error:(NSError**)error
{
  NSData *stepData = [[NSData alloc] initWithBase64EncodedString:b64FeatureFile
                                                         options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  NSString *stepFileName = [directoryPath stringByAppendingPathComponent:EXAMPLESTEPFILENAME];
  
  NSError *fileWriteError = nil;
  [stepData writeToFile:stepFileName
                options:NSDataWritingAtomic
                  error:&fileWriteError];
  if (fileWriteError) {
    
    return;
  }

}

@end
