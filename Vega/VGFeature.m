//
//  VGFeature.m
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGFeature.h"

NSString * const VGFeatureTitleKey = @"title";
NSString * const VGFeatureTagsKey  = @"tags";
NSString * const VGFeatureDescriptionKey = @"description";
NSString * const VGFeatureBackgroundKey  = @"background";
NSString * const VGFeatureScenariosKey   = @"scenarios";

@implementation VGFeature

- (instancetype)initWithDictionary:(NSDictionary*)featureDictionary
{
  self = [super init];
  if (self) {
    _title             = featureDictionary[VGFeatureTitleKey];
    _tags              = featureDictionary[VGFeatureTagsKey];
    _backgroundData    = featureDictionary[VGFeatureBackgroundKey];
    _scenariosData     = featureDictionary[VGFeatureScenariosKey];
    _descriptionString = featureDictionary[VGFeatureDescriptionKey];
  }
  return self;
}

@end
