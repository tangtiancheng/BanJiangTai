//
//  XPChangePhoneViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/4/20.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPChangePhoneViewController.h"
#import <Masonry.h>
#import "UIImage+NJ.h"
#import "XPNewPhoneViewController.h"
@implementation XPChangePhoneViewController
-(void)dealloc{
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"个人信息";
    self.view.backgroundColor=RGBA(247, 247, 247, 1);
   
    [self createInterface];
    NSLog(@"%@",self.model.identifier);
}
-(void)createInterface{
    @weakify(self)
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 51)];
    [self.view addSubview:view];
    
    UILabel* label=[[UILabel alloc]init];
    label.text=@"手机号码";
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGBA(154, 154, 154, 1);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(16);
        make.top.equalTo(view);
        make.bottom.equalTo(view);
    }];
    
    UILabel* phoneNumberlabel=[[UILabel alloc]init];
    phoneNumberlabel.font=[UIFont systemFontOfSize:14];
    phoneNumberlabel.textColor=RGBA(154, 154, 154, 1);
    RAC(phoneNumberlabel,text)= RACObserve(self.model, identifier);
    [view addSubview:phoneNumberlabel];
    [phoneNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.bottom.equalTo(view);
        make.right.equalTo(view).with.offset(-16);
    }];
    UIView* horizontal=[[UIView alloc]init];
    horizontal.backgroundColor=RGBA(231, 231, 231, 1);
    [view addSubview:horizontal];
    [horizontal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.bottom.equalTo(view);
    }];
    
    UIButton* changeNumberBtn=[[UIButton alloc]init];
    changeNumberBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            XPNewPhoneViewController* newPhoneViewController=[[[XPNewPhoneViewController alloc]init]tap:^(XPBaseViewController *x) {
                @strongify(self)
                x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                    @strongify(self);
                    RAC(x,identifier)=[RACObserve([XPLoginModel singleton], userPhone) ignore:nil];
                }];
            }];
            [self pushViewController:newPhoneViewController];
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            @strongify(self);
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
    }];

    UIImage* image=[UIImage resizableImageNamed:@"common_short_red_button"];
    
    [changeNumberBtn setBackgroundImage:image forState:UIControlStateNormal];
    [changeNumberBtn setTitle:@"更改手机号" forState:UIControlStateNormal];
    [self.view addSubview:changeNumberBtn];
    [changeNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(view.mas_bottom).with.offset(30);
        make.height.mas_equalTo(41);
    }];
    
    UILabel* tipLabel=[[UILabel alloc]init];
    tipLabel.numberOfLines=0;
    tipLabel.font=[UIFont systemFontOfSize:10];
    tipLabel.textColor=RGBA(154, 154, 154, 1);
    tipLabel.textAlignment=NSTextAlignmentCenter;
    tipLabel.text=@"颁奖台APP登录名为手机号,如更换手机号,则登录名会变更.原账号数据保留";
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(changeNumberBtn.mas_bottom).with.offset(20);
//        make.height.mas_equalTo(40);
    }];
    
}
@end
