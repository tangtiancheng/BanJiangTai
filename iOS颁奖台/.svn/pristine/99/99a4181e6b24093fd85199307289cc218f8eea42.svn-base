//
//  XPSingleton.m
//  XPApp
//
//  Created by 唐天成 on 16/3/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPSingleton.h"
static XPSingleton* _singleton;
@implementation XPSingleton
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton=[super allocWithZone:zone];
    });
    return _singleton;
}
+(instancetype)shareSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_singleton==nil)
            _singleton=[[XPSingleton alloc]init];
    });
    return _singleton;
}
-(id)copyWithZone:(NSZone*)zone{
    return _singleton;
}
-(void)dealloc{
    NSLog(@"xiaohuile");
}
//+ (void)initialize
//{
//    if (self == [XPSingleton class]) {
//        XPSingleton* singleton=[self shareSingleton];
//        singleton.continuousDays=[[NSUserDefaults standardUserDefaults]stringForKey:@"continuousDays"];
//        singleton.continuousDays=[[NSUserDefaults standardUserDefaults]stringForKey:@"continuousTotalDays"];
//        
//    }
//}
@end
