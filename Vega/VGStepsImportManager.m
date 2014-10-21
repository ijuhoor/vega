//
//  VGStepsImportManager.m
//  Vega
//
//  Created by Juhoor, Idriss on 17/09/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGStepsImportManager.h"

@interface VGStepsImportManager ()

@property (nonatomic, retain) NSFileManager *fileManager;

@end

@implementation VGStepsImportManager

- (instancetype)initWithFileManager:(NSFileManager*)fileManager
{
  self = [super init];
  if (self) {
    self.fileManager = fileManager;
  }
  return self;
}

- (NSArray*)stepsImportsForPath:(NSString*)path
{
  NSArray *files = [self filesAtPath:path];
  NSMutableArray *fullPathImportFiles = [NSMutableArray array];
  
  for (NSString *file in files) {
    if ([[[file pathExtension] lowercaseString] isEqualToString:@"js"]) {
      [fullPathImportFiles addObject:[path stringByAppendingPathComponent:file]];
    }
  }
  
  _stepImports = [NSArray arrayWithArray:fullPathImportFiles];
  
  return _stepImports;
}

#pragma mark __private

- (NSArray*)filesAtPath:(NSString*)path
{
  NSError *error = nil;
  NSArray *files = [self.fileManager contentsOfDirectoryAtPath:path
                                                         error:&error];
  
  if (error) {
    return nil;
  }
  return files;
}

@end
