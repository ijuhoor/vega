//
//  VGScenario.m
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGScenario.h"

NSString * const VGScenarioTitleKey = @"title";
NSString * const VGScenarioTagsKey  = @"tags";
NSString * const VGScenarioStepsKey = @"steps";

@implementation VGScenario

- (instancetype)initWithDictionary:(NSDictionary*)scenarioDictionary
{
  self = [super init];
  if (self) {
    _title = scenarioDictionary[VGScenarioTitleKey];
    _tags  = scenarioDictionary[VGScenarioTagsKey];
    _stepsData = scenarioDictionary[VGScenarioStepsKey];
  }
  return self;
}

@end
