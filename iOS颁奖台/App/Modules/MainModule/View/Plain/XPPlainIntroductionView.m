//
//  XPPlainIntroduction.m
//  XPApp
//
//  Created by 唐天成 on 16/3/19.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPPlainIntroductionView.h"
#import <Masonry.h>
//天成修改
@interface XPPlainIntroductionView()

@property (nonatomic, strong)UIButton* buttonPlain;
@property (nonatomic, strong)UIScrollView* scrollerVIew;
@property (nonatomic, strong)UILabel* label;

@property(nonatomic,assign,getter=isPush)BOOL push;
@end

@implementation XPPlainIntroductionView

-(void)setPlainIntroduction:(NSString *)plainIntroduction{
    
    plainIntroduction =[plainIntroduction stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    //当接收到活动简介字符串时
    
    _plainIntroduction=plainIntroduction;
    NSLog(@"%@",plainIntroduction);

    UIFont* labelFont=[UIFont systemFontOfSize:textFontSize];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:labelLineSpace];
    NSDictionary *dict = @{NSFontAttributeName:labelFont ,NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize textSize = [plainIntroduction boundingRectWithSize:CGSizeMake(self.frame.size.width-2*borderr-buttonWidth-2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
//    NSLog(@"%@",NSStringFromCGSize(size));
    self.label.frame=CGRectMake(0, 0, textSize.width, textSize.height);
//    self.label.backgroundColor=[UIColor greenColor];
    //    self.label.text=detailPlain;
    //    [self.label sizeToFit];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_plainIntroduction];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:labelLineSpace];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_plainIntroduction length])];
    [self.label setAttributedText:attributedString1];
    
    [self.label sizeToFit];
    self.scrollerVIew.contentSize=CGSizeMake(textSize.width, textSize.height);
    
}
- (void)buttonClick:(id)sender {
    
    CGFloat Screenw=[UIScreen mainScreen].bounds.size.width;
    
    [UIView animateWithDuration:1.0 animations:^{
        if(self.push){
            self.transform=CGAffineTransformIdentity;
            self.push=NO;
            [self.buttonPlain setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        }else{
            self.transform=CGAffineTransformTranslate(self.transform, -(self.frame.size.width-buttonWidth-2), 0);
            self.push=YES;
            [self.buttonPlain setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
        }
    }];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setButton];
        [self setText];
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=2.0f;
    }
    return self;
}
-(void)setButton{
    
    self.buttonPlain=[[UIButton alloc]init];
    [self.buttonPlain setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.buttonPlain setBackgroundColor:[UIColor clearColor]];
    [self.buttonPlain addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //    self.buttonPlain.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 40, 0);
    
    self.buttonPlain.titleLabel.numberOfLines=0;
    
    [self.buttonPlain setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    self.buttonPlain.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    //    self.buttonPlain.imageEdgeInsets=UIEdgeInsetsMake(100, 0, -20, 0);
    //    self.buttonPlain.titleEdgeInsets=UIEdgeInsetsMake(0, 100, 0, -10);
    [self addSubview:self.buttonPlain];
    [self.buttonPlain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(38);
    }];
}
-(void)setText{
    UIView* view=[[UIView alloc]init];
    view.backgroundColor=RGBA(33, 33, 33, 0.85);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.topMargin.mas_equalTo(10);
        make.left.mas_equalTo(self.buttonPlain.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];

    self.scrollerVIew=[[UIScrollView alloc]init];
    self.scrollerVIew.showsHorizontalScrollIndicator=NO;
    self.scrollerVIew.showsVerticalScrollIndicator=NO;

    [view addSubview:self.scrollerVIew];
    self.scrollerVIew.backgroundColor=[UIColor clearColor];
    [self.scrollerVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.topMargin.mas_equalTo(10);
        make.left.mas_equalTo(view.mas_left).offset(9);
        make.top.mas_equalTo(view.mas_top).offset(15);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-15);
        make.right.mas_equalTo(view.mas_right).offset(-11);
    }];
    self.label=[[UILabel alloc]init];
    self.label.backgroundColor=[UIColor clearColor];
    [self.scrollerVIew addSubview:self.label];
//    self.label.lineBreakMode = UILineBreakModeWordWrap;
    self.label.numberOfLines=0;
    self.label.font=[UIFont systemFontOfSize:textFontSize];
    self.label.textColor=[UIColor whiteColor];
    
}

@end
