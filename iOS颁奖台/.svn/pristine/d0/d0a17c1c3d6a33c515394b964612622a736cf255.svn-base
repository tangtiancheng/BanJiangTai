//
//  NSObject+XPShareSDK.m
//  XPApp
//
//  Created by xinpinghuang on 1/4/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSObject+XPShareSDK.h"

@implementation NSObject (XPShareSDK)

- (RACSignal *)shareWithTitle:(NSString *)title content:(NSString *)content images:(NSArray *)images url:(NSString *)url platformType:(SSDKPlatformType)platformType
{
    NSLog(@"%@",url);
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content
                                         images:images
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch(state) {
                case SSDKResponseStateSuccess: {
                    [subscriber sendNext:contentEntity];
                    [subscriber sendCompleted];
                }
                    break;
                    
                case SSDKResponseStateFail: {
                    [subscriber sendError:error];
                    [subscriber sendCompleted];
                }
                    break;
                    
                default: {
                }
                    break;
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
