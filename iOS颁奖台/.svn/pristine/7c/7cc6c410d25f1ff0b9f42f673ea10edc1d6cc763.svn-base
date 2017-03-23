//
//  XPMainSignTableViewCell.m
//  XPApp
//
//  Created by 唐天成 on 16/3/20.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPMainSignTableViewCell.h"

@interface XPMainSignTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *signCoinNumLabel;

@end

//天成修改
@implementation XPMainSignTableViewCell
-(void)awakeFromNib{
    [self.signButton.layer setMasksToBounds:YES];
    [self.signButton.layer setCornerRadius:4.0];
    self.signButton.layer.borderWidth=1.0;
    self.signButton.layer.borderColor=[UIColor redColor].CGColor;
}
-(void)setSignCoinNum:(NSInteger)signCoinNum{
    _signCoinNum=signCoinNum;
    self.signCoinNumLabel.text=[NSString stringWithFormat:@"签到可领取%ld个奖金币",signCoinNum ];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
