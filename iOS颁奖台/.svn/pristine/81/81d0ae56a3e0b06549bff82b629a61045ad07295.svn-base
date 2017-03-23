/**
 *  XPStorage+NSString.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  插入字符串
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage+NSString.h"

@implementation XPStorage (NSString)

- (void)putString:(NSString *)string withId:(NSString *)id {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString *ct = [NSString stringWithFormat:@"%ld",(long)interval];
    if ([self getStringById:id]) { // 如果以前存在，则更新时间戳
        NSString *sql = [NSString stringWithFormat:@"update t_storage set createdTime = '%@' where key = '%@'",ct,id];
        [self.database executeUpdate:sql];
    } else {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_storage (key, object, createdTime) VALUES ('%@', '%@', '%@')",id,string,ct];
        [self.database executeUpdate:sql];
    }
}

- (NSString*)getStringById:(NSString *)id {
    NSString *sql = [NSString stringWithFormat:@"SELECT * from t_storage WHERE key = '%@'",id];
    FMResultSet *resultSet = [self.database executeQuery:sql];
    if (resultSet.columnCount <= 0)
        return nil;
    while ([resultSet next]) {
        return [resultSet stringForColumn:@"object"];
    }
    return nil;
}

@end
