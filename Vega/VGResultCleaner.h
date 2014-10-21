//
//  VGResultCleaner.h
//  Vega
//
//  Created by Idriss on 16/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGResultCleaner : NSObject

- (instancetype)initWithFileManager:(NSFileManager*)fileManager;

- (void)cleanupResultsAtPath:(NSString*)resultsPath error:(NSError**)error;


@end
