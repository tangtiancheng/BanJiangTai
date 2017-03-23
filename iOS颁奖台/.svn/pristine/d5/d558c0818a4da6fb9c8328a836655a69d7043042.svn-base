//
//  ShakeGesture.m
//  newdemo
//
//  Created by jiaokang on 15/10/10.
//  Copyright © 2015年 jiaokang. All rights reserved.
//

#import "ShakeGesture.h"
#import "ZGLog.h"
static const int START_LEN = 10;
static const int STATE0 = 0;
static const int STATE1 = 1;
static const int STATE2 = 2;

static int count = 0;
static int trigger = 0;

static float old_x = 0;
static float old_y = 0;
static float old_z = 0;

static float x[10];
static float y[10];
static float z[10];

int state = 0;

float var_x = 0;
float var_y = 0;
float var_z = 0;
@implementation ShakeGesture
@synthesize delegate=_delegate;

- (void)calculatevar {
    float mean_x = 0;
    float mean_y = 0;
    float mean_z = 0;
    
    for (int i = 0; i < START_LEN; i ++) {
        mean_x += x[i];
        mean_y += y[i];
        mean_z += z[i];
    }
    mean_x = mean_x / START_LEN;
    mean_y = mean_y / START_LEN;
    mean_z = mean_z / START_LEN;
    
    for (int i = 0; i < START_LEN; i ++) {
        var_x += (x[i] - mean_x) * (x[i] - mean_x);
        var_y += (y[i] - mean_y) * (y[i] - mean_y);
        var_z += (z[i] - mean_z) * (z[i] - mean_z);
    }
    var_x = (float)sqrt(var_x);
    var_y = (float)sqrt(var_y);
    var_z = (float)sqrt(var_z);
}
- (void)startShakeGesture
{
    if (!self.motionManager) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    self.motionManager.accelerometerUpdateInterval = 0.1;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        
        float new_x = x[count] = accelerometerData.acceleration.x * 9.8;
        float new_y = y[count] = accelerometerData.acceleration.y * 9.8;
        float new_z = z[count] = accelerometerData.acceleration.z * 9.8;
        
        float speed = fabs(new_x + new_y + new_z - old_x - old_y - old_z) /100 * 10000;
        old_x = new_x;
        old_y = new_y;
        old_z = new_z;
        count ++;
        if (count >= START_LEN) {
            count = 0;
        }
        [self calculatevar];
        switch (state) {
            case STATE0:
                if (var_x > 2.5 && var_y > 5 && var_z > 15) {
                    state = STATE1;
                }
                break;
            case STATE1:
                state = STATE2;
                break;
            case STATE2:
                if (var_z > 18 && speed < 4000) {
                    trigger ++;
                } else {
                    trigger = 0;
                }
                if (trigger >= 14) {
                    ZhugeDebug(@"I get the event\n");
                    if (self.delegate) {
                        [self.delegate onShakeGestureDo];
                    }
                    trigger = 0;
                    state = STATE0;
                }
            default:
                break;
        }
        
    }];    
}
-(void)stopShakeListen{
    ZhugeDebug(@"停止监听");
    if (self.motionManager) {
        [self.motionManager stopAccelerometerUpdates];
    }
}
@end
