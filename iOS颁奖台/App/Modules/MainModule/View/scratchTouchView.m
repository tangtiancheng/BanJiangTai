//
//  scratchTouchView.m
//  XPApp
//
//  Created by Pua on 16/4/11.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "scratchTouchView.h"

@implementation scratchTouchView
{
    NSInteger totalTouch;
    UIImageView *bg_View;
    UIView *mainView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bg_View = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scrape_front"]];
        bg_View.frame=frame;
        bg_View.contentMode = UIViewContentModeScaleToFill;
        mainView = [[UIView alloc]initWithFrame:frame];
        mainView.backgroundColor = [UIColor clearColor];
        [mainView addSubview:bg_View];
        [self setOpaque:NO];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor =[ UIColor clearColor];
        [self setSizeBrush:100];
        [self setHideView:mainView];
//        _sizeBrush = 10.0;
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIImage *imageToDraw = [UIImage imageWithCGImage:scratchImage];
    [imageToDraw drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
-(void)setHideView:(UIView *)hideView
{
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
    NSInteger bitmapByteCount;
    NSInteger bitmapBytesPerRow;
    float scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(hideView.bounds.size, NO, 0);
    [hideView.layer renderInContext:UIGraphicsGetCurrentContext()];
    hideView.layer.contentsScale = scale;
    hideImage = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    size_t imageWidth = CGImageGetWidth(hideImage);
    size_t imageHeight = CGImageGetHeight(hideImage);
    
    bitmapBytesPerRow = (imageWidth *4);
    bitmapByteCount = (bitmapBytesPerRow * imageHeight);
    
    CFMutableDataRef pixels = CFDataCreateMutable(NULL, imageWidth * imageHeight);
    contextMask = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), imageWidth, imageHeight, 8, imageWidth, colorspace, kCGImageAlphaNone);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(pixels);
    
    CGContextSetFillColorWithColor(contextMask, [UIColor blackColor].CGColor);
    CGContextFillRect(contextMask, self.frame);
    CGContextSetStrokeColorWithColor(contextMask, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(contextMask, _sizeBrush);
    CGContextSetLineCap(contextMask, kCGLineCapRound);
    CGImageRef mask = CGImageMaskCreate(imageWidth, imageHeight, 8,8 , imageWidth, dataProvider,nil , NO);
    scratchImage = CGImageCreateWithMask(hideImage, mask);
    CGImageRelease(mask);
    CGColorSpaceRelease(colorspace);
}

- (void)scratchTheViewFrom:(CGPoint)startPoint to:(CGPoint)endPoint
{
    float scale = [UIScreen mainScreen].scale;
    CGContextMoveToPoint(contextMask, startPoint.x * scale, (self.frame.size.height - startPoint.y) * scale);
    CGContextAddLineToPoint(contextMask, endPoint.x * scale, (self.frame.size.height - endPoint.y)* scale);
    CGContextStrokePath(contextMask);
    [self setNeedsDisplay];
    CGPathRef pathRef = CGContextCopyPath(contextMask);
    if (!CGPathContainsPoint(pathRef, NULL, startPoint, NO)) {
        totalTouch = 4*100+totalTouch;
        [self whenTouchedUp:^{
            if (totalTouch>=(self.frame.size.width/2)*(self.frame.size.height/2)) {
                self.block(self);
            }
        }];
       
    }
}
#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event touchesForView:self] anyObject];
    currentTouchLocation = [touch locationInView:self];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [[event touchesForView:self]anyObject];
    if (!CGPointEqualToPoint(previousTouchLoaction, CGPointZero)) {
        currentTouchLocation = [touch locationInView:self];
    }

    
    previousTouchLoaction = [touch previousLocationInView:self];
    
    [self scratchTheViewFrom:previousTouchLoaction to:currentTouchLocation];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [[event touchesForView:self]anyObject];
    if (!CGPointEqualToPoint(previousTouchLoaction, CGPointZero))
    {
        previousTouchLoaction = [touch previousLocationInView:self];
        [self scratchTheViewFrom:previousTouchLoaction to:currentTouchLocation];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}
-(void)initScratch
{
    currentTouchLocation = CGPointZero;
    previousTouchLoaction = CGPointZero;
}
-(void)dealloc{
    NSLog(@"xiaohui");
}

@end
