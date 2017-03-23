//
//  SOMotionDetector+RACSignal.m
//  XPApp
//
//  Created by huangxinping on 15/11/17.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import "SOMotionDetector+RACSignal.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <objc/runtime.h>

@interface SOMotionDetectorProxyDelegate : NSObject <SOMotionDetectorDelegate>
@property (nonatomic, weak) id<SOMotionDetectorDelegate> motionDetectorProxyDelegate;
@end
@implementation SOMotionDetectorProxyDelegate

#pragma mark - SOMotionDetectorDelegate
- (void)motionDetector:(SOMotionDetector *)motionDetector motionTypeChanged:(SOMotionType)motionType
{
    if(self.motionDetectorProxyDelegate &&
       [self.motionDetectorProxyDelegate respondsToSelector:@selector(motionDetector:motionTypeChanged:)]) {
        return [self.motionDetectorProxyDelegate motionDetector:motionDetector motionTypeChanged:motionType];
    }
}

- (void)motionDetector:(SOMotionDetector *)motionDetector locationChanged:(CLLocation *)location
{
    if(self.motionDetectorProxyDelegate &&
       [self.motionDetectorProxyDelegate respondsToSelector:@selector(motionDetector:locationChanged:)]) {
        return [self.motionDetectorProxyDelegate motionDetector:motionDetector locationChanged:location];
    }
}

- (void)motionDetector:(SOMotionDetector *)motionDetector accelerationChanged:(CMAcceleration)acceleration
{
    if(self.motionDetectorProxyDelegate &&
       [self.motionDetectorProxyDelegate respondsToSelector:@selector(motionDetector:accelerationChanged:)]) {
        return [self.motionDetectorProxyDelegate motionDetector:motionDetector accelerationChanged:acceleration];
    }
}

@end

@interface SOMotionDetector () <SOMotionDetectorDelegate>

@property (nonatomic, strong) SOMotionDetectorProxyDelegate *delegateObject;

@end

@implementation SOMotionDetector (RACSignal)

- (id)delegateObject
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if(obj) {
        return obj;
    }
    
    obj = [[SOMotionDetectorProxyDelegate alloc] init];
    self.delegate = obj;
    objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return obj;
}

- (void)setProxyDelegate:(id<SOMotionDetectorDelegate>)proxyDelegate
{
    self.delegateObject.motionDetectorProxyDelegate = proxyDelegate;
}

- (id)proxyDelegate
{
    return self.delegateObject.motionDetectorProxyDelegate;
}

- (RACSignal *)rac_motionTypeSignal
{
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal) {
        return signal;
    }
    
    signal = [self.delegateObject rac_signalForSelector:@selector(motionDetector:motionTypeChanged:) fromProtocol:@protocol(SOMotionDetectorDelegate)];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[signal map:^id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        RACTupleUnpack(id first, id second) = value;
#pragma clang diagnostic pop
        return second;
    }] setNameWithFormat:@"[%@] -rac_motionType", self];
}

- (RACSignal *)rac_locationSignal
{
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal) {
        return signal;
    }
    
    signal = [self.delegateObject rac_signalForSelector:@selector(motionDetector:locationChanged:) fromProtocol:@protocol(SOMotionDetectorDelegate)];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[signal map:^id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        RACTupleUnpack(id first, id second) = value;
#pragma clang diagnostic pop
        return second;
    }] setNameWithFormat:@"[%@] -rac_location", self];
}

- (RACSignal *)rac_accelerationSignal
{
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if(signal) {
        return signal;
    }
    
    signal = [self.delegateObject rac_signalForSelector:@selector(motionDetector:accelerationChanged:) fromProtocol:@protocol(SOMotionDetectorDelegate)];
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[signal map:^id (id value) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        RACTupleUnpack(id first, id second) = value;
#pragma clang diagnostic pop
        return second;
    }] setNameWithFormat:@"[%@] -rac_acceleration", self];
}

@end
