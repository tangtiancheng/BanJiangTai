//
//  XPAPIManager+Analysis.h
//  Huaban
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (Analysis)

/**
 *  分析返回结果（很多返回的JSON结构都是统一的，可集中分析，如下所述：）
 
 {
 "statuscode": "200",
 "msg": "请求成功",
 "data": {
 "id": "100",
 "info": "呵呵"
 }
 }
 
 *
 *
 *  @param value 入参
 *
 *  @return 出参
 */
- (id)analysisRequest:(id)value;

@end
