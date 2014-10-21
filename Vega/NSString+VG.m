//
//  NSString+VG.m
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "NSString+VG.h"

@implementation NSString (VGAdditions)

- (NSString*)stringbyTrimmingWhitespaces
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
