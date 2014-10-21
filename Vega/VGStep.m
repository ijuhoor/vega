//
//  VGStep.m
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGStep.h"

NSString * const VGStepMethodKey = @"method";
NSString * const VGStepDataKey   = @"data";

@implementation VGStep

- (instancetype)initWithDictionary:(NSDictionary*)stepDictionary
{
  self = [super init];
  if (self) {
    _method = [stepDictionary[VGStepMethodKey] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    _data   = stepDictionary[VGStepDataKey];
  }
  return self;
}


@end
