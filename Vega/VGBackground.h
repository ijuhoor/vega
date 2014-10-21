//
//  VGBackground.h
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGBackground : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray  *stepsData;

- (instancetype)initWithDictionary:(NSDictionary*)backgroundDictionary;

@end
