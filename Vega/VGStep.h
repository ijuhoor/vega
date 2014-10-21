//
//  VGStep.h
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGStep : NSObject

@property (nonatomic, strong, readonly) NSString *method;
@property (nonatomic, strong, readonly) NSArray  *data;

- (instancetype)initWithDictionary:(NSDictionary*)stepDictionary;

@end
