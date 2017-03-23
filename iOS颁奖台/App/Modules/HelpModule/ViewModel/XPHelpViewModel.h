//
//  XPHelpViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface XPHelpViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong, readonly) RACCommand *submitCommand;

@property (nonatomic, strong, readonly) NSString *helpURL;
@property (nonatomic, strong, readonly) RACCommand *helpCommand;

@end
