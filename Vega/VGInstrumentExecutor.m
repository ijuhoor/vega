//
//  VGInstrumentExecutor.m
//  Vega
//
//  Created by Idriss on 03/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGInstrumentExecutor.h"

@interface VGInstrumentExecutor ()


@end

@implementation VGInstrumentExecutor

- (instancetype)init
{
  self = [super init];
  if (self) {
    _instrumentRunPath = @"/usr/bin/instruments";
    _instrumentTemplateFilePath = @"Automation";
  }
  return self;
}

- (NSInteger)runInstrumentWithOutputBlock:(void(^)(NSString * output))outputBlock error:(NSError**)error
{
  
  if (!self.bundleId) {
    
    NSString *errorDomain = @"vega.executor.nobundleid";
    NSInteger errorCode   = 4001;
    NSString *info        = NSLocalizedString(@"No bundleId",@"no bundle id");
    NSString *recovery    = NSLocalizedString(@"Provide a bundleId", @"no bundle recovery");
    
    NSError *executionError = [NSError errorWithDomain:errorDomain
                                                  code:errorCode
                                              userInfo:@{NSLocalizedDescriptionKey:info,
                                                         NSLocalizedRecoverySuggestionErrorKey:recovery}];
    *error = executionError;
    return errorCode;
    
  } else if (!self.deviceId) {
    
    NSString *errorDomain = @"vega.executor.nodeviceid";
    NSInteger errorCode   = 4002;
    NSString *info        = NSLocalizedString(@"No deviceId",@"no device id");
    NSString *recovery    = NSLocalizedString(@"Provide a deviceId", @"no deviceid recovery");
    
    NSError *executionError = [NSError errorWithDomain:errorDomain
                                                  code:errorCode
                                              userInfo:@{NSLocalizedDescriptionKey:info,
                                                         NSLocalizedRecoverySuggestionErrorKey:recovery}];
    *error = executionError;
    return errorCode;

  }
  
  NSTask *instrumentsTask = [[NSTask alloc] init];
  
  NSPipe *p = [[NSPipe alloc] init];
  [instrumentsTask setStandardOutput:p];
  [instrumentsTask setStandardError:p];
  
  instrumentsTask.launchPath = self.instrumentRunPath;
  
  NSMutableArray *arguments = [NSMutableArray array];
  [arguments addObjectsFromArray:@[@"-t", self.instrumentTemplateFilePath,
                                   @"-w", self.deviceId,
                                   self.bundleId]];
  
  for (NSString *script in self.scripts) {
    [arguments addObjectsFromArray:@[@"-e", @"UIASCRIPT", script]];
  }
  
  if (self.outputFolder) {
    [arguments addObjectsFromArray:@[@"-e", @"UIARESULTSPATH", self.outputFolder]];
  }
  
  instrumentsTask.arguments = arguments;
  
  @try {
    [instrumentsTask launch];
  }
  @catch (NSException *exception) {
    
    NSString *errorDomain = @"vega.executor.noinstruments";
    NSInteger errorCode   = 4003;
    NSString *info        = NSLocalizedString(@"Can't find instruments",@"no instruments");
    NSString *recovery    = NSLocalizedString(@"Install the Xcode tools", @"no instruments recovery");
    
    NSError *executionError = [NSError errorWithDomain:errorDomain
                                                  code:errorCode
                                              userInfo:@{NSLocalizedDescriptionKey:info,
                                                         NSLocalizedRecoverySuggestionErrorKey:recovery}];
    *error = executionError;
    return errorCode;
    
  }
  
  // Prepare to read
  NSFileHandle *readHandle = [p fileHandleForReading];
  NSData *inData = nil;
  NSString *errorMessage = nil;
  while ((inData = [readHandle availableData]) && [inData length]) {
    NSString *outputStr = [[NSString alloc] initWithData:inData encoding:NSUTF8StringEncoding];
    //break for each line
    NSArray *lines = [outputStr componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *line in lines) {
      if (line && [line length] > 0) {
        if (outputBlock) {
          outputBlock(line);
        }
        errorMessage = [self recordUIAutomationError:line];
      }
    }
  }
  
  [instrumentsTask waitUntilExit];

  int returnCode = [instrumentsTask terminationStatus];
  if (returnCode != 0) {
    
    NSString *errorDomain = @"vega.executor.instruments";
    NSInteger errorCode   = 4100 + returnCode;
    NSString *info        = NSLocalizedString(@"instrument raised an error.", @"exec instrument error");
    NSString *recovery    = errorMessage? errorMessage : @"";
    
    NSError *executionError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSLocalizedRecoverySuggestionErrorKey:recovery}];
    *error = executionError;
    return errorCode;
  }
  
  return returnCode;
  
}

- (NSString*)recordUIAutomationError:(NSString*)input
{
  
  if ([input hasPrefix:@"Instruments Trace Error "]) {
    return input;
  }
  return nil;
}


@end
