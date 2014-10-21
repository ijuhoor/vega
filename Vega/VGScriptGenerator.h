//
//  VGScriptGenerator.h
//  Vega
//
//  Created by Idriss on 11/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VGFeature;

@interface VGScriptGenerator : NSObject

- (void)setTagsString:(NSString*)tagsString;

- (void)setStepDirectory:(NSString*)directory error:(NSError**)error;

- (void)generateScriptWithFilename:(NSString*)file forFeatureFile:(NSString*)featureFile error:(NSError**)error;
- (void)generateScriptWithFilename:(NSString *)file forFeatureFiles:(NSString *)featureFiles error:(NSError **)error;


@end
