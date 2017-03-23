/**
 *  XPFMEncryptDatabase.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-02.
 *
 *  加密库
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPFMEncryptDatabase.h"
#import "sqlite3.h"

@implementation XPFMEncryptDatabase

static NSString *encryptKey_;

+ (void)initialize
{
    [super initialize];
    //初始化数据库加密key，在使用之前可以通过 setEncryptKey 修改
    encryptKey_ = @"FDLSAFJEIOQJR34JRI4JIGR93209T489FR";
}

#pragma mark - 重载原来方法
- (BOOL)open {
    if (_db) {
        return YES;
    }
    
    int err = sqlite3_open([self sqlitePath], &_db );
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    } else {
        //数据库open后设置加密key
        [self setKey:encryptKey_];
    }
    
    if (_maxBusyRetryTimeInterval > 0.0) {
        // set the handler
        [self setMaxBusyRetryTimeInterval:_maxBusyRetryTimeInterval];
    }
    
    return YES;
}

#if SQLITE_VERSION_NUMBER >= 3005000
- (BOOL)openWithFlags:(int)flags {
    if (_db) {
        return YES;
    }
    
    int err = sqlite3_open_v2([self sqlitePath], &_db, flags, NULL /* Name of VFS module to use */);
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    } else {
        //数据库open后设置加密key
        [self setKey:encryptKey_];
    }
    if (_maxBusyRetryTimeInterval > 0.0) {
        // set the handler
        [self setMaxBusyRetryTimeInterval:_maxBusyRetryTimeInterval];
    }
    
    return YES;
}

#endif

- (const char*)sqlitePath {
    
    if (!_databasePath) {
        return ":memory:";
    }
    
    if ([_databasePath length] == 0) {
        return ""; // this creates a temporary database (it's an sqlite thing).
    }
    
    return [_databasePath fileSystemRepresentation];
    
}

#pragma mark - 配置方法
+ (void)setEncryptKey:(NSString *)encryptKey
{
    encryptKey_ = encryptKey;
}

@end
