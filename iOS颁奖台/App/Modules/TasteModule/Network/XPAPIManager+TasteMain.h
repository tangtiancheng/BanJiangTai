//
//  XPAPIManager+TasteMain.h
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPAPIManager.h"

@interface XPAPIManager (TasteMain)

/**
 *  首页banner
 */
-(RACSignal *)tasteBanner;
/**
 *  商铺列表
 */
-(RACSignal *)tasteListWithLastCount:(NSInteger)lastCount pageSize:(NSInteger)pageSize longitude:(CGFloat)longitude latitude:(CGFloat)latitude storeName:(NSString*)storeName dishName:(NSString *)dishName avgPrice:(NSString*)avgPrice storeTag:(NSString *)storeTag storeType:(NSString *)storeType storeArea:(NSString *)storeArea;
/**
 *  筛选条件
 */
-(RACSignal *)tastefilterWithText:(NSString *)text;


/**
 *  商家店铺详情包括菜的种类
 */
-(RACSignal *)tastQryStoreAllInfoWithBusinessId:(NSString *)businessId business_store_id:(NSString *)businessStoreId;
@end






















