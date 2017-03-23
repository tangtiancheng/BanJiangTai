//
//  ScratchShowSuccess.m
//  XPApp
//
//  Created by Pua on 16/4/8.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "ScratchShowSuccess.h"
#import <ReactiveCocoa.h>
@interface ScratchShowSuccess()
@property (nonatomic, strong)UILabel* textLabel;

@end

@implementation ScratchShowSuccess




- (instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShowSuccessUI];
    }
    return self;
}
-(void)createShowSuccessUI
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
    self.textLabel=textLabel;
    textLabel.numberOfLines=2;
    textLabel.textAlignment = NSTextAlignmentCenter;
//    textLabel.text = [NSString stringWithFormat:@"喜大普奔！快去领取%@!",_prizeName];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = RGBA(117, 117, 117, 1);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scratch_win_image"]];
    _scratchSuccess = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scratchSuccess setImage:[UIImage imageNamed:@"scratch_win_btnGo"] forState:UIControlStateNormal];
    _scratchNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scratchNext setImage:[UIImage imageNamed:@"scratch_win_btnNext"] forState:UIControlStateNormal];
    [self addSubview:blackBgView];
    [blackBgView addSubview:whiteBgView];
    [whiteBgView addSubview:imageView];
    [whiteBgView addSubview:textLabel];
    [whiteBgView addSubview:_scratchSuccess];
    [whiteBgView addSubview:_scratchNext];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blackBgView);
        make.centerY.equalTo(blackBgView);
//        make.width.mas_equalTo(320);
        make.left.equalTo(self).with.offset(25);
        make.right.equalTo(self).with.offset(-25);
        make.height.mas_equalTo(250);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);

        make.top.mas_equalTo(whiteBgView.mas_top).with.offset(9);

    }];
    
    NSString* str=@"喜大普奔！快去领取BOSE无线音箱! ";
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGFloat length=textSize.width;
    NSLog(@"%lf",length);
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.centerX.equalTo(whiteBgView);
        make.width.mas_equalTo(length);
//        make.left.equalTo(whiteBgView.mas_left);
//        make.right.equalTo(whiteBgView.mas_right);


        make.top.equalTo(imageView.mas_bottom).with.offset(10);
//        make.bottom.equalTo(_Scratchsuccess.mas_top).with.offset(-25);

    }];
    [_scratchSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);

//        make.top.equalTo(imageView.mas_bottom).with.offset(25);
        make.bottom.equalTo(_scratchNext.mas_top).with.offset(-15);

    }];
    [_scratchNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteBgView);

//        make.top.equalTo(_Scratchsuccess.mas_bottom).with.offset(10);
        make.bottom.equalTo(whiteBgView.mas_bottom).with.offset(-12);
    }];
//    [blackBgView whenTapped:^{
//        @strongify(self)
//        [self removeFromSuperview];
//
//    }];

    [whiteBgView whenTapped:^{
        
    }];
//    [[_scratchNext rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        @strongify(self)
//        [self removeFromSuperview];
//    }];
}
-(void)setPrizeName:(NSString *)prizeName{
    _prizeName=prizeName;
    self.textLabel.text = [NSString stringWithFormat:@"喜大普奔！快去领取%@!",_prizeName];

}

-(void)dealloc{
    NSLog(@"xiaohui");
}
@end






