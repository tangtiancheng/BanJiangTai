//
//  XPTasteStoreViewModel.m
//  XPApp
//
//  Created by 唐天成 on 16/7/6.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPTasteStoreViewModel.h"
#import "XPAPIManager+TasteMain.h"
//#import "TastStoreModel.h"

@interface XPTasteStoreViewModel()

@property (nonatomic, strong, readwrite)XPTastStoreModel* tastStoreModel;


@property (nonatomic, strong, readwrite) RACCommand *tastStoreCommand;
@end


@implementation XPTasteStoreViewModel
- (RACCommand *)tastStoreCommand
{
    if(_tastStoreCommand == nil) {
        @weakify(self);
        _tastStoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager tastQryStoreAllInfoWithBusinessId:self.businessId business_store_id:self.business_store_id];
        }];
        [[[_tastStoreCommand executionSignals] concat] subscribeNext:^(XPTastStoreModel *x) {
            @strongify(self);
            self.tastStoreModel = x;
        }];
        XPViewModelShortHand(_tastStoreCommand);
    }
    
    return _tastStoreCommand;
}
@end
