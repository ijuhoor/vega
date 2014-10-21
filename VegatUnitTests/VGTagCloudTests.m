//
//  VGTagCloudTests.m
//  Vega
//
//  Created by Idriss on 17/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGTagCloud.h"

@interface VGTagCloud ()

@property (nonatomic, retain) NSMutableSet *includedTags;
@property (nonatomic, retain) NSMutableSet *excludedTags;

@end

@interface VGTagCloudTests : XCTestCase

@end

@implementation VGTagCloudTests

- (void)testExampleIncludeNilTag
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  [tagCloud includeTag:nil];
  
  XCTAssert([tagCloud.includedTags count] == 0);
  XCTAssert([tagCloud.excludedTags count] == 0);
  
}


- (void)testExampleIncludeTag
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  [tagCloud includeTag:@"tag"];
  
  XCTAssert([tagCloud.includedTags containsObject:@"tag"]);
  XCTAssert(![tagCloud.excludedTags containsObject:@"tag"]);
  
}

- (void)testExampleExcludeNilTag
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  [tagCloud exludeTag:nil];
  
  XCTAssert([tagCloud.includedTags count] == 0);
  XCTAssert([tagCloud.excludedTags count] == 0);
  
}


- (void)testExampleExcludeTag
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  [tagCloud exludeTag:@"tag"];
  
  XCTAssert(![tagCloud.includedTags containsObject:@"tag"]);
  XCTAssert([tagCloud.excludedTags containsObject:@"tag"]);
  
}

- (void)testUseTag
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  tagCloud.includedTags = [NSMutableSet setWithObjects:@"t1",nil];

  XCTAssert([tagCloud useTag:@"t1"]);
  
  tagCloud.excludedTags = [NSMutableSet setWithObjects:@"t2",nil];

  XCTAssert(![tagCloud useTag:@"t2"]);
  
  tagCloud.includedTags = [NSMutableSet setWithObjects:@"t3",nil];
  tagCloud.excludedTags = [NSMutableSet setWithObjects:@"t3",nil];
  
  XCTAssert(![tagCloud useTag:@"t3"]);

}

- (void)testUseTags
{
  VGTagCloud *tagCloud = [[VGTagCloud alloc] init];
  
  tagCloud.includedTags = [NSMutableSet setWithObjects:@"t1",nil];
  
  XCTAssert([tagCloud useTags:@[@"t1"]]);
  
  tagCloud.excludedTags = [NSMutableSet setWithObjects:@"t2",nil];
  
  XCTAssert(![tagCloud useTags:@[@"t2"]]);
  
  tagCloud.includedTags = [NSMutableSet setWithObjects:@"t3",nil];
  tagCloud.excludedTags = [NSMutableSet setWithObjects:@"t3",nil];
  
  XCTAssert(![tagCloud useTags:@[@"t3"]]);
  
  BOOL b = [tagCloud useTags:@[@"t1", @"t2", @"t3"]];
  XCTAssert(!b);
  
  
  tagCloud.includedTags = [NSMutableSet setWithObjects:@"t1", @"t5",nil];
  
  BOOL b2 = [tagCloud useTags:@[@"t1", @"t5"]];
  XCTAssert(b2);
  
}



@end
