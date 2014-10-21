//
//  VGColoredOutputFormatter.m
//  Vega
//
//  Created by Idriss on 03/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGColoredOutputFormatter.h"

@interface VGColoredOutputFormatter ()

@property (nonatomic) BOOL hideDebug;

@end


@implementation VGColoredOutputFormatter

- (NSString*)formattedStringForString:(NSString*)string
{
  NSString *colorCode = @"\e[0m";
  NSString *prefix    = @"";
  NSArray *keywords   = @[@"Default: Tests run:", @"Default: Feature:", @"Pass:", @"Issue:", @"Fail:", @"Default:", @"Start:", @"Debug:", @"Default: Debug>", @"Screenshot captured"];
  NSString *outputStr = string;
  
  for (NSString *keyword in keywords) {
    NSRange range = [self string:outputStr containsKeyword:keyword];
    if (range.location != NSNotFound) {
      
      if (([keyword isEqualToString:@"Debug:"] || [keyword isEqualToString:@"Screenshot captured"]) && self.hideDebug) {
        return nil;
      }
      
      outputStr = [self stripMainAutomationLogKeywordsFromString:outputStr];
      colorCode = [self colorCodeForKeyword:keyword];
      prefix    = [self prefixForKeyword:keyword];
      break;
    }
  }
  
  NSString *formattedString = [NSString stringWithFormat:@"%@%@", prefix, outputStr];
  return [self coloriseString:formattedString withColorCode:colorCode];
  
}

- (void)setHideDebug:(BOOL)hide
{
  _hideDebug = hide;
}


- (NSRange)string:(NSString*)string containsKeyword:(NSString*)keyword
{
  NSError *error = nil;
  NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:keyword
                                                                          options:0
                                                                            error:&error];
  if (error) {
    return NSMakeRange(NSNotFound, 0);
  }
  
  NSRange range = [regExp rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
  return range;
}


#pragma mark -- COLORS

- (NSString*)colorCodeForKeyword:(NSString*)keyword
{
 
  if (keyword == nil) {
    return nil;
  }
  
  NSDictionary *colorCodes = @{ @"Start:"  : @"\e[1m",
                                @"Pass:"   : @"\e[0;32m",
                                @"Issue:"  : @"\e[0;33m",
                                @"Fail:"   : @"\e[0;31m",
                                @"Debug:"  : @"\e[2m",
                                @"Default:": @"\e[0m",
                                @"Default: Tests run:": @"\e[1m",
                                @"Default: Feature:": @"\e[1m",
                                @"Default: Debug>": @"\e[2mDim"};
  
  
  return colorCodes[keyword];
  
}


- (NSString*)coloriseString:(NSString*)string withColorCode:(NSString*)colorCode
{
  return [NSString stringWithFormat:@"%@%@\e[0m", colorCode, string];
}

#pragma mark -- PREFIXES

- (NSString*)prefixForKeyword:(NSString*)keyword
{
  
  if (keyword == nil) {
    return nil;
  }
  
  NSDictionary *colorCodes = @{ @"Start:"  : @"  ",
                                @"Pass:"   : @"    ",
                                @"Issue:"  : @"    ",
                                @"Fail:"   : @"    ",
                                @"Debug:"  : @"    ",
                                @"Default:": @"    ",
                                @"Default: Tests run:": @"",
                                @"Default: Feature:": @"\n",
                                @"Default: Debug>": @"    "};
  
  return colorCodes[keyword];
  
}

- (NSString*)stripMainAutomationLogKeywordsFromString:(NSString*)string
{
  NSString *newString = string;
  NSArray *keywords   = @[@"Pass:", @"Issue:", @"Fail:", @"Default:", @"Start:", @"Debug:", @"Screenshot captured"];
  for (NSString *keyword in keywords) {
    NSRange range = [self string:string containsKeyword:keyword];
    if (range.location != NSNotFound) {
      newString = [string substringFromIndex:range.location + range.length];
    }
  }
  return newString;
}



@end
