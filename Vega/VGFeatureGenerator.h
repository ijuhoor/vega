//
//  VGFeatureGenerator.h
//  Vega
//
//  Created by Juhoor, Idriss on 14/08/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGFeatureGenerator : NSObject


- (NSDictionary*)parseFeatureFile:(NSString*)filePath error:(NSError**)error;



@end
