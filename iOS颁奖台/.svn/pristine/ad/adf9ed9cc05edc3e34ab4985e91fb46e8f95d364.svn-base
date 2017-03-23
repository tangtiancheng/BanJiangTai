//
//  scratchTouchView.h
//  XPApp
//
//  Created by Pua on 16/4/11.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface scratchTouchView : UIView
{
    CGPoint previousTouchLoaction;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;
    
    CGContextRef contextMask;
}
typedef void (^MyBlock)(scratchTouchView*);
@property (nonatomic , assign) float percentAccomplishment;
/**
 *  刮奖范围大小
 */
@property (nonatomic , assign) float sizeBrush;
@property (nonatomic , strong) UIView *hideView;
@property (nonatomic , copy) MyBlock block;
-(void)setHideView:(UIView *)hideView;
@end
