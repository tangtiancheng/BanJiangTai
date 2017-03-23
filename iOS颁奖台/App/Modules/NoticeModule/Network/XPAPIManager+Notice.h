//
//  XPAPIManager+Notice.h
//  XPApp
//
//  Created by xinpinghuang on 12/21/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Notice)

- (RACSignal *)noticeBanner;
- (RACSignal *)noticeWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

- (RACSignal *)noticeWithId:(NSString *)noticeId lastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize;

@end
