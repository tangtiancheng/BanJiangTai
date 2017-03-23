//
//  TastStoreModel.h
//  XPApp
//
//  Created by 唐天成 on 16/7/6.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"

@protocol XPTasteMainModel<NSObject>

@end
@protocol XPDashInfoModel<NSObject>

@end

@protocol XPMeunModel<NSObject>

@end
@protocol NSString<NSObject>

@end
@protocol XPDashInfoModel<NSObject>

@end



//房间个数模型
@interface XPPrivateRoomModel : XPBaseModel

//bigHall个数
@property NSString *bigHall;
//bigRoom个数
@property NSString *bigRoom;
//midRoom个数
@property NSString *midRoom;
//smallRoom个数
@property NSString *smallRoom;

@end


//菜模型
@interface XPDashInfoModel : XPBaseModel

@property NSString *dashClassId;
@property NSString *cutPrize;
@property NSString *sort;
@property NSString *dashDescribe;
@property NSString *oldPrize;
@property NSString *dashImg;
@property NSString *dashId;
@property NSString *foodFlg;
@property NSString *foodStart;
@property NSString *foodEnd;
@property NSString *dashName;

//以下两个是自己添加的
//荤菜素菜汤
@property NSInteger typeDish;
//点了几份
@property NSInteger orderCount;

@end


//菜单模型
@interface XPMeunModel : XPBaseModel

//菜数组
@property NSArray<XPDashInfoModel> *dashInfo;
//dashClassId
@property NSString *dashClassId;
//菜品类型名
@property NSString *dashClassName;
//dashClassSort
@property NSString *dashClassSort;

@end


//商家模型
@interface XPTastStoreModel : XPBaseModel

//商家名字
@property NSString *businessName;
//平均价格
@property NSString *averagePrice;
//私有房间
@property XPPrivateRoomModel *privateRooms;
//电话
@property NSString *businessTel;
//地址
@property NSString *businessAdd;
//营业时间
@property NSString *businessTime;
//商家ID
@property NSString *businessId;
//商家网址
@property NSString *storeUrl;
//菜的种类列表
@property NSArray<XPMeunModel>* meunList;
//wifi,热水,停车场
@property NSArray<NSString>* businessTag;

@end



//自我添加的点菜模型
@interface XPTastOrderingModel : XPBaseModel

@property NSInteger count;
@property XPDashInfoModel* dashInfoModel;

@end


