//
//  calendarView.h
//  XPApp
//
//  Created by Pua on 16/3/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPMainModel.h"
@interface calendarView : UIView
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) NSMutableArray *signArray;
@property (nonatomic , strong) NSMutableArray *lastMonthSingDaysArr;
@property (nonatomic , copy) void (^calendarBlock)(NSInteger year,NSInteger month,NSInteger day);
//今天
@property (nonatomic , strong) UIButton *dayButton;
@property (nonatomic , strong) XPMainSignInModel *model;

-(void)setStyle_Today_Signed:(UIButton *)btn;
-(void)setStyle_Today:(UIButton *)btn;

@end
