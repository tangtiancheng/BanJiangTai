//
//  UILabel+XPAttribute.m
//  XPApp
//
//  Created by xinpinghuang on 1/22/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "UILabel+XPAttribute.h"

@implementation UILabel (XPAttribute)

- (void)xp_attributed:(NSArray *)textArray colorArray:(NSArray *)colorArray fontArray:(NSArray *)fontArray
{
    NSInteger minCount = MIN(MIN(textArray.count, colorArray.count), fontArray.count);
    NSMutableString *text = [NSMutableString string];
    for(NSString *buffer in textArray) {
        [text appendString:buffer];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSInteger startLocation = 0;
    for(NSInteger i = 0; i < minCount; i++) {
        [attributedString addAttributes:@{NSForegroundColorAttributeName:colorArray[i], NSFontAttributeName:fontArray[i]}
                                  range:NSMakeRange(startLocation, [textArray[i] length])];
        startLocation += [textArray[i] length];
    }
    self.attributedText = attributedString;
}

@end
