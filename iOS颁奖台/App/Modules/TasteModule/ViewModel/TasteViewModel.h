//
//  TasteViewModel.h
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPBaseViewModel.h"

@interface TasteViewModel : XPBaseViewModel

@property (nonatomic, assign, readonly) BOOL finished;

#pragma mark - 列表
@property (nonatomic, strong, readonly) NSArray *banners;
@property (nonatomic, strong, readonly) NSArray *list;

@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *dishName;
@property (nonatomic, strong) NSString *avgPrice;
@property (nonatomic, strong) NSString *storeTag;
@property (nonatomic, strong) NSString *storeType;
@property (nonatomic, strong) NSString *storeArea;


@property (nonatomic, strong, readonly) RACCommand *reloadCommand;
@property (nonatomic, strong, readonly) RACCommand *moreCommand;

@end
