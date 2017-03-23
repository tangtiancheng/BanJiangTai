//
//  XPAPIManager+XPPostImage.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSDictionary+XPUserInfo.h"
#import "XPAPIManager+Analysis.h"
#import "XPAPIManager+XPPostImage.h"

@implementation XPAPIManager (XPPostImage)

- (RACSignal *)rac_postRemoteImage:(NSData *)imageData
{
    if(!imageData) {
        return [RACSignal empty];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/plain", @"text/html", nil];
        manager.requestSerializer.timeoutInterval = 30;
        manager.responseSerializer.acceptableStatusCodes = nil;
        NSDictionary *parameters = [@{
                                      @"imageType":@"jpg",
                                      @"imageBody":[imageData base64Encode]
                                      }
                                    fillUserInfo];
        
        AFHTTPRequestOperation *operation = [manager POST:[NSString stringWithFormat:@"%@/ernie/user/updateImage.ernie", XPAPIBaseURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id analysisResult = [self analysisRequest:responseObject];
            if([analysisResult isKindOfClass:[NSError class]]) {
                [subscriber sendError:analysisResult];
            } else {
                [subscriber sendNext:analysisResult[@"imageUrl"]];
            }
            
            [subscriber sendCompleted];
        }
                                                failure  :^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    [subscriber sendError:error];
                                                    [subscriber sendCompleted];
                                                }];
        //        AFHTTPRequestOperation *operation = [manager POST:@"http://192.168.111.209:8080/ernie/user/updateImage.ernie" parameters:parameters
        //                                constructingBodyWithBlock:^(id formData) {
        //                                    //                                    [formData appendPartWithFormData:imageData name:@"imageBody"];
        //                                }
        //                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                                                      @strongify(self);
        //                                                      [subscriber sendNext:[self analysisRequest:responseObject]];
        //                                                      [subscriber sendCompleted];
        //                                                  }
        //                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //                                                      [subscriber sendNext:error];
        //                                                      [subscriber sendCompleted];
        //                                                  }];
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

@end
