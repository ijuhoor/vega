//
//  VGJUnitResultOutputFormatter.m
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGJUnitResultOutputFormatter.h"

@implementation VGJUnitResultOutputFormatter

- (NSString*)resultForResultDictionary:(NSDictionary *)resultDictionary
{

  NSMutableString *jUnitReport = [NSMutableString string];
  [jUnitReport appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"];

  
  NSString *testSuitesHeader = @"<testsuites>\n";
  [jUnitReport appendString:testSuitesHeader];
  
  for (NSDictionary *feature in resultDictionary[@"features"]) {
    
      [jUnitReport appendString:[self formatTestSuite:feature withName:feature[@"title"]]];
  }
  NSString *testSuitesFooter = @"</testsuites>";
  [jUnitReport appendString:testSuitesFooter];
  
  return [NSString stringWithString:jUnitReport];
  
}

- (NSString*)formatTestSuite:(NSDictionary*)testSuiteDictionary withName:(NSString*)name
{
  NSMutableString *testSuiteString = [NSMutableString string];
  
  NSDictionary *summary = [testSuiteDictionary objectForKey:@"__summary__"];
  NSString *testSuiteHeader = [NSString stringWithFormat:@"<testsuite tests=\"%ld\" errors=\"%ld\" failures=\"%ld\" name=\"%@\" time=\"%ld\">\n",
                                (long)[summary[@"total"] integerValue],
                               (long)[summary[@"issues"] integerValue],
                               (long)[summary[@"failed"] integerValue],
                               name,
                               (long)[summary[@"time"] integerValue]];
  [testSuiteString appendString:testSuiteHeader];
  
  for (NSDictionary *scenario in testSuiteDictionary[@"scenarios"]) {
    
    [testSuiteString appendString:[self formatTest:scenario withName:scenario[@"title"] feature:name]];
    
  }
  
  
  NSString *testSuiteFooter = @"</testsuite>\n";
  [testSuiteString appendString:testSuiteFooter];
  
  return [NSString stringWithString:testSuiteString];
}

- (NSString*)formatTest:(NSDictionary*)testDictionary withName:(NSString*)test feature:(NSString*)feature
{
  NSMutableString *testString = [NSMutableString string];
  NSString *result = testDictionary[@"result"];
  long time = [testDictionary[@"time"] integerValue];
  
  if ([result isEqualToString:@"PASS"]) {
    [testString appendFormat:@"<testcase classname=\"%@\" name=\"%@\" time=\"%ld\"/>\n", feature, test, time];
  } else {
    [testString appendFormat:@"<testcase classname=\"%@\" name=\"%@\" time=\"%ld\">\n", feature, test, time];

    if ([result isEqualToString:@"ISSUE"]) {
      [testString appendFormat:@"<error "];
    } else {
      [testString appendFormat:@"<failure "];
    }
    
    [testString appendFormat:@" type=\"%@\"> %@ </failure>\n", @"UIAutomation failure", testDictionary[@"reason"]];
    
    [testString appendString:@"</testcase>\n"];
  }
  
  return [NSString stringWithString:testString];
}

@end
