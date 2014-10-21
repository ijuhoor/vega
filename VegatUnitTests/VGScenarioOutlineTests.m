//
//  VGScenarioOutlineTests.m
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGScenarioOutline.h"

@interface VGScenarioOutlineTests : XCTestCase

@end

@implementation VGScenarioOutlineTests


- (void)testNumberOfExamples
{
  
  NSDictionary *scnDict = @{@"outline" : [NSNumber numberWithBool:YES],
                            @"steps"   : @[@{@"method"  : @"I see the \"<pagename>\" page",
                                             @"pattern" : @"Given"}],
                            @"example" : @{@"pagename"  : @[@"home", @"Main"]}};
  
  VGScenarioOutline *scenarioOutline = [[VGScenarioOutline alloc] initWithDictionary:scnDict];
  
  NSInteger numberOfExamples = [scenarioOutline numberOfExamples];
  
  XCTAssertEqual(numberOfExamples, 2);
  

}



@end
