//
//  VGResultParserTests.m
//  Vega
//
//  Created by Idriss on 17/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "VGResultOutputFormatter.h"
#import "VGResultParser.h"

@interface VGResultTestOutputFormatter : NSObject  <VGResultOutputFormatter>

@end

@implementation VGResultTestOutputFormatter

- (NSString*)resultForResultDictionary:(NSDictionary*)resultDictionary
{
  return @"Yep";
}

@end

@interface VGResultParserTests : XCTestCase

@end

@implementation VGResultParserTests

- (void)makeFile:(NSString*)file withContent:(NSString*)content
{
  [content writeToFile:file
            atomically:YES
              encoding:NSUTF8StringEncoding
                 error:nil];
}

- (void)deleteFile:(NSString*)file
{
  [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
}

- (void)testFormatAtFilePathNil;
{
  VGResultTestOutputFormatter *formatter = [VGResultTestOutputFormatter new];
  VGResultParser *parser = [[VGResultParser alloc] initWithOutputFormatter:formatter];
  
  NSError *error = nil;
  NSString *result = [parser formatAtFilePath:nil error:&error];
  
  XCTAssertNil(error);
  
  XCTAssertNil(result);
  
}


- (void)testFormatAtFilePathMalformedContent;
{
  
  NSString *resultFile = @"testfile";
  [self makeFile:@"testfile" withContent:@"asfasfqw   asdas [[]]] {}"];
  
  VGResultTestOutputFormatter *formatter = [VGResultTestOutputFormatter new];
  VGResultParser *parser = [[VGResultParser alloc] initWithOutputFormatter:formatter];
  
  NSError *error = nil;
  [parser formatAtFilePath:resultFile error:&error];
  
  XCTAssertNotNil(error);
  XCTAssertEqual(error.code, 7001);
  
  [self deleteFile:resultFile];
}

- (void)testFormatAtFilePath;
{
  NSString *resultFile = @"testfile";
  [self makeFile:resultFile withContent:@"ew0KInRlc3REYXRhIjoidGVzdCINCn0="];
  
  VGResultTestOutputFormatter *formatter = [VGResultTestOutputFormatter new];
  
  VGResultParser *parser = [[VGResultParser alloc] initWithOutputFormatter:formatter];
  
  NSError *error = nil;
  NSString *result = [parser formatAtFilePath:resultFile
                                        error:&error];
  
  XCTAssertNil(error);
  XCTAssertEqualObjects(@"Yep", result);
  
  [self deleteFile:resultFile];
  
}

@end
