//
//  XPAPIManager.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "NSString+XPAPIPath.h"
#import "XPBaseModel.h"
#import <AFNetworking-RACExtensions/RACAFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <Foundation/Foundation.h>

extern NSString *const kXPAPIErrorDomain;
static const NSUInteger kXPAPITimeout = 5;

typedef NS_ENUM (NSUInteger, XPAPIError) {
    kXPAPIErrorOther = 0,
    kXPAPIErrorUnknown = 200, // 客户端请求成功
    kXPAPIErrorBadRequest = 400, // 客户端请求有语法错误，不能被服务器所理解
    kXPAPIErrorUnauthorized = 401, // 请求未经授权，这个状态代码必须和WWW-Authenticate报头域一起使用
    kXPAPIErrorForbidden = 403, // 服务器收到请求，但是拒绝提供服务
    kXPAPIErrorNotFound = 404, // 请求资源不存在
    kXPAPIErrorInternalServerError = 500,  // 服务器发生不可预期的错误
    kXPAPIErrorServerUnavailable = 503, // 服务器当前不能处理客户端的请求，一段时间后可能恢复正常
};

#pragma mark - Common
@interface XPAPIManager : XPBaseModel

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters;

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters;

@end

@interface XPAPIManager (Restful)

- (RACSignal *)rac_MappingForClass:(Class)class dictionary:(NSDictionary *)dictionary;

- (RACSignal *)rac_MergeMappingForClass:(Class)class dictionary:(NSDictionary *)dictionary;

- (RACSignal *)rac_MappingForClass:(Class)class array:(NSArray *)array;

@end

#pragma mark - Image
@interface XPAPIManager (Image)

/**
 *  获取远程图片
 *
 *  @param path 路径（全量）
 *
 *  @return 信号
 */
- (RACSignal *)rac_remoteImage:(NSString *)path;

@end
