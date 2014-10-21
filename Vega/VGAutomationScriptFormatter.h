//
//  VGAutomationScriptFormatter.h
//  Vega
//
//  Created by Idriss on 10/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

@class VGFeature;
@class VGBackground;
@class VGScenarioOutline;
@class VGScenario;
@class VGStep;

@protocol VGAutomationScriptFormatter <NSObject>

- (NSString*)formatWorkingDirectory:(NSString*)workingDir;
- (NSString*)formatReportWithLocation:(NSString*)location andReportName:(NSString*)reportName;

- (NSString*)formatImports:(NSArray*)imports;
- (NSString*)formatVars:(NSArray*)vars;

- (NSString*)formatFeature:(VGFeature*)feature;
- (NSString*)formatPostFeature:(VGFeature*)feature;

- (NSString*)formatBackground:(VGBackground*)background;
- (NSString*)formatPostBackground:(VGBackground*)background;

- (NSString*)formatOutline:(VGScenarioOutline*)scenarioOutline exampleNumber:(NSInteger)exampleNumber;
- (NSString*)formatPostOutline:(VGScenarioOutline*)scenarioOutline exampleNumber:(NSInteger)exampleNumber;

- (NSString*)formatScenario:(VGScenario*)scenario;
- (NSString*)formatPostScenario:(VGScenario*)scenario;

- (NSString*)formatStep:(VGStep*)step;
- (NSString*)formatPostStep:(VGStep*)step;


@end
