//
//  IWTitleButton.m
//  传智WB
//
//  Created by tarena on 15/10/21.
//  Copyright (c) 2015年 唐天成. All rights reserved.
//

#import "TCCustomBtn.h"
#define IWTitleButtonImageW 20

@interface TCCustomBtn()
{
    CGFloat imageWhiteWidth;
}
@end

@implementation TCCustomBtn
-(void)awakeFromNib{
    // 文字颜色
//    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    // 高亮时不要让imageView变灰色
    self.adjustsImageWhenHighlighted = NO;
    //让图片居中,(原来大小)
    self.imageView.contentMode=UIViewContentModeCenter;
    
    //文字靠右放
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
//    self.titleLabel.backgroundColor=[UIColor redColor];
//    self.imageView.backgroundColor=[UIColor yellowColor];
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
     self.imageView.layer.masksToBounds = NO;
    // 背景
    //        [self setBackgroundImage:[UIImage imageNamed::@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];

}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        // 文字颜色
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.titleLabel.font=[UIFont systemFontOfSize:23];
//        self.titleLabel.backgroundColor=[UIColor yellowColor];
//        self.imageView.backgroundColor=[UIColor purpleColor];
        // 高亮时不要让imageView变灰色
        self.adjustsImageWhenHighlighted = NO;
        //让图片居中,(原来大小)
        self.imageView.contentMode=UIViewContentModeCenter;
        //文字靠右放
//        self.titleLabel.textAlignment=NSTextAlignmentRight;
         self.imageView.layer.masksToBounds = NO;
        // 背景
        //        [self setBackgroundImage:[UIImage imageNamed::@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

// 标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
     NSLog(@"%@",NSStringFromCGRect(contentRect));
    CGFloat titleY=0;
    CGFloat titleX=0;
    // 整个按钮的宽度 - 图片的宽度
    CGFloat titleW=contentRect.size.width-imageWhiteWidth;
    CGFloat titleH=contentRect.size.height;
    NSLog(@"%f",titleW);
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}
// 图标的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    NSLog(@"%@",NSStringFromCGRect(contentRect));
    CGFloat imageY = 0;
    CGFloat imageW = imageWhiteWidth;
    CGFloat imageX =contentRect.size.width  - imageW;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
    
}
////设置文字时确定按钮尺寸
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    NSLog(@"%@",self.titleLabel.font);
    NSDictionary *dict = @{NSFontAttributeName:self.titleLabel.font };
    CGSize titleSize= [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    
    //    =[title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect frame = self.frame;
    frame.size.width=titleSize.width+30;
    self.frame=frame;
//    self.width=titleSize.width+IWTitleButtonImageW+20*2;
//    self.height=titleSize.height;
    NSLog(@"%lf  %lf",self.width,self.height);
    [self sizeToFit];
    
}
// 重写目的,不需要覆盖之前的做法
// 扩充这个方法的功能

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    CGSize size = image.size;
    imageWhiteWidth = size.width;
    NSLog(@"%@",NSStringFromCGSize(size));
    [self sizeToFit];
    
}

@end
