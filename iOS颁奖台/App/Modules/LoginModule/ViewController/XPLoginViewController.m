//
//  XPLoginViewController.m
//  XPApp
//
//  Created by huangxinping on 15/9/23.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPAutoNIBColor.h"
#import "XPLoginStorage.h"
#import "XPLoginViewController.h"
#import "XPLoginViewModel.h"
#import "XPSettingViewModel.h"
#import <XPCountDownButton/XPCountDownButton.h>
#import <XPKit/XPKit.h>
#import <XPRACSignal/UITextField+XPLimitLength.h>
#import <JPush/JPUSHService.h>

@interface XPLoginViewController ()

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPLoginViewModel *viewModel;
#pragma clang diagnostic pop
@property (strong, nonatomic) IBOutlet XPSettingViewModel *settingViewModel;

@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *captchaTextField;
@property (nonatomic, weak) IBOutlet XPCountDownButton *captchaButton;
@property (nonatomic, weak) IBOutlet UIButton *checkBoxButton;
@property (nonatomic, weak) IBOutlet UIButton *signInButton;
@property (nonatomic, weak) IBOutlet UIButton *agreementButton;

@end

@implementation XPLoginViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.captchaButton addToucheHandler:^(XPCountDownButton *sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startWithSecond:60];
        [sender didChange:^NSString *(XPCountDownButton *countDownButton, int second) {
            sender.enabled = NO;
            NSString *title = [NSString stringWithFormat:@"剩余%d秒", second];
            return title;
        }];
        [sender didFinished:^NSString *(XPCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"获取验证码";
        }];
    }];
    
    @weakify(self);
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            [subscriber sendNext:@(1)];
            [subscriber sendCompleted];
            [self dismissViewControllerAnimated:YES completion:nil];
            return nil;
        }];
    }];
    self.captchaButton.rac_command = self.viewModel.captchaCommand;
    RAC(self.viewModel, phone) = [self.phoneTextField rac_textSignalWithLimitLength:11];
    RAC(self.viewModel, captcha) = [self.captchaTextField rac_textSignalWithLimitLength:6];
    RAC(self.viewModel, agreement) = RACObserve(self.checkBoxButton, selected);
    
    RAC(self.checkBoxButton, selected) = [[self.checkBoxButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id (id value) {
        return @(!self.checkBoxButton.selected);
    }];
    self.signInButton.rac_command = self.viewModel.signInCommand;
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.settingViewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.settingViewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    [[RACObserve(self.viewModel, model) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self showToast:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[self.agreementButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if(!self.settingViewModel.agreenmentURL) {
            [self.settingViewModel.agreementCommand execute:nil];
        } else {
            [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
                x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                    @strongify(self);
                    x.identifier = self.settingViewModel.agreenmentURL;
                    x.baseTransfer = @"会员协议";
                }];
            }]];
        }
    }];
    [self.settingViewModel.agreementCommand execute:nil];
}
-(void)JPUSHCallBack{
    NSLog(@"JPUSHCallBack");
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
