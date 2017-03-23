//
//  XPMotionManager.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPMotionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>
#import <XPMotionDetector/XPMotionDetector.h>

@interface XPMotionManager ()

//@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign, readwrite) CMAcceleration acceleration;
@property (nonatomic, assign, readwrite) BOOL shaking;

@end

@implementation XPMotionManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XPMotionManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[XPMotionManager alloc] init];
        instance.shaking = NO;
    });
    return instance;
}

- (void)startDetection
{
    @weakify(self);
    [XPMotionDetector sharedInstance].locationChangedBlock = ^(CLLocation *location) {
        @strongify(self);
        self.location = location;
    };
    
    [XPMotionDetector sharedInstance].accelerationChangedBlock = ^(CMAcceleration acceleration) {
        @strongify(self);
        self.acceleration = acceleration;
        if(self.shaking != [XPMotionDetector sharedInstance].isShaking) {
            self.shaking = [XPMotionDetector sharedInstance].isShaking;
        }
    };
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [XPMotionDetector sharedInstance].useM7IfAvailable = YES;
    }
    
    [[XPMotionDetector sharedInstance] startDetection];
}

- (void)stopDetection
{
    [[XPMotionDetector sharedInstance] stopDetection];
}

@end
