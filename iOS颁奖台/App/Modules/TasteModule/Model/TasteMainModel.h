//
//  TasteMainModel.h
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseModel.h"
@protocol TasteMainModel<NSObject>

@end

@interface TasteMainModel : XPBaseModel

@property NSString *storeId;
@property NSString *storeName;
@property NSString *storeDistrict;
@property NSString *storeAddress;
@property NSString *avgPrice;
@property NSString *storeLogo;
@property NSString *businessId;
@property NSString *bussinessFlg;
@property NSArray *storeTags;
@property NSString *storeTag;

@end

@interface TasteBannerModel : XPBaseModel

@property NSString *storeId;
@property NSString *businessId;
@property NSString *imageUrl;
@property NSString *contentUrl;

@end

@interface TasteFilterModel : XPBaseModel

@property NSString *name;
@property NSString *count;

@end


