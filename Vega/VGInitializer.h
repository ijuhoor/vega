//
//  VGInitializer.h
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGInitializer : NSObject

- (instancetype)initWithFileManager:(NSFileManager*)fileManager;

- (void)initializeDirectoryAtPath:(NSString*)path error:(NSError**)error;

@end
