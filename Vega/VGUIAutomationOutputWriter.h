//
//  VGUIAutomationOutputWriter.h
//  Vega
//
//  Created by Juhoor, Idriss on 14/08/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VGFeature;
@class VGBackground;
@class VGScenarioOutline;
@class VGScenario;
@class VGStep;
@class VGTagCloud;

@protocol VGAutomationScriptFormatter;

@interface VGUIAutomationOutputWriter : NSObject

@property (nonatomic, retain) NSArray *stepsIncludes;
@property (nonatomic, retain) NSArray *imports;

@property (nonatomic, retain) VGTagCloud *tagCloud;
@property (nonatomic, retain) id<VGAutomationScriptFormatter> scriptFormatter;

- (NSString*)automationScriptHeader;
- (NSString*)automationScriptForFeature:(VGFeature*)feature;
- (NSString*)automationScriptFooter;

@end
