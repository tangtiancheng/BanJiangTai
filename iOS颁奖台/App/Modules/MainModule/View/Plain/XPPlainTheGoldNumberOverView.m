//
//  XPPlainTheGoldNumberOverView.m
//  XPApp
//
//  Created by 唐天成 on 16/3/27.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainTheGoldNumberOverView.h"

@implementation XPPlainTheGoldNumberOverView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainTheGoldNumberOver" owner:self options:nil] lastObject];
}
-(void)awakeFromNib{
    self.howToGetGoldBtn.layer.masksToBounds=YES;
    self.howToGetGoldBtn.layer.cornerRadius=self.howToGetGoldBtn.height/2;
    self.howToGetGoldBtn.layer.borderWidth=2;
    self.howToGetGoldBtn.layer.borderColor=RGBA(188, 188, 188, 1.0).CGColor;
    [self.backView whenTapped:^{
        
    }];
}
@end
