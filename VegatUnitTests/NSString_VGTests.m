//
//  NSString_VGTests.m
//  Vega
//
//  Created by Idriss on 21/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "NSString+VG.h"

@interface NSString_VGTests : XCTestCase

@end

@implementation NSString_VGTests


- (void)testStringTrimNoWhiteSpaces {

  NSString *string1 = @"abc";
  
  NSString *trimmed = [string1 stringbyTrimmingWhitespaces];
  
  XCTAssertEqualObjects(@"abc", trimmed);
  
}

- (void)testStringTrimWhitespaces {
  
  NSString *string1 = @"  abc  ";
  
  NSString *trimmed = [string1 stringbyTrimmingWhitespaces];
  
  XCTAssertEqualObjects(@"abc", trimmed);
  
}

- (void)testStringTrimTabs {
  
  NSString *string1 = @"\tabc\t";
  
  NSString *trimmed = [string1 stringbyTrimmingWhitespaces];
  
  XCTAssertEqualObjects(@"abc", trimmed);
  
}

- (void)testStringTrimMixedWhitespaces {
  
  NSString *string1 = @"\t abc\t ";
  
  NSString *trimmed = [string1 stringbyTrimmingWhitespaces];
  
  XCTAssertEqualObjects(@"abc", trimmed);
  
}

@end
