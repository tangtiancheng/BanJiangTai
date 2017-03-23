//
//  XPRegionMediator.h
//  XPApp
//
//  Created by xinpinghuang on 1/6/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface XPRegionCommand : NSObject

/**
 *  通过parentId取出数据（例：取全部各省份及直辖市，则传中国的ID(也就是 1）即可）
 *  备注：如果只取省份数据集（可传nil、空字符串、1）
 *
 *  @param parentId 上级ID
 *
 *  @return 结果集合
 */
+ (RLMResults *)regionWithParentId:(NSString *)parentId;

@end
