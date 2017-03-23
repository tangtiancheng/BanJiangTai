//
//  XPAddressViewModel.h
//  XPApp
//
//  Created by xinpinghuang on 1/8/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPAddressBackModel.h"
#import "XPBaseViewModel.h"

@class XPRegionEntity;
@interface XPAddressViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;

#pragma mark - 新增
@property (nonatomic, strong) NSString *recipient;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) XPRegionEntity *region_0;
@property (nonatomic, strong) XPRegionEntity *region_1;
@property (nonatomic, strong) XPRegionEntity *region_2;
@property (nonatomic, strong) XPRegionEntity *region_3;

@property (nonatomic, strong) NSString *addressDetail;
@property (nonatomic, assign) BOOL defaultAddress;
@property (nonatomic, strong, readonly) RACCommand *createCommand;

#pragma mark - 更新&删除
@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong, readonly) RACCommand *updateCommand;
@property (nonatomic, strong, readonly) RACCommand *deleteCommand;

#pragma mark - 地址列表
@property (nonatomic, strong, readonly) NSArray *list;
@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

@end
