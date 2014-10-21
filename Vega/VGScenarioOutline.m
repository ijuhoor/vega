//
//  VGScenarioOutline.m
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGScenarioOutline.h"

NSString * const VGScenarioOutlineTitleKey    = @"title";
NSString * const VGScenarioOutlineTagsKey     = @"tags";
NSString * const VGScenarioOutlineStepsData   = @"steps";
NSString * const VGScenarioOutlineExampleData = @"example";


@implementation VGScenarioOutline

- (instancetype)initWithDictionary:(NSDictionary*)scenarioOutlineDictionary
{
  self = [super init];
  if (self) {
    _title = scenarioOutlineDictionary[VGScenarioOutlineTitleKey];
    _tags  = scenarioOutlineDictionary[VGScenarioOutlineTagsKey];

    _stepsData = scenarioOutlineDictionary[VGScenarioOutlineStepsData];
    _example   = scenarioOutlineDictionary[VGScenarioOutlineExampleData];
  }
  return self;
}


- (NSInteger)numberOfExamples
{
  NSArray *allKeys = [self.example allKeys];
  if ([allKeys count] > 0) {
    NSArray *values = self.example[allKeys[0]];
    return [values count];
  }
  
  return 0;
}





@end



