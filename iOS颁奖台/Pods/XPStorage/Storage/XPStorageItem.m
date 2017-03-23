/**
 *  XPStorageItem.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  持久层项
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorageItem.h"

@implementation XPStorageItem

- (NSString*)description {
    return [NSString stringWithFormat:@"identifier:%@ object:%@ created_time:%@",self.identifier,self.object,self.createdTime];
}

@end
