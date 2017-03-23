//
//  XPMotionViewController.m
//  XPApp
//
//  Created by huangxinping on 15/11/17.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "SOMotionDetector+RACSignal.h"
#import "XPMotionViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface XPMotionViewController ()

@end

@implementation XPMotionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SOMotionDetector sharedInstance] startDetection];
    
    [[[SOMotionDetector sharedInstance] rac_motionTypeSignal]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     }];
    [[[SOMotionDetector sharedInstance] rac_locationSignal]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     }];
    [[[SOMotionDetector sharedInstance] rac_accelerationSignal]
     subscribeNext:^(NSValue *x) {
         CMAcceleration acceleration;
         [x getValue:&acceleration];
         NSLog(@"%.2f %.2f %.2f", acceleration.x, acceleration.y, acceleration.z);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
