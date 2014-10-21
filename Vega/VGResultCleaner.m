//
//  VGResultCleaner.m
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGResultCleaner.h"

@interface VGResultCleaner ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation VGResultCleaner

- (instancetype)initWithFileManager:(NSFileManager*)fileManager
{
  self = [super init];
  if (self) {
    _fileManager = fileManager;
  }
  return self;
}

- (void)cleanupResultsAtPath:(NSString*)resultsPath error:(NSError**)error
{
  NSError *fileManagerError = nil;
  
  NSString *traceFile  = [resultsPath stringByAppendingPathComponent:@"instrumentscli0.trace"];
  NSString *reportFile = [resultsPath stringByAppendingPathComponent:@"report.pipe"];
  
  NSArray *filesToRemove = @[traceFile, reportFile];
  [self removeFiles:filesToRemove error:&fileManagerError];
  if (fileManagerError) {
    *error = fileManagerError;
    return;
  }
  
  NSString *folderToRename = [resultsPath stringByAppendingPathComponent:@"Run 1"];
  NSString *newFolderName  = [resultsPath stringByAppendingPathComponent:@"UIAResults"];

  [self renameResultFolderFrom:folderToRename
                            to:newFolderName
                         error:&fileManagerError];
  
  if (fileManagerError) {
    *error = fileManagerError;
    return;
  }


}

- (void)removeFiles:(NSArray*)filesToRemove error:(NSError**)error
{
  
  for (NSString *fileToRemove in filesToRemove) {
    
    NSError *fileManagerError = nil;
    
    if ([self.fileManager fileExistsAtPath:fileToRemove]) {
      [self.fileManager removeItemAtPath:fileToRemove
                                   error:&fileManagerError];
      if (fileManagerError) {
        NSString *errorDomain = @"vega.cleaner.removeFile";
        NSInteger errorCode   = 8001;
        NSString *info        = [NSLocalizedString(@"Error while removing the result file: ", @"can't remove file")
                                 stringByAppendingString:fileToRemove];
        NSString *recovery    = NSLocalizedString(@"Try deleting the result file and try again", @"can't remove file recovery");
        
        NSError *cleanupError = [NSError errorWithDomain:errorDomain
                                                    code:errorCode
                                                userInfo:@{NSLocalizedDescriptionKey:info,
                                                           NSFilePathErrorKey:fileToRemove,
                                                           NSLocalizedRecoverySuggestionErrorKey:recovery
                                                           }];
        
        *error = cleanupError;
        return;
        
      }
    }
    
  }
  
}

- (void)renameResultFolderFrom:(NSString*)oldName to:(NSString*)newName error:(NSError**)error
{
  BOOL isDirectory = NO;
  
  if ([self.fileManager fileExistsAtPath:newName]) {
    NSError *fileManagerError = nil;
    [self.fileManager removeItemAtPath:newName error:&fileManagerError];
    if (fileManagerError) {
      NSString *errorDomain = @"vega.cleaner.renameFolder";
      NSInteger errorCode   = 8002;
      NSString *info        = NSLocalizedString(@"Cannot erase old report folder.", @"can't remove result folder");
      NSString *recovery    = NSLocalizedString(@"Did the rights changed on the output folder?", @"remove result folder recovery");
      
      NSError *cleanupError = [NSError errorWithDomain:errorDomain
                                                  code:errorCode
                                              userInfo:@{NSLocalizedDescriptionKey:info,
                                                         NSFilePathErrorKey:oldName,
                                                         NSLocalizedRecoverySuggestionErrorKey:recovery}];
      
      *error = cleanupError;
      return;
      
    }
  }
  
  if ([self.fileManager fileExistsAtPath:oldName isDirectory:&isDirectory] && isDirectory) {
    
    NSError *fileManagerError = nil;
    [self.fileManager moveItemAtPath:oldName
                              toPath:newName
                               error:&fileManagerError];

    if (fileManagerError) {
      NSString *errorDomain = @"vega.cleaner.renameFolder";
      NSInteger errorCode   = 8003;
      NSString *info        = NSLocalizedString(@"Error while renaming the result folder.", @"can't rename result folder");
      NSString *recovery    = NSLocalizedString(@"Try to delete the old result folder", @"can't rename result folder recovery");
      
      NSError *cleanupError = [NSError errorWithDomain:errorDomain
                                                  code:errorCode
                                              userInfo:@{NSLocalizedDescriptionKey:info,
                                                         NSFilePathErrorKey:oldName,
                                                         NSLocalizedRecoverySuggestionErrorKey:recovery}];
      
      *error = cleanupError;
      return;

    }

  }
  
 
}


@end
