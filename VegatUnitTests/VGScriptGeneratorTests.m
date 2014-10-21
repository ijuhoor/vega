//
//  VGScriptGeneratorTests.m
//  Vega
//
//  Created by Idriss on 21/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGScriptGenerator.h"
#import "VGUIAutomationOutputWriter.h"
#import "VGFeatureGenerator.h"
#import "VGStepsImportManager.h"

#import "VGTagCloud.h"

@interface VGScriptGenerator ()

@property (nonatomic, strong) NSFileManager              *fileManager;
@property (nonatomic, strong) VGUIAutomationOutputWriter *outputWriter;
@property (nonatomic, strong) VGFeatureGenerator         *featureGenerator;
@property (nonatomic, strong) VGStepsImportManager       *stepImportManager;

@end

@interface VGTagCloud ()

@property (nonatomic, retain) NSMutableSet *includedTags;
@property (nonatomic, retain) NSMutableSet *excludedTags;

@end

@interface VGScriptGeneratorTests : XCTestCase

@end

@implementation VGScriptGeneratorTests


- (void)testSetTagString
{
  
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  [scriptGen setTagsString:@"tag1,tag2,~tag3"];
  
  VGTagCloud *tags = scriptGen.outputWriter.tagCloud;
  XCTAssert([tags.includedTags containsObject:@"tag1"]);
  XCTAssert([tags.includedTags containsObject:@"tag2"]);
  XCTAssert(![tags.includedTags containsObject:@"tag3"]);
  XCTAssert(![tags.includedTags containsObject:@"~tag3"]);
  
  XCTAssert([tags.excludedTags containsObject:@"tag3"]);
  XCTAssert(![tags.excludedTags containsObject:@"~tag3"]);
  XCTAssert(![tags.excludedTags containsObject:@"tag2"]);
  XCTAssert(![tags.excludedTags containsObject:@"tag1"]);
  
}

- (void)testSetNoTagString
{
  
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  [scriptGen setTagsString:@""];
  
  VGTagCloud *tags = scriptGen.outputWriter.tagCloud;
  XCTAssert([tags.includedTags count] == 0);
  XCTAssert([tags.excludedTags count] == 0);
  
}

- (void)testSetStepDirectoryNil
{
  
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  NSError *error = nil;
  [scriptGen setStepDirectory:nil error:&error];
  
  XCTAssertNotNil(error);
  XCTAssert(error.code == 1004);
}

- (void)testStepDirectoryDoesNotExist
{
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  NSError *error = nil;
  [scriptGen setStepDirectory:@"doesnotexistsdir" error:&error];
  
  XCTAssertNotNil(error);
  XCTAssert(error.code == 1002);
}

- (void)testStepDirectoryNotDirectory
{
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  NSError *error = nil;
  [scriptGen setStepDirectory:@"/dev/null" error:&error];
  
  XCTAssertNotNil(error);
  XCTAssert(error.code == 1003);
}

- (void)testStepDirectory
{
  VGScriptGenerator *scriptGen = [VGScriptGenerator new];
  
  NSError *error = nil;
  [scriptGen setStepDirectory:@"." error:&error];
  
  XCTAssertNil(error);
}

- (void)disabledtestGenerateScriptForFeature
{
  //Todo
  XCTAssert(YES, @"TODO");
}



@end
