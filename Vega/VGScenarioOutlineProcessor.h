//
//  VGScenarioOutlineProcessor.h
//  Vega
//
//  Created by Idriss on 09/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGScenarioOutlineProcessor : NSObject

- (NSDictionary*)exampleWithScenarioExample:(NSDictionary*)examples forIndex:(NSInteger)index;

- (NSDictionary*)applyExample:(NSDictionary*)example toStep:(NSDictionary*)step;


@end
