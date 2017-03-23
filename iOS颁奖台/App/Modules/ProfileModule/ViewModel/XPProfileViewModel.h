//
//  XPProfileViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/11/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPProfileViewModel : XPBaseViewModel

@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) BOOL finished;

@property (nonatomic, strong, readonly) RACCommand *submitCommand;
@property (nonatomic, strong, readonly) RACCommand *logoutCommand;

@end
