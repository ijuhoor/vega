//
//  VGInstrumentExecutorTests.m
//  Vega
//
//  Created by Idriss on 21/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGInstrumentExecutor.h"

@interface VGInstrumentExecutorTests : XCTestCase

@end

@implementation VGInstrumentExecutorTests


- (void)testDefaultParams
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  
  XCTAssertEqualObjects(executor.instrumentRunPath, @"/usr/bin/instruments");
  XCTAssertEqualObjects(executor.instrumentTemplateFilePath, @"Automation");
  
  XCTAssertNil(executor.deviceId);
  XCTAssertNil(executor.bundleId);
  
  XCTAssertNil(executor.scripts);
  XCTAssertNil(executor.outputFolder);
  
}


- (void)testNoBundleId
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/bin/echo";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.deviceId = @"deviceid";
  
  NSError *error = nil;
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:nil error:&error];
  
  XCTAssert(returnCode == 4001);
  XCTAssertNotNil(error);
  
}

- (void)testNoDeviceId
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/bin/echo";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.bundleId = @"bundleid";
  
  NSError *error = nil;
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:nil error:&error];
  
  XCTAssert(returnCode == 4002);
  XCTAssertNotNil(error);
  
}

- (void)testNoOutputBlock
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/bin/echo";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.bundleId = @"bundleid";
  executor.deviceId = @"deviceid";
  
  NSError *error = nil;
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:nil error:&error];
  
  XCTAssert(returnCode == 0);
  XCTAssertNil(error);
  
}

- (void)testParams
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/bin/echo";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.bundleId = @"bundleid";
  executor.deviceId = @"deviceid";
  
  executor.scripts = @[@"script"];
  executor.outputFolder = @"/dev/null";
  
  NSError *error = nil;
  NSMutableString *outputString = [NSMutableString new];
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:^(NSString *output){
    [outputString appendString:output];
  }
                                                          error:&error];
  
  XCTAssert(returnCode == 0);
  XCTAssertNil(error);
  XCTAssertEqualObjects(outputString, @"-t Automation -w deviceid bundleid -e UIASCRIPT script -e UIARESULTSPATH /dev/null");
  
}

- (void)testExecutionCantFindExecutable
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/bin/ech";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.bundleId = @"bundleid";
  executor.deviceId = @"deviceid";
  
  executor.scripts = @[@"script"];
  executor.outputFolder = @"/dev/null";
  
  NSError *error = nil;
  
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:nil error:&error];
  
  XCTAssert(returnCode == 4003);
  XCTAssertNotNil(error);
 
}


- (void)testExecutionError
{
  VGInstrumentExecutor *executor = [VGInstrumentExecutor new];
  executor.instrumentRunPath = @"/usr/bin/sed";
  executor.instrumentTemplateFilePath = @"Automation";
  
  executor.bundleId = @"bundleid";
  executor.deviceId = @"deviceid";
  
  executor.scripts = @[@"script"];
  executor.outputFolder = @"/dev/null";
  
  NSError *error = nil;
  NSMutableString *outputString = [NSMutableString new];
  NSInteger returnCode = [executor runInstrumentWithOutputBlock:^(NSString *output){
    [outputString appendString:output];
  }
                                                          error:&error];
  
  XCTAssert(returnCode >= 4100 && returnCode < 4200);
  XCTAssertNotNil(error);
  
  
}

@end
