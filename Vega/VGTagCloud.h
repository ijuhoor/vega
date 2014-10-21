//
//  VGTagCloud.h
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGTagCloud : NSObject

- (void)includeTag:(NSString*)tag;
- (void)exludeTag:(NSString*)tag;

- (BOOL)useTag:(NSString*)tag;
- (BOOL)useTags:(NSArray*)tags;


@end
