//
//  XPPlainTenSecondCounterView.h
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseView.h"

@interface XPPlainTenSecondCounterView : XPBaseView

+ (instancetype)loadFromNib;

- (void)startCounterWithOffset:(NSInteger)offset;

@end
