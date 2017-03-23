//
//  XPPlainTenSecondCounterView.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainTenSecondCounterView.h"

@interface XPPlainTenSecondCounterView ()

@property (nonatomic, weak) IBOutlet UIImageView *counterNumberImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger counter;

@end

@implementation XPPlainTenSecondCounterView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainTenSecondCounter" owner:self options:nil] lastObject];
}

- (void)updateUI
{
    self.counterNumberImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_number_%ld", (long)self.counter]];
    if(self.counter <= 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startCounterWithOffset:(NSInteger)offset
{
    self.counter = offset;
    [self updateUI];
    @weakify(self);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
        @strongify(self);
        self.counter -= 1;
        [self updateUI];
    }
                                                 repeats:YES];
}

@end
