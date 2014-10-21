//
//  VGScenarioOutline.h
//  Vega
//
//  Created by Idriss on 08/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGScenarioOutline : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray  *tags;
@property (nonatomic, strong, readonly) NSDictionary *example;
@property (nonatomic, strong, readonly) NSArray  *stepsData;

- (instancetype)initWithDictionary:(NSDictionary*)scenarioOutlineDictionary;

- (NSInteger)numberOfExamples;

@end
