//
//  ObjectSelector.h
//  HelloZhuge
//
//  Created by Alex Hofsteede on 5/5/14.
//  Copyright (c) 2014 Zhuge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGObjectSelector : NSObject

@property (nonatomic, strong, readonly) NSString *string;

+ (ZGObjectSelector *)objectSelectorWithString:(NSString *)string;
- (instancetype)initWithString:(NSString *)string;

- (NSArray *)selectFromRoot:(id)root;
- (NSArray *)fuzzySelectFromRoot:(id)root;

- (BOOL)isLeafSelected:(id)leaf fromRoot:(id)root;
- (BOOL)fuzzyIsLeafSelected:(id)leaf fromRoot:(id)root;

- (Class)selectedClass;
- (NSString *)description;

@end
