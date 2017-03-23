//  XPPlainFinished.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPPlainTenMinuteCounterView.h"

@interface XPPlainTenMinuteCounterView ()

@property (nonatomic, weak) IBOutlet UILabel *tenMinuteCounterLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger counter;

@end

@implementation XPPlainTenMinuteCounterView

+ (instancetype)loadFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PlainTenMinuteCounter" owner:self options:nil] lastObject];
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

- (void)updateUI
{
    self.tenMinuteCounterLabel.text = [NSString stringWithFormat:@"%.2ld:%.2ld", self.counter/60, self.counter%60];
    if(self.counter <= 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)forceKillTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

@end
