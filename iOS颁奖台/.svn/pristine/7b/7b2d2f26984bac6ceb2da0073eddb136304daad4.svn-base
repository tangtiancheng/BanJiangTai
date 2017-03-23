/**
 *  XPFMDBEncryptHelper.m
 *  ShareMerge
 *
 *  Created by huangxp on 2015-09-02.
 *
 *  FMDB+SQLCipher加密核心
 *
 *  Copyright (c) www.sharemerge.com All rights reserved.
 */

/** @file */    // Doxygen marker

#import "XPFMDBEncryptHelper.h"
#import "sqlite3.h"

@implementation XPFMDBEncryptHelper

static NSString *encryptKey_;

+ (void)initialize
{
    encryptKey_ = @"~!@#$%^|+_)(*&";
}

+ (BOOL)encryptDatabase:(NSString *)path
{
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@", path];
    if([self encryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)unEncryptDatabase:(NSString *)path
{
    NSString *sourcePath = path;
    NSString *targetPath = [NSString stringWithFormat:@"%@", path];
    if([self unEncryptDatabase:sourcePath targetPath:targetPath]) {
        NSFileManager *fm = [[NSFileManager alloc] init];
        [fm removeItemAtPath:sourcePath error:nil];
        [fm moveItemAtPath:targetPath toPath:sourcePath error:nil];
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)encryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypted KEY '%@';", targetPath, encryptKey_] UTF8String];
    
    sqlite3 *unencrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &unencrypted_DB) == SQLITE_OK) {
        
        // Attach empty encrypted database to unencrypted database
        sqlite3_exec(unencrypted_DB, sqlQ, NULL, NULL, NULL);
        
        // export database
        sqlite3_exec(unencrypted_DB, "SELECT sqlcipher_export('encrypted');", NULL, NULL, NULL);
        
        // Detach encrypted database
        sqlite3_exec(unencrypted_DB, "DETACH DATABASE encrypted;", NULL, NULL, NULL);
        
        sqlite3_close(unencrypted_DB);
        
        return YES;
    }
    else {
        sqlite3_close(unencrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(unencrypted_DB));
        
        return NO;
    }
}

+ (BOOL)unEncryptDatabase:(NSString *)sourcePath targetPath:(NSString *)targetPath
{
    const char* sqlQ = [[NSString stringWithFormat:@"ATTACH DATABASE '%@' AS plaintext KEY '';", targetPath] UTF8String];
    
    sqlite3 *encrypted_DB;
    if (sqlite3_open([sourcePath UTF8String], &encrypted_DB) == SQLITE_OK) {
        
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", encryptKey_] UTF8String], NULL, NULL, NULL);
        
        // Attach empty unencrypted database to encrypted database
        sqlite3_exec(encrypted_DB, sqlQ, NULL, NULL, NULL);
        
        // export database
        sqlite3_exec(encrypted_DB, "SELECT sqlcipher_export('plaintext');", NULL, NULL, NULL);
        
        // Detach unencrypted database
        sqlite3_exec(encrypted_DB, "DETACH DATABASE plaintext;", NULL, NULL, NULL);
        
        sqlite3_close(encrypted_DB);
        
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        
        return NO;
    }
}

+ (BOOL)changeKey:(NSString *)dbPath originKey:(NSString *)originKey newKey:(NSString *)newKey
{
    sqlite3 *encrypted_DB;
    if (sqlite3_open([dbPath UTF8String], &encrypted_DB) == SQLITE_OK) {
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA key = '%@';", originKey] UTF8String], NULL, NULL, NULL);
        
        sqlite3_exec(encrypted_DB, [[NSString stringWithFormat:@"PRAGMA rekey = '%@';", newKey] UTF8String], NULL, NULL, NULL);
        
        sqlite3_close(encrypted_DB);
        return YES;
    }
    else {
        sqlite3_close(encrypted_DB);
        NSAssert1(NO, @"Failed to open database with message '%s'.", sqlite3_errmsg(encrypted_DB));
        
        return NO;
    }
}

@end
