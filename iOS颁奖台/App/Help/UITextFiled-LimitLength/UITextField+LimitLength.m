//
//  UITextField+LimitLength.m
//  JRFProject
//
//  Created by feng jia on 15-2-6.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/runtime.h>

@implementation UITextField (LimitLength)

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
static NSString *kEditEndBlockKey = @"kEditEndBlockKey";

- (void)xp_limitTextLength:(int)length block:(xp_EditEndBlock)block
{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(block) {
        objc_setAssociatedObject(self, (__bridge const void *)(kEditEndBlockKey), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(xp_textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(xp_textFieldDidEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)xp_textFieldDidEndEdit:(UITextField *)textField
{
    xp_EditEndBlock block = objc_getAssociatedObject(self, (__bridge const void *)(kEditEndBlockKey));
    if(block) {
        block(textField.text);
    }
}

- (void)xp_textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    //下面是修改部分
    bool isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    //[[UITextInputMode currentInputMode] primaryLanguage]，废弃的方法
    if([current.primaryLanguage isEqualToString:@"zh-Hans"] ||
       [current.primaryLanguage hasPrefix:@"zh-Hans"]) {
        isChinese = true;
    } else {
        isChinese = false;
    }
    if(sender == self) {
        // length是自己设置的位数
        NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if(isChinese) {  //中文输入法下
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if(!position) {
                if(str.length >= length) {
                    NSString *strNew = [NSString stringWithString:str];
                    [self setText:[strNew substringToIndex:length]];
                }
            } else {
                // NSLog(@"输入的");
            }
        } else {
            if([str length] >= length) {
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:length]];
            }
        }
    }
}

- (void)xp_shake
{
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}

@end
