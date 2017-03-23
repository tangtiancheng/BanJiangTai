//
//  showShareToView.m
//  XPApp
//
//  Created by Pua on 16/5/9.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "showShareToView.h"

@implementation showShareToView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;

}
-(void)createUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *bigView = [[UIView alloc]init];
    bigView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"分享至";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBA(208, 208, 208, 1);
    bigView.layer.cornerRadius = 5;
    _weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_weChatBtn setImage:[UIImage imageNamed:@"wechat_frind"] forState:UIControlStateNormal];
    _weFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_weFriendBtn setImage:[UIImage imageNamed:@"wechat_frindship"] forState:UIControlStateNormal];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:[NSString stringWithFormat:@"取消"] forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor]];
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    _cancelBtn.layer.cornerRadius = 5;
    [bigView addSubview:_weChatBtn];
    [bigView addSubview:_weFriendBtn];
    [bigView addSubview:lineView];
    [bigView addSubview:label];
    [self addSubview:_cancelBtn];
    [self addSubview:bigView];
    [bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.bottom.equalTo(_cancelBtn.mas_top).with.offset(-5);
        make.height.mas_equalTo(120);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigView.mas_top).with.offset(12);
        make.centerX.equalTo(bigView);
        make.bottom.equalTo(lineView.mas_top).with.offset(-12);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).with.offset(12);
        make.centerX.equalTo(bigView);
        make.bottom.equalTo(bigView).with.offset(-28);
        make.width.mas_equalTo(1);
    }];
    [_weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(60);
        make.centerY.equalTo(bigView);
        make.right.equalTo(lineView.mas_left).with.offset(-44);
    }];
    [_weFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.centerY.equalTo(bigView);
        make.height.mas_equalTo(60);
        make.left.equalTo(lineView.mas_right).with.offset(44);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigView.mas_bottom).with.offset(5);
        make.left.equalTo(self).with.offset(5);
        make.right.equalTo(self).with.offset(-5);
        make.bottom.equalTo(self).with.offset(-5);
        make.height.mas_equalTo(50);
    }];
}
@end
