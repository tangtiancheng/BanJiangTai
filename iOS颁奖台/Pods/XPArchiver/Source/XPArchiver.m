/**
 *  XPArchiver.h
 *  ShareMerge
 *
 *  Created by huangxp on 2015-01-05.
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPArchiver.h"

@implementation XPArchiver

+ (id)retrieve:(NSString *)key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", key]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (BOOL)persist:(id)object key:(NSString *)key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", key]];
    return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

+ (BOOL)delete:(NSString *)key {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", key]];
    return [fileManager removeItemAtPath:filePath error:NULL];
}

+ (BOOL)deleteEverything {
    BOOL result = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *files = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    
    for (int i = 0; i < [files count]; i++) {
        NSString *path = [files objectAtIndex:i];
        result = result && [fileManager removeItemAtPath:path error:NULL];
    }
    
    return result;
}

@end
