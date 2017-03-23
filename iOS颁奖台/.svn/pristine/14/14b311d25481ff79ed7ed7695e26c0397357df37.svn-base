//
//  ScratchShowNoTime.m
//  XPApp
//
//  Created by Pua on 16/4/8.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "ScratchShowNoTime.h"
#import <ReactiveCocoa.h>
@implementation ScratchShowNoTime

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShowNoTimeUI];
    }
    return self;
}
-(void)createShowNoTimeUI
{
    @weakify(self)
    UIView *blackBgView = [[UIView alloc]initWithFrame:self.frame];
    self.blackBgView=blackBgView;
    blackBgView.backgroundColor = RGBA(0, 0, 0, 0.5);

    UIView *whiteBgView = [[UIView alloc]init];
    whiteBgView.layer.masksToBounds=YES;
    whiteBgView.layer.cornerRadius=6;
    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.cornerRadius = 10;

    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"今天这个活动的刮奖次数用完了\n去看看别的活动吧~";
    textLabel.numberOfLines = 2;
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = RGBA(117, 117, 117, 1);
    _knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_knowBtn setImage:[UIImage imageNamed:@"scratch_noTime_btn"] forState:UIControlStateNormal];
    [self addSubview:blackBgView];
    [blackBgView addSubview:whiteBgView];
    [whiteBgView addSubview:textLabel];
    [whiteBgView addSubview:_knowBtn];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blackBgView);
        make.centerY.equalTo(blackBgView);
//        make.width.mas_equalTo(243);
        make.left.equalTo(blackBgView).with.offset(25);
        make.right.equalTo(blackBgView).with.offset(-25);
        make.height.mas_equalTo(140);

    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteBgView.mas_top).with.offset(25);
        make.centerX.equalTo(whiteBgView);
//        make.bottom.equalTo(_knowBtn.mas_top).with.offset(-25);
    }];
    [_knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(textLabel.mas_bottom).with.offset(25);
        make.centerX.equalTo(whiteBgView);
        make.bottom.equalTo(whiteBgView.mas_bottom).with.offset(-15);
    }];
   
    [whiteBgView whenTapped:^{
        
    }];
}
-(void)dealloc{
    NSLog(@"xiaohui");
}
@end
















