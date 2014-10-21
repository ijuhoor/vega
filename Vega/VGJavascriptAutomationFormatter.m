//
//  VGJavascriptAutomationFormatter.m
//  Vega
//
//  Created by Idriss on 10/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGJavascriptAutomationFormatter.h"

#import "VGFeature.h"
#import "VGBackground.h"
#import "VGScenario.h"
#import "VGScenarioOutline.h"
#import "VGStep.h"

@implementation VGJavascriptAutomationFormatter

- (NSString*)formatWorkingDirectory:(NSString *)workingDir
{
  return [NSString stringWithFormat:@"var pwd = \"%@\"\n\n", workingDir];
}

- (NSString*)formatReportWithLocation:(NSString*)location andReportName:(NSString*)reportName
{
  return [NSString stringWithFormat:@"VGReport.report(\"%@\", \"%@\")", location, reportName];
}

- (NSString*)formatImports:(NSArray*)imports
{
  if (!imports) {
    return nil;
  }
  
  NSMutableString *importsString = [NSMutableString string];
  
  for (NSString *import in imports) {
    [importsString appendFormat:@"#import \"%@\"", import];
    [importsString appendString:@"\n"];
  }
  
  return importsString;
}

- (NSString*)formatVars:(NSArray*)vars
{
  if (!vars) {
    return nil;
  }
  
  NSMutableString *varsString = [NSMutableString string];
  
  if ([vars count] > 0) {
    [varsString appendString:@"var "];
    [varsString appendString:[vars componentsJoinedByString:@", "]];
    [varsString appendString:@"\n\n"];
  }
  return varsString;
  
}


- (NSString*)formatFeature:(VGFeature*)feature
{
  if (!feature) {
    return nil;
  }
  
  NSMutableString * scenariosString = [NSMutableString string];
  NSString *title = feature.title;
  if (!title) {
    title = @"untitled";
  }
  
  NSString *testHeader = [NSString stringWithFormat:@"testName = \"%@\"\n", title];
  [scenariosString appendString:testHeader];

  NSString *testReport = @"VGReport.reportStartFeature(testName)\n";
  [scenariosString appendString:testReport];
  
  NSString *testLog = @"VGLogger.logStartFeature(testName)\n\n";
  [scenariosString appendString:testLog];
  
  return scenariosString;
}

- (NSString*)formatPostFeature:(VGFeature*)feature
{
  NSString *endFeatureString = @"VGReport.reportEndFeature(testName)\n";
  return endFeatureString;
}


- (NSString*)formatBackground:(VGBackground*)background
{
  if (!background) {
    return nil;
  }
  
  NSMutableString *backgroundString = [NSMutableString string];
  [backgroundString appendString:@"steps = []\n"];
  return backgroundString;
}

- (NSString*)formatPostBackground:(VGBackground*)background
{
  if (!background) {
    return nil;
  }
  
  NSMutableString *postBackgroundString = [NSMutableString string];
  [postBackgroundString appendString:@"performBackground(steps)\n\n"];
  return postBackgroundString;
}



- (NSString*)formatOutline:(VGScenarioOutline*)scenarioOutline exampleNumber:(NSInteger)exampleNumber
{
  if (!scenarioOutline) {
    return nil;
  }
  
  NSMutableString *scenarioOutlineString = [NSMutableString string];
  NSString *title = scenarioOutline.title;
  if (!title) {
    title = @"untitled";
  }
  NSString *scenarioName = [NSString stringWithFormat:@"%@ case %ld", title, (long)exampleNumber];
  
  [scenarioOutlineString appendFormat:@"scenarioName = \"%@\"\n", scenarioName];
  [scenarioOutlineString appendString:@"steps = []\n"];
  
  
  return scenarioOutlineString;
  
}

- (NSString*)formatPostOutline:(VGScenarioOutline*)scenarioOutline exampleNumber:(NSInteger)exampleNumber
{
  if (!scenarioOutline) {
    return nil;
  }
  
  NSMutableString *scenarioOutlineString = [NSMutableString string];
  [scenarioOutlineString appendString:@"performScenario(scenarioName, steps)\n\n"];
  return scenarioOutlineString;
}


- (NSString*)formatScenario:(VGScenario*)scenario
{
  if (!scenario) {
    return nil;
  }
  
  NSMutableString *scenarioString = [NSMutableString string];
  
  NSString *title = scenario.title;
  if (!title) {
    title = @"untitled";
  }
  
  [scenarioString appendFormat:@"scenarioName = \"%@\"\n", title];
  [scenarioString appendString:@"steps = []\n"];
  
  return scenarioString;
}

- (NSString*)formatPostScenario:(VGScenario*)scenario
{
  
  if (!scenario) {
    return nil;
  }
  
  NSMutableString *postscenarioString = [NSMutableString string];
  [postscenarioString appendString:@"performScenario(scenarioName, steps)\n\n"];
  return postscenarioString;
}

- (NSString*)formatStep:(VGStep*)step
{
  
  if (step.method && step.data){
    
    NSData *arrayData = [NSJSONSerialization dataWithJSONObject:step.data
                                                        options:0
                                                          error:nil];
    
    NSString *arrayString = [[NSString alloc] initWithData:arrayData encoding:NSUTF8StringEncoding];
    NSString *invocation = [NSString stringWithFormat:@"{'expr':\"%@\", 'args':%@}", step.method, arrayString];
    return [NSString stringWithFormat:@"steps.push(%@)", invocation];
  } else if (step.method) {
    
    NSString *invocation = [NSString stringWithFormat:@"{'expr':\"%@\"}", step.method];
    return [NSString stringWithFormat:@"steps.push(%@)", invocation];
  }
  
  return nil;
  
}

- (NSString*)formatPostStep:(VGStep*)step
{
  return nil;
}

- (NSString*)currentWorkingDir
{
  return [[[NSFileManager alloc] init] currentDirectoryPath];
}

@end
