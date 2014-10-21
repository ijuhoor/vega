//
//  NSMutableString+VG.m
//  Vega
//
//  Created by Idriss on 10/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "NSMutableString+VG.h"

@implementation NSMutableString (VGAdditions)

- (void)appendStringOrNil:(NSString *)aString
{
  if (aString) {
    [self appendString:aString];
  }
}


@end
