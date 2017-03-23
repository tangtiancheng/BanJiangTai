//
//  XPPlainTheShakeNumberOverView.m
//  XPApp
//
//  Created by 唐天成 on 16/3/27.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainTheShakeNumberOverView.h"

@implementation XPPlainTheShakeNumberOverView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainTheShakeNumberOver" owner:self options:nil] lastObject];
}
-(void)awakeFromNib{
    self.goTomorrowBtn.layer.masksToBounds=YES;
    self.goTomorrowBtn.layer.cornerRadius=self.goTomorrowBtn.height/2;
    self.goTomorrowBtn.layer.borderWidth=2;
    self.goTomorrowBtn.layer.borderColor=RGBA(188, 188, 188, 1.0).CGColor;
    self.iconView.layer.masksToBounds=YES;
    self.iconView.layer.cornerRadius=self.iconView.width/2;
    [self.backView whenTapped:^{
        
    }];
}

@end
