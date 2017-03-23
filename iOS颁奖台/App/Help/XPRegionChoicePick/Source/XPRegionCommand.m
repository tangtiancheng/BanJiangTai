//
//  XPRegionMediator.m
//  XPApp
//
//  Created by xinpinghuang on 1/6/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPRegionCommand.h"
#import "XPRegionEntity.h"

NSMutableDictionary *buffer = nil;
@interface XPRegionCommand ()

@end

@implementation XPRegionCommand

+ (void)persistenceToLocal
{
    NSError *error;
    NSString *csvBuffer = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"region.csv"] encoding:NSUTF8StringEncoding error:&error];
    if(error) {
    } else {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        /*
         *  0 - 当前地址ID
         *  1 - 当前地址名称
         *  2 - 当前地址属于第几层
         *  3 - 上级地址ID
         *  4 - 上级地址名称
         *  5 - 状态（0-无用;1-可用）
         */
        [csvBuffer enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
            static BOOL filter = YES;
            if(filter) {
                filter = NO;
            } else {
                NSArray *temp = [line componentsSeparatedByString:@","];
                XPRegionEntity *entity = [[XPRegionEntity alloc] init];
                entity.id = [temp[0] integerValue];
                entity.code = temp[1];
                entity.name = temp[2];
                entity.level = [temp[3] integerValue];
                entity.parentId = [temp[4] integerValue];
                entity.status = 1;
                [realm addObject:entity];
            }
        }];
        [realm commitWriteTransaction];
    }
}

+ (RLMResults *)regionWithParentId:(NSString *)parentId
{
    if(!parentId || [parentId isEqualToString:@""]) {
        parentId = @"1";
    }
    if(!buffer) {
        buffer = [NSMutableDictionary dictionary];
    }
    if([buffer objectForKey:parentId]) {
        return [buffer objectForKey:parentId];
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"region.realm"];
    NSString *targetPath = [documentPath stringByAppendingPathComponent:@"region.realm"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:targetPath error:nil];
    }
    RLMResults *results = [[XPRegionEntity objectsInRealm:[RLMRealm realmWithPath:targetPath] where:[NSString stringWithFormat:@"parentId == %@ and status == 1", parentId]] sortedResultsUsingProperty:@"id" ascending:YES];
    [buffer setObject:results forKey:parentId];
    return results;
}

@end
