//
//  XPInviteViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "NSObject+XPShareSDK.h"
#import "NSString+XPPrivacyPhone.h"
#import "XPInviteViewController.h"
#import "XPInviteViewModel.h"
#import "XPLoginModel.h"
#import <XPKit/XPKit.h>
#import <XPQRCode/NSString+QREncode.h>

@interface XPInviteViewController ()<UITextViewDelegate, UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPInviteViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *inviteCopyButton;
@property (nonatomic, weak) IBOutlet UIImageView *barImageView;

@end

@implementation XPInviteViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    RAC(self.barImageView, image) = [[RACObserve(self.viewModel, model.inviteUrl) ignore:nil] map:^id (NSString *value) {
        return [value qr_encode];
    }];
    
    @weakify(self);
    [[self.inviteCopyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self inviteTaped];
    }];
    
    [self.viewModel.inviteCommand execute:nil];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!self.viewModel.model) {
        return;
    }
    
    [[self shareWithTitle:self.viewModel.model.inviteTitle content:self.viewModel.model.inviteContent images:@[self.viewModel.model.inviteImgUrl] url:[self.viewModel.model.inviteUrl stringByAppendingFormat:@"?fromUserPhone=%@&id=%@",  [[XPLoginModel singleton].userPhone privacyPhone], self.viewModel.model.inviteId] platformType:SSDKPlatformSubTypeWechatSession] subscribeNext:^(id x) {
    }];
}

#pragma mark - Event Responds
- (void)inviteTaped
{
    if(!self.viewModel.model) {
        return;
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@,%@,%@", self.viewModel.model.inviteTitle, self.viewModel.model.inviteContent, [self.viewModel.model.inviteUrl stringByAppendingFormat:@"?fromUserPhone=%@&id=%@",  [[XPLoginModel singleton].userPhone privacyPhone], self.viewModel.model.inviteId]];
    [self showToast:@"邀请链接已复制成功可在论坛、Q群中粘帖使用"];
}

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
