#import "XPBaseImageView.h"

@implementation XPBaseImageView

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0 ? YES : NO;
    self.layer.shouldRasterize = YES; // 设置光栅化，可以使离屏渲染的结果缓存到内存中存为位图，使用的时候直接使用缓存，节省了一直离屏渲染损耗的性能。
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;  //UIImageView不加这句会产生一点模糊
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = [borderColor copy];
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

@end
