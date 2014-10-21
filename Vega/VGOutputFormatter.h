//
//  VGOutputFormatter.h
//  Vega
//
//  Created by Idriss on 03/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//


@protocol VGOutputFormatter <NSObject>

- (NSString*)formattedStringForString:(NSString*)string;
- (void)setHideDebug:(BOOL)hide;

@end