/**
 *  XPStorage.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-01.
 *
 *  持久化层
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPStorage.h"

@interface XPStorage ()

@property (nonatomic, strong, readwrite) XPFMEncryptDatabase *database;

@end

@implementation XPStorage

+ (instancetype)sharedStorage {
    static XPStorage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[XPStorage alloc] init];
            NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *dbPath = [docsPath stringByAppendingPathComponent:@"storage.db"];
            instance.database = [XPFMEncryptDatabase databaseWithPath:dbPath];
            [XPFMEncryptDatabase setEncryptKey:@"~!@#$(*&^%"];
            if ([instance.database open]) {
                if (![instance.database tableExists:@"t_storage"]) {
                    [instance.database executeUpdate:@"CREATE TABLE t_storage (key text PRIMARY KEY NOT NULL,object text NOT NULL,createdTime text NOT NULL);"];
                }
            }
        }
    });
    return instance;
}

- (XPStorageItem*)getXPStorageItemById:(NSString *)objectId {
    XPStorageItem *item = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_storage where key = '%@'",objectId];
    FMResultSet *resultSet = [self.database executeQuery:sql];
    while ([resultSet next]) {
        NSString *identifier = [resultSet stringForColumn:@"key"];
        NSString *object = [resultSet stringForColumn:@"object"];
        NSString *createdTime = [resultSet stringForColumn:@"createdTime"];
        item = [[XPStorageItem alloc] init];
        item.identifier = identifier;
        item.object = object;
        item.createdTime = createdTime;
        break;
    }
    return item;
}

- (NSArray*)getAllItems {
    NSMutableArray *items = nil;
    
    FMResultSet *resultSet = [self.database executeQuery:@"SELECT * FROM t_storage"];
    if (resultSet.columnCount <= 0) {
        return items;
    }
    items = [NSMutableArray arrayWithCapacity:resultSet.columnCount];
    while ([resultSet next]) {
        NSString *identifier = [resultSet stringForColumn:@"key"];
        NSString *object = [resultSet stringForColumn:@"object"];
        NSString *createdTime = [resultSet stringForColumn:@"createdTime"];
        XPStorageItem *item = [[XPStorageItem alloc] init];
        item.identifier = identifier;
        item.object = object;
        item.createdTime = createdTime;
        
        [items addObject:item];
    }
    return items;
}

- (void)deleteAllObjects {
    [self.database executeUpdate:@"DELETE FROM t_storage"];
}

- (void)deleteObjectById:(NSString *)objectId {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_storage where key = '%@'",objectId];
    [self.database executeUpdate:sql];
}

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray {
    for (NSInteger i = 0; i < objectIdArray.count; i++) {
        [self deleteObjectById:objectIdArray[i]];
    }
}

- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_storage where key like '%@%%'",objectIdPrefix];
    [self.database executeUpdate:sql];
}

@end
