/**
 *  XPFMEncryptDatabaseQueue.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-02.
 *
 *  加密库
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPFMEncryptDatabaseQueue.h"
#import "XPFMEncryptDatabase.h"

@implementation XPFMEncryptDatabaseQueue

+ (Class)databaseClass
{
    return [XPFMEncryptDatabase class];
}

@end
