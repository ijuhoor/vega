//
//  VGInstrumentExecutor.h
//  Vega
//
//  Created by Idriss on 03/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VGInstrumentExecutor : NSObject

@property (nonatomic, strong) NSString *instrumentRunPath;
@property (nonatomic, strong) NSString *instrumentTemplateFilePath;
@property (nonatomic, strong) NSString *bundleId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSArray  *scripts;
@property (nonatomic, strong) NSString *outputFolder;



- (NSInteger)runInstrumentWithOutputBlock:(void(^)(NSString * output))outputBlock error:(NSError**)error;

@end
