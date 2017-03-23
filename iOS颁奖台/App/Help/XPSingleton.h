//
//  XPSingleton.h
//  XPApp
//
//  Created by 唐天成 on 16/3/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPMainModel.h"

@interface XPSingleton : NSObject
+(instancetype)shareSingleton;

@property(nonatomic,assign) NSInteger isSignIn;
@property(nonatomic,assign) NSInteger signCoinNum;

//签到返回的数据
@property (nonatomic, strong)XPMainSignInModel* signInModel;

@property (nonatomic, copy)NSString* continuousDays;//已经连续签到的天数

@property (nonatomic, copy)NSString* continuousTotalDays;//要求要达到的连续签到天数

@end
