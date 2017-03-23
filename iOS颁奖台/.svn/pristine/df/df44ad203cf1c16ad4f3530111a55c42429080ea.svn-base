//
//  XPMotionManager.h
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>

@interface XPMotionManager : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign, readonly) CMAcceleration acceleration;
@property (nonatomic, assign, readonly) BOOL shaking;

+ (instancetype)sharedInstance;

- (void)startDetection;
- (void)stopDetection;

@end
