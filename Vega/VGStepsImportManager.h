//
//  VGStepsImportManager.h
//  Vega
//
//  Created by Juhoor, Idriss on 17/09/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGStepsImportManager : NSObject

@property (nonatomic, strong, readonly) NSArray *stepImports;

- (instancetype)initWithFileManager:(NSFileManager*)fileManager;

- (NSArray*)stepsImportsForPath:(NSString*)path;

@end
