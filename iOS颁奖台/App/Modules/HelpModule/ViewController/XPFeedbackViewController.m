//
//  XPFeedbackViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPFeedbackViewController.h"
#import "XPHelpViewModel.h"
#import <XPRACSignal/UITextView+XPLimitLength.h>
#import <XPTextView/XPTextView.h>

@interface XPFeedbackViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, weak) IBOutlet XPHelpViewModel *viewModel;
#pragma clang diagnostic pop

@property (nonatomic, weak) IBOutlet XPTextView *textView;
@property (nonatomic, weak) IBOutlet UIButton *submitButton;

@end

@implementation XPFeedbackViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    RAC(self.viewModel, content) = [self.textView rac_textSignal];
    self.submitButton.rac_command = self.viewModel.submitCommand;
    
    @weakify(self);
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self pop];
        [self showToast:@"提交成功"];
    }];
}

#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
