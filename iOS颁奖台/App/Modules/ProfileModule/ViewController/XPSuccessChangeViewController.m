//
//  XPSuccessChangeViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/4/22.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPSuccessChangeViewController.h"
#import "UIImage+NJ.h"
#import "XPBaseTabBarViewController.h"
#import "XPBaseNavigationViewController.h"
#import <JZNavigationExtension/JZNavigationExtension.h>
#import "XPProfileViewModel.h"

@interface XPSuccessChangeViewController()

@property (strong, nonatomic) XPProfileViewModel *profileViewModel;
@property (nonatomic, strong)UIButton* OKBtn;

@end

@implementation XPSuccessChangeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    @weakify(self)
    self.title=@"个人信息";
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor=RGBA(247, 247, 247, 1);
    
    [self createInterface];
    self.OKBtn.rac_command=self.profileViewModel.logoutCommand ;
    [[RACObserve(self.profileViewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self popAndPresentLogin];
    }];
}

-(void)createInterface{
    @weakify(self)
    UIView* successView=[[UIView alloc]init];
    [self.view addSubview:successView];
    //变更成功label
    UILabel* successLabel=[[UILabel alloc]init];
    successLabel.text=@"变更成功";
    successLabel.font=[UIFont systemFontOfSize:24];
    [successView addSubview:successLabel];
    //勾
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"successChange"]];
    
    [successView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(successView);
        make.top.equalTo(successView);
        make.bottom.equalTo(successView);
    }];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).with.offset(15);
        make.top.equalTo(successView);
        make.bottom.equalTo(successView);
        make.right.equalTo(successView);
    }];
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(108);
    }];
    
    UILabel* tipLabel=[[UILabel alloc]init];
    tipLabel.text=[NSString stringWithFormat: @"新手机号码变更成功,下次登录颁奖台APP时请使用%@作为用户名登录.",self.phoneNumNew];
    tipLabel.numberOfLines=0;
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(28);
        make.right.equalTo(self.view).with.offset(-28);
        make.top.equalTo(successView.mas_bottom).with.offset(30);
    }];
    //确定按钮
    UIButton* OKBtn=[[UIButton alloc]init];
    self.OKBtn=OKBtn;
    UIImage* image=[UIImage resizableImageNamed:@"common_short_red_button"];
    
    [OKBtn setBackgroundImage:image forState:UIControlStateNormal];
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    
//    [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
//            @strongify(self);
//            [self.navigationController popToRootViewControllerAnimated:YES completion:^(BOOL finished) {
//                XPBaseTabBarViewController *tabBarViewController = (XPBaseTabBarViewController *)[UIApplication sharedApplication].windows[0].rootViewController;
//                [tabBarViewController setSelectedIndex:0];
//                XPBaseNavigationViewController *navigationViewController = [tabBarViewController viewControllers][0];
//                [(XPBaseViewController *)navigationViewController.topViewController presentLogin];
//            }];
//            [subscriber sendNext:@YES];
//            [subscriber sendCompleted];
//            return nil;
//        }] ;
//    }];

    
    
    [self.view addSubview:OKBtn];
    [OKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(tipLabel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];

}
#pragma mark - Private Methods
- (void)popAndPresentLogin
{
    [self.navigationController popToRootViewControllerAnimated:YES completion:^(BOOL finished) {
        XPBaseTabBarViewController *tabBarViewController = (XPBaseTabBarViewController *)[UIApplication sharedApplication].windows[0].rootViewController;
        [tabBarViewController setSelectedIndex:0];
        XPBaseNavigationViewController *navigationViewController = [tabBarViewController viewControllers][0];
        [(XPBaseViewController *)navigationViewController.topViewController presentLogin];
    }];
}
-(XPProfileViewModel*)profileViewModel{
    if(!_profileViewModel){
        _profileViewModel=[[XPProfileViewModel alloc]init];
    }
    return _profileViewModel;
}

@end
