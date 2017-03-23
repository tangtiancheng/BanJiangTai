//
//  XPGiftGroupCreateViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import "XPGiftGroupCreateViewController.h"
#import "XPGiftViewModel.h"
#import <XPKit/XPKit.h>
#import <XPRACSignal/UITextField+XPLimitLength.h>

@interface XPGiftGroupCreateViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) XPGiftViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, strong) IBOutlet UITextField *groupNameTextField;

@end

@implementation XPGiftGroupCreateViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    RAC(self.viewModel, groupName) = [self.groupNameTextField rac_textSignalWithLimitLength:10];
    
    @weakify(self);
    [self.groupNameTextField xp_limitTextLength:10 block:^(NSString *text) {
        @strongify(self);
        self.viewModel.groupName = text;
    }];
    
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.groupCreateCommand;
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    [[RACObserve(self.viewModel, groupCreateFinished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self pop];
        [self.viewModel.createCommand execute:nil];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface
- (void)bindViewModel:(XPGiftViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPGiftViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Getter & Setter

@end
