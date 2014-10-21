//
//  VGResultParser.m
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGResultParser.h"

@interface VGResultParser ()

@property (nonatomic, retain) id<VGResultOutputFormatter> formatter;

@end

@implementation VGResultParser

- (instancetype)initWithOutputFormatter:(id<VGResultOutputFormatter>)formatter
{
  self = [super init];
  if (self) {
    _formatter = formatter;
  }
  return self;
}

- (NSString*)formatAtFilePath:(NSString*)resultFilePath error:(NSError**)error
{
  
  if (!resultFilePath) {
    return nil;
  }
  
  NSError *b64Error = nil;
  
  NSString *b64EncodedResult = [NSString stringWithContentsOfFile:resultFilePath
                                                         encoding:NSUTF8StringEncoding
                                                            error:&b64Error];
  if (b64Error) {
    
    NSString *errorDomain = @"vega.resultparser.readresult";
    NSInteger errorCode   = 7000;
    NSString *info        = NSLocalizedString(@"Can't read the result file", @"result read failed");
    NSString *resolution  = NSLocalizedString(@"Make sure the file exists", @"result read resolution");
    
    NSError *newError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:resultFilePath,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = newError;
    return nil;
  }
  
  
  NSData *result = [[NSData alloc] initWithBase64EncodedString:b64EncodedResult
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
  
  if (!result) {
    NSString *errorDomain = @"vega.resultparser.decoderesult";
    NSInteger errorCode   = 7001;
    NSString *info        = NSLocalizedString(@"Can't decode the result file", @"result decoding failed");
    NSString *resolution  = NSLocalizedString(@"Make sure the file exists", @"result decoding resolution");
    
    NSError *newError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:resultFilePath,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = newError;
    return nil;
  }
  
  NSError *JSONError = nil;
  NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:result
                                                                   options:0
                                                                     error:&JSONError];
  
  if (JSONError){
    NSString *errorDomain = @"vega.resultparser.jsonparsing";
    NSInteger errorCode   = 7002;
    NSString *info        = NSLocalizedString(@"Can't parse the result file", @"result parsing failed");
    NSString *resolution  = NSLocalizedString(@"Make sure the file is not damaged", @"result parsing resolution");
    
    NSError *newError = [NSError errorWithDomain:errorDomain
                                            code:errorCode
                                        userInfo:@{NSLocalizedDescriptionKey:info,
                                                   NSFilePathErrorKey:resultFilePath,
                                                   NSLocalizedRecoverySuggestionErrorKey:resolution}];
    
    *error = newError;
    return nil;

  }
  
  NSString *outputString = [self.formatter resultForResultDictionary:resultDictionary];
  return outputString;
  
}


@end
