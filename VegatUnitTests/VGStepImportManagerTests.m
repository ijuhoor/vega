//
//  VGStepImportManagerTests.m
//  Vega
//
//  Created by Idriss on 21/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGStepsImportManager.h"

@interface VGStepImportManagerTestsFileManager : NSFileManager

@property (nonatomic, strong) NSArray *files;
@property (nonatomic)         BOOL     forceError;

@end

@implementation VGStepImportManagerTestsFileManager

- (NSArray*)contentsOfDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
  if (self.forceError) {
    *error = [NSError errorWithDomain:@"test" code:01 userInfo:nil];
    return nil;
  }
  return self.files;
}


@end

@interface VGStepImportManagerTests : XCTestCase

@end

@implementation VGStepImportManagerTests



- (void)testNoFiles
{
  VGStepImportManagerTestsFileManager *fileManager = [VGStepImportManagerTestsFileManager new];
  fileManager.files = @[];
  fileManager.forceError = NO;
  
  VGStepsImportManager *importManager = [[VGStepsImportManager alloc] initWithFileManager:fileManager];
  
  NSArray *import = [importManager stepsImportsForPath:@"p"];
  
  XCTAssertNotNil(import);
  XCTAssert([import count] == 0);
  
}

- (void)testNoJSFiles
{
  VGStepImportManagerTestsFileManager *fileManager = [VGStepImportManagerTestsFileManager new];
  fileManager.files = @[@"a.exe", @"b.png", @"poupio"];
  fileManager.forceError = NO;
  
  VGStepsImportManager *importManager = [[VGStepsImportManager alloc] initWithFileManager:fileManager];
  
  NSArray *import = [importManager stepsImportsForPath:@"p"];
  
  XCTAssertNotNil(import);
  XCTAssert([import count] == 0);
  
}

- (void)testOneJSFiles
{
  VGStepImportManagerTestsFileManager *fileManager = [VGStepImportManagerTestsFileManager new];
  fileManager.files = @[@"a.exe", @"b.png", @"poupio", @"step.js"];
  fileManager.forceError = NO;
  
  VGStepsImportManager *importManager = [[VGStepsImportManager alloc] initWithFileManager:fileManager];
  
  NSArray *import = [importManager stepsImportsForPath:@"p"];
  
  XCTAssertNotNil(import);
  XCTAssert([import count] == 1);
  XCTAssertEqualObjects(import[0], @"p/step.js");
  
}

- (void)testOneJSFilesUppercase
{
  VGStepImportManagerTestsFileManager *fileManager = [VGStepImportManagerTestsFileManager new];
  fileManager.files = @[@"a.exe", @"b.png", @"poupio", @"step.JS"];
  fileManager.forceError = NO;
  
  VGStepsImportManager *importManager = [[VGStepsImportManager alloc] initWithFileManager:fileManager];
  
  NSArray *import = [importManager stepsImportsForPath:@"p"];
  
  XCTAssertNotNil(import);
  XCTAssert([import count] == 1);
  XCTAssertEqualObjects(import[0], @"p/step.JS");
  
}

- (void)testError
{
  VGStepImportManagerTestsFileManager *fileManager = [VGStepImportManagerTestsFileManager new];
  fileManager.files = @[@"a.exe", @"b.png", @"poupio", @"step.js"];
  fileManager.forceError = YES;
  
  VGStepsImportManager *importManager = [[VGStepsImportManager alloc] initWithFileManager:fileManager];
  
  NSArray *import = [importManager stepsImportsForPath:@"p"];
  
  XCTAssertNotNil(import);
  XCTAssert([import count] == 0);
}

@end
