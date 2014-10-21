//
//  VGFeatureGenerator.m
//  Vega
//
//  Created by Juhoor, Idriss on 14/08/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <PEGKit/PEGKit.h>

#import "VGFeatureGenerator.h"
#import "GherkinParser.h"

@interface VGFeatureGenerator ()

@property (nonatomic, retain) GherkinParser *parser;


@end

@implementation VGFeatureGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parser = [[GherkinParser alloc] initWithDelegate:self];
    }
    return self;
}

- (NSDictionary*)parseFeatureFile:(NSString*)filePath error:(NSError**)error
{
    
    NSError *localError = nil;
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath
                                                        encoding:NSUTF8StringEncoding
                                                           error:&localError];
    
    if (localError) {
        *error = localError;
        return nil;
    }
  
  
    PKAssembly *result = [self.parser parseString:content error:&localError];
  
    NSDictionary *feature = [result pop];
    
    if (localError) {
        *error = localError;
        return nil;
    }
    
    return feature;
    
}


@end
