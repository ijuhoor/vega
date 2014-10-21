//
//  NSMutableString_VGTests.m
//  Vega
//
//  Created by Idriss on 21/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "NSMutableString+VG.h"

@interface NSMutableString_VGTests : XCTestCase

@end

@implementation NSMutableString_VGTests


- (void)testAppendNonNilString {
  
  NSMutableString *string1 = [NSMutableString stringWithString:@"test"];
  
  [string1 appendStringOrNil:@"test"];
  
  XCTAssertEqualObjects(string1, @"testtest");
}

- (void)testAppendNilString {
  
  NSMutableString *string1 = [NSMutableString stringWithString:@"test"];
  
  [string1 appendStringOrNil:nil];
  
  XCTAssertEqualObjects(string1, @"test");
}

@end
