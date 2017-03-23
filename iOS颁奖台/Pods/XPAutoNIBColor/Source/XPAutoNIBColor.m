//
//  XPAutoNIBColor.m
//  Yulequan
//
//  Created by huangxinping on 4/26/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPAutoNIBColor.h"
#import <objc/runtime.h>

static char *const XPAutoNIBColorPlateKey = "XPAutoNIBColorPlateKey";

@implementation XPAutoNIBColor

+ (void)setAutoNIBColorWithPrimaryColor:(UIColor *)primaryColor secondaryColor:(UIColor *)secondaryColor tertiaryColor:(UIColor *)tertiaryColor, ...{
    NSMutableArray *colorPlate = [NSMutableArray array];
    if(primaryColor) {
        [colorPlate addObject:primaryColor];
    }
    if(secondaryColor) {
        [colorPlate addObject:secondaryColor];
    }
    if(tertiaryColor) {
        [colorPlate addObject:tertiaryColor];
    }
    
    va_list args;
    va_start(args, tertiaryColor);
    if(tertiaryColor) {
        UIColor *nextArg;
        while((nextArg = va_arg(args, UIColor *))) {
            [colorPlate addObject:nextArg];
        }
    }
    
    va_end(args);
    
    objc_setAssociatedObject(self, XPAutoNIBColorPlateKey, colorPlate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)colorWithName:(NSString *)name
{
    NSAssert([[name substringToIndex:1] isEqualToString:@"c"], @"name首字母必须为c（格式为：c1/c2/c3...）");
    NSUInteger index = [[name substringFromIndex:1] integerValue];
    NSArray *colorPlate = objc_getAssociatedObject(self, XPAutoNIBColorPlateKey);
    if(!colorPlate || index > colorPlate.count || index <= 0) {
        return nil;
    }
    
    UIColor *color = colorPlate[index - 1];
    return color;
}

@end
