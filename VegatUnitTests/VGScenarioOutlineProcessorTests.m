//
//  VGScenarioOutlineProcessorTests.m
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGScenarioOutlineProcessor.h"

@interface VGScenarioOutlineProcessorTests : XCTestCase

@end

@implementation VGScenarioOutlineProcessorTests

- (void)testExampleWithScenarioExample1Key2Values
{

  NSDictionary *exampleDict1Key2Values = @{@"keyA": @[@"valueA1", @"valueA2"]};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *result = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:0];
  
  XCTAssertEqualObjects(result[@"keyA"], @"valueA1");
  XCTAssertEqual([[result allKeys] count], 1);
  
  NSDictionary *result2 = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:1];
  
  XCTAssertEqualObjects(result2[@"keyA"], @"valueA2");
  XCTAssertEqual([[result2 allKeys] count], 1);
 
  NSDictionary *result3 = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:2];
  
  XCTAssertNil(result3);
  
}

- (void)testExampleWithScenarioExample2Key1Values
{
  
  NSDictionary *exampleDict1Key2Values = @{@"keyA": @[@"valueA1"],
                                           @"keyB": @[@"valueB1"]};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *result = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:0];
  
  XCTAssertEqualObjects(result[@"keyA"], @"valueA1");
  XCTAssertEqualObjects(result[@"keyB"], @"valueB1");
  XCTAssertEqual([[result allKeys] count], 2);
  
  NSDictionary *result2 = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:1];
  
  XCTAssertNil(result2);
  
}

- (void)testExampleWithScenarioNilExample
{
  
  NSDictionary *exampleDict1Key2Values = nil;
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *result = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:0];
  
  XCTAssertNil(result);
  
}

- (void)testExampleWithScenarioEmptyExample
{
  
  NSDictionary *exampleDict1Key2Values = @{};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *result = [sop exampleWithScenarioExample:exampleDict1Key2Values forIndex:0];
  
  XCTAssertNil(result);
  
}

- (void)testApplyExampleOneKey
{
  
  NSDictionary *exampleDict1Key1Values = @{@"keyA": @"valueA1"};
  NSDictionary *stepDict = @{@"method":@"I see the \"<keyA>\" page"};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *stepWithAppliedExample = [sop applyExample:exampleDict1Key1Values toStep:stepDict];
  
  XCTAssertEqualObjects(stepWithAppliedExample[@"method"], @"I see the \"valueA1\" page");
  
}

- (void)testApplyExampleTwoKeys
{
  
  NSDictionary *exampleDict2Key1Values = @{@"keyA": @"valueA1isLong",
                                           @"keyB": @"valueB1"};
  NSDictionary *stepDict = @{@"method":@"I see both \"<keyA>\" and \"<keyB>\" pages"};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *stepWithAppliedExample = [sop applyExample:exampleDict2Key1Values toStep:stepDict];
  
  XCTAssertEqualObjects(stepWithAppliedExample[@"method"], @"I see both \"valueA1isLong\" and \"valueB1\" pages");
  
}

- (void)testApplyExampleTwoKeysWithNumber
{
  
  NSDictionary *exampleDict2Key1Values = @{@"keyA": @"valueA1isLong",
                                           @"keyB": @1};
  NSDictionary *stepDict = @{@"method":@"I see page \"<keyA>\" and touch <keyB> time"};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *stepWithAppliedExample = [sop applyExample:exampleDict2Key1Values toStep:stepDict];
  
  XCTAssertEqualObjects(stepWithAppliedExample[@"method"], @"I see page \"valueA1isLong\" and touch 1 time");
  
}

- (void)testApplyExampleOneKeyAndData
{
  
  NSDictionary *exampleDict1Key1Values = @{@"keyA": @"valueA1"};
  NSDictionary *stepDict = @{@"method":@"I see the \"<keyA>\" page",
                             @"data"  :@[@"value1", @"value2"]};
  
  VGScenarioOutlineProcessor *sop = [VGScenarioOutlineProcessor new];
  
  NSDictionary *stepWithAppliedExample = [sop applyExample:exampleDict1Key1Values toStep:stepDict];
  
  XCTAssertEqualObjects(stepWithAppliedExample[@"method"], @"I see the \"valueA1\" page");
  XCTAssertEqualObjects(stepWithAppliedExample[@"data"][0], @"value1");
  XCTAssertEqualObjects(stepWithAppliedExample[@"data"][1], @"value2");
  
}




@end
