//
//  TasteSingleManager.h
//  XPApp
//
//  Created by Pua on 16/5/26.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TasteSingleManager : NSObject
//缓存搜索的数组
+(void)SearchText :(NSString *)seaTxt;
//清除缓存数组
+(void)removeAllArray;
@end
