//
//  ScratchTicketTouchView.m
//  XPApp
//
//  Created by 唐天成 on 16/4/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "ScratchTicketTouchView.h"
@interface ScratchTicketTouchView()

@end


@implementation ScratchTicketTouchView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:frame];
//        imageView.frame=self.ticketImageView.bounds;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:@"scrape_back"];
        UILabel *prizeLabel = [[UILabel alloc]init];
        self.label=prizeLabel;
        prizeLabel.font=[UIFont systemFontOfSize:50];
        prizeLabel.textAlignment=NSTextAlignmentCenter;
        prizeLabel.frame = frame;
        prizeLabel.textColor=RGBA(255, 0, 0, 1);
        prizeLabel.backgroundColor = [UIColor clearColor];
        
        self.touchView=[[scratchTouchView alloc]initWithFrame:frame];
        __weak typeof(self) ticketTouchView=self;
        self.touchView.block=^(scratchTouchView *touchView){
            [touchView removeFromSuperview];
            ticketTouchView.touchBlock();
        };
        
        [self addSubview:imageView];
        [self addSubview:prizeLabel];
        [self addSubview:self.touchView];

    }
    return self;
}
-(void)a
{

}
-(void)dealloc{
    NSLog(@"ScratchTicketTouchView销毁");
}
@end
