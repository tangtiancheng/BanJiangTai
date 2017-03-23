//
//  XPAPIManager.m
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPAPIManager.h"
#import <JSONModel-RACExtensions/RACJSONModel.h>
#import <JSONModel/JSONModel.h>

NSString *const kXPAPIErrorDomain = @"kXPAPIErrorDomain";

@implementation XPAPIManager

#pragma mark - Normal Request
- (AFHTTPRequestOperationManager *)manager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/plain", @"application/json", nil];
    //        instance.requestSerializer = [AFHTTPRequestSerializer serializer];
    //        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = kXPAPITimeout;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.responseSerializer.acceptableStatusCodes = nil;
    return manager;
}

- (RACSignal *)rac_GET:(NSString *)path parameters:(id)parameters
{
    NSLog(@"%@",parameters);
    AFHTTPRequestOperationManager *manager = [self manager];
    return [[[manager rac_GET:path parameters:parameters] reduceEach:^id (NSDictionary *dictionary, NSHTTPURLResponse *response){
        
        NSLog(@"%@",path);
        
        NSLog(@"%@",dictionary);
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :error];
    }];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager *manager = [self manager];
    return [[[manager rac_POST:path parameters:parameters] reduceEach:^id (NSDictionary *dictionary, NSHTTPURLResponse *response){
        NSLog(@"%@",dictionary);
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :error];
    }];
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager *manager = [self manager];
    return [[[manager rac_PUT:path parameters:parameters] reduceEach:^id (NSDictionary *dictionary, NSHTTPURLResponse *response){
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :error];
    }];
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager *manager = [self manager];
    return [[[manager rac_DELETE:path parameters:parameters] reduceEach:^id (NSDictionary *dictionary, NSHTTPURLResponse *response){
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :error];
    }];
}

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(id)parameters
{
    AFHTTPRequestOperationManager *manager = [self manager];
    return [[[manager rac_PATCH:path parameters:parameters]reduceEach:^id (NSDictionary *dictionary, NSHTTPURLResponse *response){
        return dictionary;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :error];
    }];
}

@end

@implementation XPAPIManager (Restful)

- (RACSignal *)rac_MappingForClass:(Class)class array:(NSArray *)array
{
    return [class parseSignalForArray:array];
}

- (RACSignal *)rac_MappingForClass:(Class)class dictionary:(NSDictionary *)dictionary
{
    return [class parseSignalForDictionary:dictionary];
}

- (RACSignal *)rac_MergeMappingForClass:(Class)class dictionary:(NSDictionary *)dictionary
{
    
    NSError *error;
    [[class singleton] mergeFromDictionary:dictionary useKeyMapping:YES error:&error];
    if(error) {
        return [RACSignal error:error];
    }
    
    return [RACSignal return :[class singleton]];
}

@end

@implementation XPAPIManager (Image)

- (UIImage *)imageCacheWithPath:(NSString *)path
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3600.0f];
    UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:urlRequest];
    if(image != nil) {
        return image;
    }
    
    return nil;
}

- (RACSignal *)rac_remoteImage:(NSString *)path
{
    UIImage *cacheImage = [self imageCacheWithPath:path];
    if(cacheImage) {
        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            [subscriber sendNext:cacheImage];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3600.0f];
        AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        postOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage *image = responseObject;
            [[UIImageView sharedImageCache] cacheImage:image forRequest:urlRequest];
            [subscriber sendNext:image];
            [subscriber sendCompleted];
        }
                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 [subscriber sendError:error];
                                                 [subscriber sendCompleted];
                                             }];
        [postOperation start];
        return [RACDisposable disposableWithBlock:^{
            [postOperation cancel];
        }];
    }];
}

@end
