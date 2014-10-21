//
//  VGBackground.m
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGBackground.h"

NSString *const VGBackgroundTitleKey = @"title";
NSString *const VGBackgroundStepKey  = @"steps";

@implementation VGBackground

- (instancetype)initWithDictionary:(NSDictionary*)backgroundDictionary
{
  self = [super init];
  if (self) {
    _title     = backgroundDictionary[VGBackgroundTitleKey];
    _stepsData = backgroundDictionary[VGBackgroundStepKey];
  }
  return self;
}

@end
