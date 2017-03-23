//
//  XPBaseModel.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <XPKit/XPKit.h>

@interface XPBaseModel : JSONModel <NSCoding, NSCopying>

/**
 *  标示符
 */
@property (nonatomic, strong) NSString<Optional> *identifier;

/**
 *  基本传输符
 */
@property (nonatomic, strong) id<Optional> baseTransfer;

@end

#pragma makr - Singleton
@interface XPBaseModel (Singleton)

/**
 *  单例
 *
 *  @return 实例
 */
+ (instancetype)singleton;

@end
