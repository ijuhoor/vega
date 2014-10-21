//
//  VGResultOutputFormatter.h
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VGResultOutputFormatter <NSObject>

- (NSString*)resultForResultDictionary:(NSDictionary*)resultDictionary;

@end