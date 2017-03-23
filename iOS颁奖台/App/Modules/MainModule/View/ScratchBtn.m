//
//  IWTitleButton.m
//  传智WB
//
//  Created by tarena on 15/10/21.
//  Copyright (c) 2015年 唐天成. All rights reserved.
//

#import "ScratchBtn.h"
#define IWTitleButtonImageW 14
@implementation ScratchBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        // 高亮时不要让imageView变灰色
        self.adjustsImageWhenHighlighted = NO;
        //让图片居中,(原来大小)
        self.imageView.contentMode=UIViewContentModeCenter;
        //文字靠右放
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        // 背景
//        [self setBackgroundImage:[UIImage imageNamed::@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

// 标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY=0;
    CGFloat titleX=0;
    // 整个按钮的宽度 - 图片的宽度
    CGFloat titleW=self.width-IWTitleButtonImageW;
    CGFloat titleH=self.height;
    NSLog(@"%f",titleW);
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}
// 图标的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 0;
    CGFloat imageW = IWTitleButtonImageW;
    CGFloat imageX = self.width - imageW;
    CGFloat imageH = self.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
    
}
//设置文字时确定按钮尺寸
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    NSLog(@"%f",self.width);
     NSDictionary *dict = @{NSFontAttributeName:self.titleLabel.font };
   CGSize titleSize= [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    

//    =[title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.width=titleSize.width+IWTitleButtonImageW;
    self.height=titleSize.height;
}

@end
