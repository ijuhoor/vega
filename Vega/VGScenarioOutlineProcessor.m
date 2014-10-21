//
//  VGScenarioOutlineProcessor.m
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGScenarioOutlineProcessor.h"

NSString * const VGStepDictionaryMethodKey = @"method";
NSString * const VGStepDictionaryDataKey   = @"data";

@implementation VGScenarioOutlineProcessor

- (NSInteger)numberOfExamplesInExampleData:(NSDictionary*)examples
{
  NSArray *allKeys = [examples allKeys];
  if ([allKeys count] > 0) {
    NSArray *values = examples[allKeys[0]];
    return [values count];
  }
  
  return 0;
}

- (NSDictionary*)exampleWithScenarioExample:(NSDictionary*)examples forIndex:(NSInteger)index
{
  NSInteger max = [self numberOfExamplesInExampleData:examples];
  if (index < max) {
    NSArray *allKeys = [examples allKeys];
    NSMutableDictionary *exampleDictionary = [NSMutableDictionary dictionary];
    for (NSString *key in allKeys) {
      NSObject *value = examples[key][index];
      exampleDictionary[key] = value;
    }
    return [NSDictionary dictionaryWithDictionary:exampleDictionary];
  }
  
  return nil;
}

- (NSDictionary*)applyExample:(NSDictionary*)example toStep:(NSDictionary*)stepData
{
  NSString *tempStep = stepData[VGStepDictionaryMethodKey];
  
  NSError *error = nil;
  NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"(<[a-zA-Z0-9]*>)"
                                                                          options:0
                                                                            error:&error];
  NSArray *matches = [regexp matchesInString:stepData[VGStepDictionaryMethodKey]
                                     options:0
                                       range:NSMakeRange(0, [stepData[VGStepDictionaryMethodKey] length])];
  
  /* As we want to replace the keys in one pass, we will need to recompute the location of
   the regexp group we find by adding the difference in the location.*/
  NSInteger lengthDelta = 0;
  for (NSTextCheckingResult *matchingResult in matches) {
    if (matchingResult.range.location != NSNotFound) {
      NSRange  placeholderRange = NSMakeRange(matchingResult.range.location + lengthDelta, matchingResult.range.length);
      NSRange  keyRange = NSMakeRange(matchingResult.range.location + 1 + lengthDelta, matchingResult.range.length - 2);
      NSString *exampleKey = [tempStep substringWithRange:keyRange];
      NSObject *newValue  = example[exampleKey];
      NSString *stringValueOfNewValue = nil;
      if ([newValue isKindOfClass:[NSString class]]){
        stringValueOfNewValue = (NSString*)newValue;
      } else if ([newValue respondsToSelector:@selector(stringValue)]){
        stringValueOfNewValue = [newValue performSelector:@selector(stringValue)];
      }
      
      if (newValue != nil) {
        tempStep    = [tempStep stringByReplacingCharactersInRange:placeholderRange withString:stringValueOfNewValue];
        lengthDelta = stringValueOfNewValue.length - matchingResult.range.length;
      }
      
    }
  }
  
  NSMutableDictionary *newStepDict = [NSMutableDictionary dictionary];
  if (tempStep) {
    newStepDict[VGStepDictionaryMethodKey] = tempStep;
  }
  if (stepData[VGStepDictionaryDataKey]) {
    newStepDict[VGStepDictionaryDataKey] = stepData[VGStepDictionaryDataKey];
  }
  
  return [NSDictionary dictionaryWithDictionary:newStepDict];
  
}



@end
