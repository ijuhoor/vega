//
//  VGTagCloud.m
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#import "VGTagCloud.h"

@interface VGTagCloud ()

@property (nonatomic, retain) NSMutableSet *includedTags;
@property (nonatomic, retain) NSMutableSet *excludedTags;

@end

@implementation VGTagCloud

- (instancetype)init
{
  self = [super init];
  if (self) {
    _includedTags = [NSMutableSet new];
    _excludedTags = [NSMutableSet new];
  }
  return self;
}

- (void)includeTag:(NSString*)tag
{
  if (tag) {
    [self.includedTags addObject:tag];
    [self.excludedTags removeObject:tag];
  }
}

- (void)exludeTag:(NSString*)tag
{
  if (tag) {
    [self.excludedTags addObject:tag];
    [self.includedTags removeObject:tag];
  }
}

- (BOOL)useTag:(NSString*)tag
{
  if ([self.excludedTags containsObject:tag]) {
    return NO;
    
  } else {
    if ([self.includedTags count] == 0) {
      return YES;
      
    } else {
      return [self.includedTags containsObject:tag];
      
    }
  }
}

- (BOOL)useTags:(NSArray*)tags
{
  
  NSSet *tagSet = [NSSet setWithArray:tags];
  if ([tagSet intersectsSet:self.excludedTags]) {
    return NO;
  } else {
    if ([self.includedTags count] == 0) {
      return YES;
    } else {
      return [self.includedTags intersectsSet:tagSet];
    }
  }
  
}


@end
