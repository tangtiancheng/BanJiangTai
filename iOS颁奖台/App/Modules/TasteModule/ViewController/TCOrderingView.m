//
//  TCOrderingView.m
//  XPApp
//
//  Created by 唐天成 on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TCOrderingView.h"
#import "ScratchBtn.h"
#import "TCCustomBtn.h"
@interface TCOrderingView()

//点菜
//@property (weak, nonatomic) IBOutlet UIButton *orderView;

@end


@implementation TCOrderingView
+(instancetype)orderingView{
    TCOrderingView* headView= [[NSBundle mainBundle] loadNibNamed:@"TCOrderingView" owner:nil options:nil][0];
    headView.hidden=YES;
//    headView.btn.titleLabel.backgroundColor=[UIColor yellowColor];
//    headView.btn.imageView.backgroundColor=[UIColor  redColor];
//    [headView.btn setTitle:@"点菜" forState:UIControlStateNormal];
    [headView.orderDishBtn setImage:[UIImage imageNamed:@"calendar_check"] forState:UIControlStateNormal];
    
   //    self.btn.titleLabel.backgroundColor=[UIColor yellowColor];
//    self.btn.imageView.backgroundColor=[UIColor redColor];
//    [headView.orderView setTitle:@"点菜" forState:UIControlStateNormal ];
//    TCCustomBtn* btn = [[TCCustomBtn alloc]init];
//    [btn setTitle:@"点菜" forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"common_check_box_selected"] forState:UIControlStateNormal];
////    btn.left=0 ;
////    btn.top=0;
//    btn.centerY=25;
//    btn.centerX=50;
//    btn.backgroundColor=[UIColor redColor];
//    [headView addSubview:btn];
    
    //    .dashImage.cornerRadius=12;//self.dashImage.height/2;
    return headView;
}
@end
