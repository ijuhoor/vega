//
//  VGVegaResultOutputFormatter.m
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGVegaResultOutputFormatter.h"

@implementation VGVegaResultOutputFormatter

- (NSString*)resultForResultDictionary:(NSDictionary *)resultDictionary
{
  return [resultDictionary description];
}

@end
