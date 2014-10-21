//
//  VGUIAutomationOutputWriter.m
//  Vega
//
//  Created by Juhoor, Idriss on 14/08/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGUIAutomationOutputWriter.h"
#import "VGFeature.h"
#import "VGBackground.h"
#import "VGScenario.h"
#import "VGScenarioOutline.h"
#import "VGStep.h"

#import "VGScenarioOutlineProcessor.h"
#import "VGAutomationScriptFormatter.h"
#import "VGTagCloud.h"

#import "NSMutableString+VG.h"

@interface VGUIAutomationOutputWriter ()

@property (nonatomic, retain) NSArray *featureTags;

@end

@implementation VGUIAutomationOutputWriter



- (NSString*)automationScriptForFeature:(VGFeature*)feature
{
  
  NSMutableString *featuresString = [NSMutableString string];
  [featuresString appendString:@"\n"];
  
  if ([self.tagCloud useTags:feature.tags]) {
    self.featureTags = feature.tags;
    NSString *featureString = [self formatFeature:feature];
    [featuresString appendStringOrNil:featureString];
  }
  
  return featuresString;
 
}

- (NSString*)automationScriptHeader
{
  NSMutableString *headerString = [NSMutableString string];
  
  NSString *importString = [self formatImports:self.imports];
  [headerString appendStringOrNil:importString];
  [headerString appendString:@"\n"];
  
  NSString *fileImports = [self formatImports:self.stepsIncludes];
  [headerString appendStringOrNil:fileImports];
  [headerString appendString:@"\n"];
  [headerString appendString:@"\n"];
  
  NSString *vars = [self formatVars:@[@"testName",
                                      @"scenarioName",
                                      @"steps"]];
  [headerString appendString:vars];
  [headerString appendString:@"\n"];
  [headerString appendString:@"\n"];
  
  NSString *currentWorkingDir = [self.scriptFormatter formatWorkingDirectory:[self currentWorkingDir]];
  [headerString appendString:currentWorkingDir];
  [headerString appendString:@"\n"];
  [headerString appendString:@"\n"];
  
  return headerString;
}

- (NSString*)automationScriptFooter
{
  NSString *reportString = [self.scriptFormatter formatReportWithLocation:[self currentWorkingDir]
                                                            andReportName:@"report.pipe"];
  
  return reportString;
}

#pragma mark private

- (NSString*)formatImports:(NSArray*)imports
{
  return [self.scriptFormatter formatImports:imports];
}

- (NSString*)formatVars:(NSArray*)vars
{
  return [self.scriptFormatter formatVars:vars];
}


- (NSString*)formatFeature:(VGFeature*)feature
{
  NSArray *scenarios = feature.scenariosData;
  
  NSMutableString * scenariosString = [NSMutableString string];
  
  [scenariosString appendStringOrNil:[self.scriptFormatter formatFeature:feature]];
  
  if ([feature backgroundData]) {
    VGBackground *background = [[VGBackground alloc] initWithDictionary:[feature backgroundData]];
    [scenariosString appendStringOrNil:[self formatBackground:background]];
  }
  
  for (NSDictionary *scenarioDictionary in scenarios) {
    
    if ([scenarioDictionary valueForKey:@"outline"]){
      
      VGScenarioOutline *scenarioOutline = [[VGScenarioOutline alloc] initWithDictionary:scenarioDictionary];
      
      NSMutableArray *allTags = [NSMutableArray array];
      [allTags addObjectsFromArray:scenarioOutline.tags];
      [allTags addObjectsFromArray:self.featureTags];
      
      if ([self.tagCloud useTags:allTags]) {
        [scenariosString appendStringOrNil:[self formatOutline:scenarioOutline]];
      }
      
    } else {
      VGScenario *scenario = [[VGScenario alloc] initWithDictionary:scenarioDictionary];
      
      NSMutableArray *allTags = [NSMutableArray array];
      [allTags addObjectsFromArray:scenario.tags];
      [allTags addObjectsFromArray:self.featureTags];
      
      if ([self.tagCloud useTags:allTags]) {
        [scenariosString appendStringOrNil:[self formatScenario:scenario]];
      }
      
    }
  }
  
  [scenariosString appendStringOrNil:[self.scriptFormatter formatPostFeature:feature]];
  
  return scenariosString;
}

- (NSString*)formatBackground:(VGBackground*)background
{
  NSMutableString *backgroundString = [NSMutableString string];
  
  [backgroundString appendStringOrNil:[self.scriptFormatter formatBackground:background]];
  
  NSArray *steps = background.stepsData;
  for (NSDictionary *stepDictionary in steps) {
    VGStep *step = [[VGStep alloc] initWithDictionary:stepDictionary];
    NSString *formattedStep = [self formatStep:step];
    if (formattedStep) {
      [backgroundString appendFormat:@"%@\n", [self formatStep:step]];
    }
  }
  
  [backgroundString appendStringOrNil:[self.scriptFormatter formatPostBackground:background]];
  
  return backgroundString;
}

- (NSString*)formatOutline:(VGScenarioOutline*)scenarioOutline
{

  NSMutableString * scenariosString = [NSMutableString string];
  
  VGScenarioOutlineProcessor *outlineProcessor = [[VGScenarioOutlineProcessor alloc] init];
  
  
  NSInteger numberOfExamples = [scenarioOutline numberOfExamples];
  for (NSInteger i = 0; i < numberOfExamples; i++) {

    [scenariosString appendStringOrNil:[self.scriptFormatter formatOutline:scenarioOutline exampleNumber:i]];
    
    NSDictionary *example = [outlineProcessor exampleWithScenarioExample:scenarioOutline.example forIndex:i];
    
    NSArray *steps = scenarioOutline.stepsData;
    for (NSDictionary *stepDictionary in steps) {
      NSDictionary *stepWithAppliedExample = [outlineProcessor applyExample:example toStep:stepDictionary];
      VGStep *step = [[VGStep alloc] initWithDictionary:stepWithAppliedExample];
      NSString *formattedStep = [self formatStep:step];
      if (formattedStep) {
        [scenariosString appendFormat:@"%@\n", formattedStep];
      }
    }
    
    [scenariosString appendStringOrNil:[self.scriptFormatter formatPostOutline:scenarioOutline exampleNumber:i]];
    
  }
  
  return scenariosString;

}


- (NSString*)formatScenario:(VGScenario*)scenario
{
  NSMutableString * scenarioString = [NSMutableString string];
  
  [scenarioString appendStringOrNil:[self.scriptFormatter formatScenario:scenario]];
  
  NSArray *steps = scenario.stepsData;
  for (NSDictionary *stepDictionary in steps) {
    VGStep *step = [[VGStep alloc] initWithDictionary:stepDictionary];
    NSString *formattedStep = [self formatStep:step];
    if (formattedStep) {
      [scenarioString appendFormat:@"%@\n", formattedStep];
    }
  }
 
  [scenarioString appendStringOrNil:[self.scriptFormatter formatPostScenario:scenario]];
  
  return scenarioString;
}

- (NSString*)formatStep:(VGStep*)step
{
  return [self.scriptFormatter formatStep:step];
}

- (NSString*)currentWorkingDir
{
  return [[[NSFileManager alloc] init] currentDirectoryPath];
}

@end
