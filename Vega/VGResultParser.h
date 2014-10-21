//
//  VGResultParser.h
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGResultOutputFormatter.h"

@interface VGResultParser : NSObject

- (instancetype)initWithOutputFormatter:(id<VGResultOutputFormatter>)formatter;
- (NSString*)formatAtFilePath:(NSString*)resultFilePath error:(NSError**)error;

@end
