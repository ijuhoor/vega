//
//  VGJavascriptAutomationFormatter.m
//  Vega
//
//  Created by Idriss on 10/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGJavascriptAutomationFormatter.h"
#import "VGFeature.h"
#import "VGBackground.h"
#import "VGScenarioOutline.h"
#import "VGScenario.h"
#import "VGStep.h"

@interface VGJavascriptAutomationFormatterTests : XCTestCase

@end

@implementation VGJavascriptAutomationFormatterTests

- (void)testWriteFeatureNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatFeature:nil];
  XCTAssertNil(res);
}

- (void)testWriteFeature
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *featureTitle = @"feature title";
  VGFeature *feature = [[VGFeature alloc] initWithDictionary:@{@"title": featureTitle}];
  
  NSString *res = [formatter formatFeature:feature];
  
  NSString *expectedString = [NSString stringWithFormat:@"testName = \"%@\"\nVGReport.reportStartFeature(testName)\nVGLogger.logStartFeature(testName)\n\n", featureTitle];
  
  XCTAssertEqualObjects(res, expectedString);
}

- (void)testWritePostFeatureNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  
  NSString *res = [formatter formatPostFeature:nil];
  NSString *expected = [NSString stringWithFormat:@"VGReport.reportEndFeature(testName)\n"];
  XCTAssertEqualObjects(res, expected);
}

- (void)testWritePostFeature
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *location = [[[NSFileManager alloc] init] currentDirectoryPath];
  
  NSString *res = [formatter formatPostFeature:nil];
  NSString *expected = [NSString stringWithFormat:@"VGReport.reportEndFeature(testName)\n"];
  XCTAssertEqualObjects(res, expected);
}

- (void)testWriteFormatImportsNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatImports:nil];
  XCTAssertNil(res);
  
}

- (void)testWriteFormatImportsEmpty
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatImports:@[]];
  XCTAssertEqualObjects(res, @"");
  
}

- (void)testWriteFormatImports
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatImports:@[@"../lib/javafile.js"]];
  XCTAssertEqualObjects(res, @"#import \"../lib/javafile.js\"\n");
  
  res = [formatter formatImports:@[@"../lib/javafile.js",@"../lib/javafile2.js"]];
  XCTAssertEqualObjects(res, @"#import \"../lib/javafile.js\"\n#import \"../lib/javafile2.js\"\n");
  
}

- (void)testWriteFormatVarsNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatVars:nil];
  XCTAssertNil(res);
}

- (void)testWriteFormatVarsEmpty
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatVars:@[]];
  XCTAssertEqualObjects(res, @"");
}

- (void)testWriteFormatVars
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  NSString *res = [formatter formatVars:@[@"i"]];
  XCTAssertEqualObjects(res, @"var i\n\n");
  
  res = [formatter formatVars:@[@"i", @"j"]];
  XCTAssertEqualObjects(res, @"var i, j\n\n");
}

- (void)testFormatBackgroundNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatBackground:nil];
  XCTAssertNil(res);
}

- (void)testFormatBackground
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  VGBackground *background = [[VGBackground alloc] initWithDictionary:@{@"title": @"background title"}];
  NSString *res = [formatter formatBackground:background];
  XCTAssertEqualObjects(res, @"steps = []\n");
}

- (void)testFormatPostBackgroundNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatPostBackground:nil];
  XCTAssertNil(res);
}

- (void)testFormatPostBackground
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  VGBackground *background = [[VGBackground alloc] initWithDictionary:@{@"title": @"background title"}];
  NSString *res = [formatter formatPostBackground:background];
  XCTAssertEqualObjects(res, @"performBackground(steps)\n\n");
}

- (void)testFormatOutlineNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatOutline:nil exampleNumber:0];
  XCTAssertNil(res);
  
}

- (void)testFormatOutline
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  VGScenarioOutline *outlineNoTitle = [[VGScenarioOutline alloc] initWithDictionary:@{}];
  NSString *res = [formatter formatOutline:outlineNoTitle exampleNumber:0];

  XCTAssertEqualObjects(res, @"scenarioName = \"untitled case 0\"\nsteps = []\n");
  

  VGScenarioOutline *outline = [[VGScenarioOutline alloc] initWithDictionary:@{@"title": @"outline title"}];
  res = [formatter formatOutline:outline exampleNumber:0];
  
  XCTAssertEqualObjects(res, @"scenarioName = \"outline title case 0\"\nsteps = []\n");
  
  res = [formatter formatOutline:outline exampleNumber:1];
  
  XCTAssertEqualObjects(res, @"scenarioName = \"outline title case 1\"\nsteps = []\n");
  
}

- (void)testFormatPostOutlineNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatPostOutline:nil exampleNumber:0];
  XCTAssertNil(res);
  
}

- (void)testFormatPostOutline
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  VGScenarioOutline *outlineNoTitle = [[VGScenarioOutline alloc] initWithDictionary:@{}];
  NSString *res = [formatter formatPostOutline:outlineNoTitle exampleNumber:0];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
  
  VGScenarioOutline *outline = [[VGScenarioOutline alloc] initWithDictionary:@{@"title": @"outline title"}];
  res = [formatter formatPostOutline:outline exampleNumber:0];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
  res = [formatter formatPostOutline:outline exampleNumber:1];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
}


- (void)testFormatScenarioNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatScenario:nil];
  XCTAssertNil(res);
  
}

- (void)testFormatScenario
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  VGScenario *scenarioEmpty = [[VGScenario alloc] initWithDictionary:@{}];
  NSString *res = [formatter formatScenario:scenarioEmpty];
  
  XCTAssertEqualObjects(res, @"scenarioName = \"untitled\"\nsteps = []\n");
  
  
  VGScenario *scenario = [[VGScenario alloc] initWithDictionary:@{@"title": @"scenario title"}];
  res = [formatter formatScenario:scenario];
  
  XCTAssertEqualObjects(res, @"scenarioName = \"scenario title\"\nsteps = []\n");
  
  res = [formatter formatScenario:scenario];
  
  XCTAssertEqualObjects(res, @"scenarioName = \"scenario title\"\nsteps = []\n");
  
}

- (void)testFormatPostScenarioNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  NSString *res = [formatter formatPostScenario:nil];
  XCTAssertNil(res);
  
}

- (void)testFormatPostScenario
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];
  
  VGScenario *scenarioEmpty = [[VGScenario alloc] initWithDictionary:@{}];
  NSString *res = [formatter formatPostScenario:scenarioEmpty];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
  
  VGScenario *scenario = [[VGScenario alloc] initWithDictionary:@{@"title": @"scenario title"}];
  res = [formatter formatPostScenario:scenario];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
  res = [formatter formatPostScenario:scenario];
  
  XCTAssertEqualObjects(res, @"performScenario(scenarioName, steps)\n\n");
  
}

- (void)testFormatStepNil
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];

  NSString *res = [formatter formatStep:nil];
  XCTAssertNil(res);

}

- (void)testFormatStep
{
  VGJavascriptAutomationFormatter *formatter = [VGJavascriptAutomationFormatter new];

  VGStep *emptyStep = [[VGStep alloc] initWithDictionary:@{}];
  NSString *res = [formatter formatStep:emptyStep];
  XCTAssertNil(res);
  
  VGStep *stepWithDataOnly = [[VGStep alloc] initWithDictionary:@{@"data":@[@"a", @"b"]}];
  res = [formatter formatStep:stepWithDataOnly];
  XCTAssertNil(res);
  
  VGStep *stepWithMethoOnly = [[VGStep alloc] initWithDictionary:@{@"method":@"poupipo poupi"}];
  res = [formatter formatStep:stepWithMethoOnly];
  
  XCTAssertEqualObjects(res, @"steps.push({'expr':\"poupipo poupi\"})");
  
  VGStep *stepWithMethodAndData = [[VGStep alloc] initWithDictionary:@{@"method":@"poupipo poupi",
                                                                      @"data":@[@"a", @"b"]}];
  res = [formatter formatStep:stepWithMethodAndData];
  XCTAssertEqualObjects(res, @"steps.push({'expr':\"poupipo poupi\", 'args':[\"a\",\"b\"]})");
  
  
  VGStep *stepWithWeirdShit = [[VGStep alloc] initWithDictionary:@{@"method":@"poupipo poupi (.*)\b *@#^",
                                                                   @"data":@[@"a asf asf12 ", @"b 12r12r2121"]}];
  res = [formatter formatStep:stepWithWeirdShit];
  XCTAssertEqualObjects(res, @"steps.push({'expr':\"poupipo poupi (.*)\b *@#^\", 'args':[\"a asf asf12 \",\"b 12r12r2121\"]})");

  
}

@end
