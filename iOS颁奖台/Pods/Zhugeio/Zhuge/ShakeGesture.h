//
//  ShakeGesture.h
//  newdemo
//
//  Created by jiaokang on 15/10/10.
//  Copyright © 2015年 jiaokang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol connectPro;
@interface ShakeGesture : NSObject
@property(nonatomic,weak) id<connectPro> delegate;
@property (nonatomic, strong)CMMotionManager *motionManager;

-(void)startShakeGesture;
-(void)stopShakeListen;
@end
//声明协议中的接口函数
@protocol  connectPro <NSObject>

@required
- (void)onShakeGestureDo;
@end