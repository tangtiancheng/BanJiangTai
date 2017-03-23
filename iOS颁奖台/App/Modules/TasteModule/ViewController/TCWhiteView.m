//
//  TCWhiteView.m
//  XPApp
//
//  Created by 唐天成 on 16/7/11.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TCWhiteView.h"

@implementation TCWhiteView
-(void)setBusinessTag:(NSArray<NSString *> *)businessTag{
    _businessTag=businessTag;
    NSInteger count = businessTag.count;
    count=5;
//    for(int i = 0;i<count;i++){
//        /**
//         应急写的
//         */
//        UIImageView *dishImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_24hours"]];
//        dishImage1.contentMode=UIViewContentModeCenter;
//        dishImage1.frame=CGRectMake(self.width/count*i,0 ,  self.width/count,self.height);
//        [self addSubview:dishImage1];
//        
//    }
    UIImageView *dishImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_24hours"]];
    dishImage1.contentMode=UIViewContentModeCenter;
    dishImage1.frame=CGRectMake(self.width/5*0,0 ,  self.width/count,self.height);
    [self addSubview:dishImage1];
    
    UIImageView *dishImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_apple-pay"]];
    dishImage2.contentMode=UIViewContentModeCenter;
    dishImage2.frame=CGRectMake(self.width/5*1,0 ,  self.width/count,self.height);
    [self addSubview:dishImage2];
    
    UIImageView *dishImage3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_babycar"]];
    dishImage3.contentMode=UIViewContentModeCenter;
    dishImage3.frame=CGRectMake(self.width/5*2,0 ,  self.width/count,self.height);
    [self addSubview:dishImage3];
    
    UIImageView *dishImage4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_part"]];
    dishImage4.contentMode=UIViewContentModeCenter;
    dishImage4.frame=CGRectMake(self.width/5*3,0 ,  self.width/count,self.height);
    [self addSubview:dishImage4];
    
    UIImageView *dishImage5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dish_wifi"]];
    dishImage5.contentMode=UIViewContentModeCenter;
    dishImage5.frame=CGRectMake(self.width/5*4,0 ,  self.width/count,self.height);
    [self addSubview:dishImage5];
    
//    UIView* line1=[[UIView alloc]initWithFrame:CGRectMake(self.width/count*1,self.height/3,3,1/3*self.height)];
//    line1.backgroundColor=[UIColor blackColor];
//    [self addSubview:line1];
//    
//    UIView* line2=[[UIView alloc]initWithFrame:CGRectMake(self.width/count*2 , self.height/3 , 3 , 1/3*self.height)];
//    line2.backgroundColor=[UIColor greenColor];
//    [self addSubview:line2];
//    
//    UIView* line3=[[UIView alloc]initWithFrame:CGRectMake(self.width/count*3,self.height/3,1,3/3*self.height)];
//    line3.backgroundColor=[UIColor yellowColor];
//    [self addSubview:line3];
//    
//    UIView* line4=[[UIView alloc]initWithFrame:CGRectMake(self.width/count*4,self.height/3,3,1/3*self.height)];
//    line4.backgroundColor=[UIColor redColor];
//    [self addSubview:line4];
    
    
    
    
    UIView* v1 = [[UIView alloc]init];
    v1.frame=CGRectMake(0, 0, self.width, 1);
    v1.backgroundColor=[UIColor blackColor];
    [self addSubview:v1];

}
@end
