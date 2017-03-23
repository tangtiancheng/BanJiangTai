//
//  XPScrapePrizeView.m
//  XPApp
//
//  Created by 唐天成 on 16/4/7.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPScrapePrizeView.h"

@interface XPScrapePrizeView()
@property (nonatomic, strong)UILabel* prizeLabel;

@end

@implementation XPScrapePrizeView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self setInterface];
    }
    return self;
}
-(void)setInterface{
//    self.backgroundColor=[UIColor redColor];
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"oval"]];
    [self addSubview:imageView];
    self.prizeLabel=[[UILabel alloc]init];
    self.prizeLabel.font=[UIFont systemFontOfSize:14];
    self.prizeLabel.textColor=[UIColor whiteColor];
    [self addSubview:self.prizeLabel];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(imageView.width));
        make.height.equalTo(@(imageView.height));
//        make.right.equalTo(self.prizeLabel.mas_left).with.offset(9);
    }];
    [self layoutIfNeeded];

    NSLog(@"%@",NSStringFromCGRect(imageView.frame));
       [self.prizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).with.offset(9);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
}
-(void)setMainPlainPrizeModel:(XPMainPlainPrizeModel *)mainPlainPrizeModel{
    _mainPlainPrizeModel=mainPlainPrizeModel;
    self.prizeLabel.text=[NSString stringWithFormat:@"%@ : %@",mainPlainPrizeModel.prizeGradeName,mainPlainPrizeModel.prizeTitle];
}
@end
