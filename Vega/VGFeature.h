//
//  VGFeature.h
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGFeature : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *descriptionString;
@property (nonatomic, strong, readonly) NSArray  *tags;

@property (nonatomic, strong, readonly) NSDictionary *backgroundData;
@property (nonatomic, strong, readonly) NSArray  *scenariosData;

- (instancetype)initWithDictionary:(NSDictionary*)featureDictionary;

@end
