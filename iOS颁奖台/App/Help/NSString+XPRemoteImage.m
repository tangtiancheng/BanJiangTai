//
//  NSString+XPRemoteImage.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "NSString+XPRemoteImage.h"
#import "UIImage+XPCompress.h"
#import <SDWebImage/SDImageCache.h>
#import <XPKit/XPKit.h>

@implementation NSString (XPRemoteImage)

- (RACSignal *)rac_remote_image
{
    if(!self) {
        return [RACSignal return :nil];
    }
    
    NSString *cacheKey = [self base64Encode];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:cacheKey];
    if(cacheImage) {
        return [RACSignal return :cacheImage];
    }
    
    return [[[NSData rac_readContentsOfURL:[NSURL URLWithString:self] options:NSDataReadingMappedIfSafe scheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]] catch:^RACSignal *(NSError *error) {
        return [RACSignal return :nil];
    }] map:^id (id value) {
        UIImage *remoteImage = [UIImage imageWithData:value];
        remoteImage = [UIImage imageWithData:[remoteImage xp_compress]];
        [[SDImageCache sharedImageCache] storeImage:remoteImage forKey:cacheKey];
        return remoteImage;
    }];
}

@end
