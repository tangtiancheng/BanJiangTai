//
//  TasteFindViewModel.m
//  XPApp
//
//  Created by Pua on 16/5/26.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteFindViewModel.h"
#import "XPAPIManager+TasteMain.h"
#import "TasteMainModel.h"
#import "NSDictionary+XPUserInfo.h"

@interface TasteFindViewModel()
@property (nonatomic, strong, readwrite) NSArray *list;
@property (nonatomic, assign, readwrite) BOOL finished;

@property (nonatomic , strong, readwrite) RACCommand *filterCommand;


@end

@implementation TasteFindViewModel

- (instancetype)init
{
    if((self = [super init])) {
    }
    
    return self;
}
-(RACCommand *)filterCommand
{
    if(_filterCommand == nil) {
        @weakify(self);
        _filterCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager tastefilterWithText:self.searchText];
        }];
        [[[_filterCommand executionSignals] concat] subscribeNext:^(NSArray *x) {
            @strongify(self);
            self.list = x;
            self.finished = YES;
        }];
        XPViewModelShortHand(_filterCommand);
    }
    
    return _filterCommand;
}

@end
