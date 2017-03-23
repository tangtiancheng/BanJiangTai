//
//  ScratchShowNoWin.m
//  XPApp
//
//  Created by Pua on 16/4/8.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "ScratchShowNoWin.h"
#import <ReactiveCocoa.h>

@implementation ScratchShowNoWin
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShowNoWinUI];
    }
    return self;
}
-(void)createShowNoWinUI
{
    @weakify(self)
    UIView *blackBgView = [[UIView alloc]initWithFrame:self.frame];
    self.blackBgView=blackBgView;
    blackBgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *whiteBgView = [[UIView alloc]init];

    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.cornerRadius = 10;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scratch_nowin_image"]];
   
    UILabel *NotextLabel = [[UILabel alloc]init];
    NotextLabel.text = @"没关系，只是运气差了一点点~";
    NotextLabel.font = [UIFont systemFontOfSize:14];
    NotextLabel.textColor = RGBA(117, 117, 117, 1);

    _NoWinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_NoWinBtn setImage:[UIImage imageNamed:@"scratch_nowin_btn"] forState:UIControlStateNormal];
    [self addSubview:blackBgView];
    [blackBgView addSubview:whiteBgView];
    [whiteBgView addSubview:imageView];
    [whiteBgView addSubview:NotextLabel];
    [whiteBgView addSubview:_NoWinBtn];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(320);
        make.left.equalTo(blackBgView).with.offset(25);
        make.right.equalTo(blackBgView).with.offset(-25);
        make.height.mas_equalTo(195);
        make.centerX.equalTo(blackBgView);
        make.centerY.equalTo(blackBgView);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);
        make.top.mas_equalTo(whiteBgView.mas_top).with.offset(12);
//        make.bottom.mas_equalTo(NotextLabel.mas_top).with.offset(-18);
    }];
    [NotextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(17);
//        make.bottom.mas_equalTo(_NoWinBtn.mas_top).with.offset(-25);
    }];
    [_NoWinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);
//        make.top.mas_equalTo(NotextLabel.mas_bottom).with.offset(25);
        make.bottom.mas_equalTo(whiteBgView.mas_bottom).with.offset(-15);
    }];
//    [blackBgView whenTapped:^{
//        @strongify(self)
//        [self removeFromSuperview];
//
//    }];

    [whiteBgView whenTapped:^{
        
    }];
//    [_NoWinBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    
}
//-(void)btnClick{
//    [self removeFromSuperview];
//}
-(void)dealloc{
    NSLog(@"nowinxiaohui");
}
@end
