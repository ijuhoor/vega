//
//  main.m
//  Vega
//
//  Created by Juhoor, Idriss on 28/07/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VGInstrumentExecutor.h"

#import "VGOutputFormatter.h"
#import "VGColoredOutputFormatter.h"
#import "VGInitializer.h"

#import "VGScriptGenerator.h"

#import "VGResultParser.h"
#import "VGJUnitResultOutputFormatter.h"

#import "VGResultCleaner.h"

int dealWithError(NSError* error);
int initDirectory(NSString *initPath);
int printHelp();

int main(int argc, const char * argv[])
{
  
  @autoreleasepool {
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if (argc > 1) {
      
      NSString *param = [NSString stringWithUTF8String:argv[1]];
      if ([param isEqualToString:@"-init"]) {
        
        NSString *initPath = [[standardDefaults valueForKey:@"path"] stringByExpandingTildeInPath];
        if (!initPath) {
          initPath = @".";
        }
       
        return initDirectory(initPath);
      } else if ([param isEqualToString:@"-help"]) {
        return printHelp();
      }
    }
    
    NSString *stepsIncludes = [[standardDefaults valueForKey:@"steps"] stringByExpandingTildeInPath];
    NSString *featureFiles  = [standardDefaults valueForKey:@"features"];
    NSString *output        = [[standardDefaults valueForKey:@"output"] stringByExpandingTildeInPath];
    NSString *bundleId      = [[standardDefaults valueForKey:@"bundleid"] stringByExpandingTildeInPath];
    NSString *deviceId      = [standardDefaults valueForKey:@"deviceid"];
    NSString *tagsString    = [standardDefaults valueForKey:@"tags"];
    NSString *reporter      = [standardDefaults valueForKey:@"reporter"];
    
    
    if (!output) {
      output = @".";
    }
    
    if (!stepsIncludes) {
      stepsIncludes = @"./steps/";
    }
    
    if (!reporter) {
      reporter = @"pretty";
    }
    
    NSError *error = nil;
    VGScriptGenerator *scriptGenerator = [VGScriptGenerator new];
    [scriptGenerator setTagsString:tagsString];
    [scriptGenerator setStepDirectory:stepsIncludes error:&error];
    if (error) {
      int errorCode = dealWithError(error);
      return errorCode;
    }

    
    NSString *scriptFile = @"main.js";
    [scriptGenerator generateScriptWithFilename:scriptFile
                                forFeatureFiles:featureFiles
                                          error:&error];
    if (error) {
      int errorCode = dealWithError(error);
      return errorCode;
    }
    
    id<VGOutputFormatter> formatter = [[VGColoredOutputFormatter alloc] init];
    [formatter setHideDebug:YES];
    
    VGInstrumentExecutor *executor = [[VGInstrumentExecutor alloc] init];
    executor.bundleId = bundleId;
    executor.deviceId = deviceId;
    executor.scripts  = @[scriptFile];
    executor.outputFolder = output;
    
    bool shouldProcessOutput = NO;
    if ([reporter isEqualToString:@"pretty"]) {
      shouldProcessOutput = YES;
    }
    
    NSError *instrumentError;
    [executor runInstrumentWithOutputBlock:^(NSString *output) {
              if (output) {
                NSString *formattedString = [formatter formattedStringForString:output];
                if (formattedString && shouldProcessOutput) {
                  const char *s = [formattedString cStringUsingEncoding:NSUTF8StringEncoding];
                  fprintf(stdout, "%s\n",s);
                }
              }
            }
            error:&instrumentError];
    
    
    if (instrumentError) {
      int errorCode = dealWithError(instrumentError);
      return errorCode;
    }
    
    if (reporter) {
      if ([reporter isEqualToString:@"junit"]) {
        NSError *reporterError = nil;
        VGJUnitResultOutputFormatter *junitFormatter = [[VGJUnitResultOutputFormatter alloc] init];
        VGResultParser *resultParser = [[VGResultParser alloc] initWithOutputFormatter:junitFormatter];
        NSString* junitOutput = [resultParser formatAtFilePath:@"report.pipe"
                                                         error:&reporterError];
        if (reporterError) {
          int errorCode = dealWithError(reporterError);
          return errorCode;
        }
        
        fprintf(stdout, "%s\n",[junitOutput cStringUsingEncoding:NSUTF8StringEncoding]);
        
      }
    }
    
    NSError *cleanupError = nil;
    VGResultCleaner *resultCleaner = [[VGResultCleaner alloc] initWithFileManager:[NSFileManager defaultManager]];
    [resultCleaner cleanupResultsAtPath:output error:&cleanupError];
    
    if (cleanupError) {
      int errorCode = dealWithError(cleanupError);
      return errorCode;

    }
    
  }

  //All gud!
  return 0;
}

int dealWithError(NSError* error)
{
  fprintf(stderr, "Error (%d): %s %s\n",
          (int)error.code,
          [error.localizedDescription cStringUsingEncoding:NSUTF8StringEncoding],
          [error.localizedRecoverySuggestion cStringUsingEncoding:NSUTF8StringEncoding]);
  return (int)error.code;
}

int initDirectory(NSString *initPath)
{
  NSError *error = nil;
  VGInitializer *initializer = [[VGInitializer alloc] initWithFileManager:[NSFileManager defaultManager]];
  [initializer initializeDirectoryAtPath:initPath error:&error];
  
  if (error) {
    int code = dealWithError(error);
    return code;
  }
  
  return 0;
}

int printHelp()
{
  printf("Usage:\n");
  printf("vega -init [-path <path to initialize>]\n");
  printf("vega -help\n");
  printf("vega [-step <step folder>] -features <feature files> -deviceid <deviceid> -bundleid <bundleid> [-tags] [-reporter junit] [-output <output path>]\n");
  printf("Options:\n");
  printf("-init:       initialize the directory. If none are given, the current working directory will be used\n");
  printf("-help:       prints this\n");
  printf("-feature:    all the feature files to be executed: the feature files are comma separated with no space: feature1.feature,feature2.feature\n");
  printf("-deviceid:   the device to run the test on\n");
  printf("-bundleid:   the bundleID of the app to test\n");
  printf("-step:       the directory containing the steps. If none are given, ./steps/ will be used\n");
  printf("-tags:       tags to be executed or excluded(~). The tags shoud be comma separated with no space: tag1,tag2,~tag3\n");
  printf("-reporter:   use a custom reporter tool\n");
  printf("-output:     the folder where the reports will be generated\n");
  
  return 0;
}
