//
//  XPNewPhoneViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/4/20.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPNewPhoneViewController.h"
#import "UIImage+NJ.h"
#import <XPKit/XPKit.h>
#import <XPRACSignal/UITextField+XPLimitLength.h>
#import "NSString+XPValid.h"
#import "XPSuccessChangeViewController.h"
#import <XPCountDownButton/XPCountDownButton.h>
#import "XPLoginViewModel.h"
#import "XPSettingViewModel.h"

@interface XPNewPhoneViewController()
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong)XPLoginViewModel *loginViewModel;

//新手机号
//@property (nonatomic, strong)NSString* phoneNum;
@property (nonatomic, strong)UITextField* phoneTextField;

//校验码
//@property (nonatomic, strong)NSString* codeNum;
@property (nonatomic, strong)UITextField* captchaTextField;


//发送验证码按钮
@property (nonatomic, strong)XPCountDownButton* sendCodeBtn;
//下一步按钮
@property (nonatomic, strong)UIButton* nextBtn;

@end

@implementation XPNewPhoneViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"个人信息";
    self.view.backgroundColor=RGBA(247, 247, 247, 1);
    //搭界面
    [self createInterface];
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.loginViewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.loginViewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];

    NSLog(@"%@",self.model.identifier);
    
    RAC(self.loginViewModel, phone) = [self.phoneTextField rac_textSignalWithLimitLength:11];
    RAC(self.loginViewModel, captcha) = [self.captchaTextField rac_textSignalWithLimitLength:6];
    [RACObserve(self,loginViewModel.changePhoneSuccess)subscribeNext:^(NSString* x) {
        if(x.boolValue==1){
            XPSuccessChangeViewController* successChangeVC=[[XPSuccessChangeViewController alloc]init];
        successChangeVC.phoneNumNew=self.loginViewModel.phone;
            [self pushViewController:successChangeVC];
        }
    }];
    self.sendCodeBtn.rac_command = self.loginViewModel.captchaCommand;
    self.nextBtn.rac_command=self.loginViewModel.changePhoneNumCommand;
}
-(void)createInterface{
    @weakify(self)
    //新手机号
    UIView* BackGroundviewPhone=[[UIView alloc]initWithFrame:CGRectMake(15, 88, self.view.width-15*2, 41)];
//    UIImage* image=[UIImage resizableImageNamed:@"setting_logout_button"];
//    [BackGroundview setBackgroundImage:image forState:UIControlStateNormal];
    BackGroundviewPhone.layer.borderWidth=1;
    BackGroundviewPhone.layer.borderColor=RGBA(199, 199, 199, 1).CGColor;
    BackGroundviewPhone.layer.masksToBounds=YES;
    BackGroundviewPhone.layer.cornerRadius=4;
//    BackGroundview.enabled=NO;
    [self.view addSubview:BackGroundviewPhone];
    
    UILabel* labelPhone=[[UILabel alloc]init];
    labelPhone.text=@"新手机号";
    labelPhone.font=[UIFont systemFontOfSize:14];
    labelPhone.textColor=RGBA(154, 154, 154, 1);
    [BackGroundviewPhone addSubview:labelPhone];
    [labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BackGroundviewPhone).with.offset(15);
        make.top.equalTo(BackGroundviewPhone);
        make.bottom.equalTo(BackGroundviewPhone);
    }];
    
    UITextField* textFieldPhone=[[UITextField alloc]init];
    self.phoneTextField=textFieldPhone;
    [BackGroundviewPhone addSubview:textFieldPhone];
//    textFieldPhone.backgroundColor=[UIColor redColor];
    textFieldPhone.keyboardType=UIKeyboardTypeNumberPad;
    textFieldPhone.font=[UIFont systemFontOfSize:15];
//    RAC(self,phoneNum)=[textFieldPhone rac_textSignalWithLimitLength:11];
    [textFieldPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelPhone.mas_right).with.offset(5);
        make.centerY.equalTo(BackGroundviewPhone);
//        make.height.equalTo(@20);
         make.top.equalTo(BackGroundviewPhone);
        make.bottom.equalTo(BackGroundviewPhone);
        make.width.mas_equalTo(200);
   
    }];
    //清空叉号
    UIButton* clearPhoneBtn=[[UIButton alloc]init];
    [clearPhoneBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [BackGroundviewPhone addSubview:clearPhoneBtn];
    [clearPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BackGroundviewPhone).with.offset(-20);
        make.centerY.equalTo(BackGroundviewPhone.mas_centerY);
    }];
    clearPhoneBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            textFieldPhone.text=nil;
            self.loginViewModel.phone=nil;
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] ;
    }];
    
    //验证码
    UIView* BackGroundviewCode=[[UIView alloc]init];
    //    UIImage* image=[UIImage resizableImageNamed:@"setting_logout_button"];
    //    [BackGroundview setBackgroundImage:image forState:UIControlStateNormal];
    BackGroundviewCode.layer.borderWidth=1;
    BackGroundviewCode.layer.borderColor=RGBA(199, 199, 199, 1).CGColor;
    BackGroundviewCode.layer.masksToBounds=YES;
    BackGroundviewCode.layer.cornerRadius=4;
    //    BackGroundview.enabled=NO;
    [self.view addSubview:BackGroundviewCode];
    [BackGroundviewCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-15);
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(BackGroundviewPhone.mas_bottom).with.offset(17);
        make.height.equalTo(@41);
    }];
    
    UILabel* labelCode=[[UILabel alloc]init];
    labelCode.text=@"校验码:";
    labelCode.font=[UIFont systemFontOfSize:14];
    labelCode.textColor=RGBA(154, 154, 154, 1);
    [BackGroundviewCode addSubview:labelCode];
    [labelCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BackGroundviewCode).with.offset(15);
        make.top.equalTo(BackGroundviewCode);
        make.bottom.equalTo(BackGroundviewCode);
    }];
    
    UITextField* textFieldCode=[[UITextField alloc]init];
    self.captchaTextField=textFieldCode;
    [BackGroundviewCode addSubview:textFieldCode];
//    textFieldCode.backgroundColor=[UIColor redColor];
    textFieldCode.keyboardType=UIKeyboardTypeNumberPad;
    textFieldCode.font=[UIFont systemFontOfSize:15];
//    RAC(self,codeNum)=[textFieldCode rac_textSignalWithLimitLength:6];
    [textFieldCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelCode.mas_right).with.offset(5);
        make.centerY.equalTo(BackGroundviewCode);
//        make.height.equalTo(@20);
        make.top.equalTo(BackGroundviewCode);
        make.bottom.equalTo(BackGroundviewCode);

        make.width.mas_equalTo(200);
        
    }];
    //清空叉号
    UIButton* clearCodeBtn=[[UIButton alloc]init];
    [clearCodeBtn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [BackGroundviewCode addSubview:clearCodeBtn];
    [clearCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BackGroundviewCode).with.offset(-20);
        make.centerY.equalTo(BackGroundviewCode.mas_centerY);
    }];
    clearCodeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            textFieldCode.text=nil;
            self.loginViewModel.captcha=nil;
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] ;
    }];
    //发送验证码
    self.sendCodeBtn=[[XPCountDownButton alloc]init];
    [self.sendCodeBtn setTitleColor:[UIColor blackColor]];
    [self.sendCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.sendCodeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [BackGroundviewCode addSubview:self.sendCodeBtn];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(clearCodeBtn.mas_left).with.offset(-10);
        make.centerY.equalTo(BackGroundviewCode.mas_centerY);
    }];
    [self.sendCodeBtn addToucheHandler:^(XPCountDownButton *sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startWithSecond:60];
        [sender didChange:^NSString *(XPCountDownButton *countDownButton, int second) {
            sender.enabled=NO;
            NSString *title = [NSString stringWithFormat:@"剩余%d秒", second];
            return title;
        }];
        [sender didFinished:^NSString *(XPCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"获取验证码";
        }];
    }];
    
       //下一步按钮
     UIButton* nextBtn=[[UIButton alloc]init];
    self.nextBtn=nextBtn;
    UIImage* image=[UIImage resizableImageNamed:@"common_short_red_button"];
    UIImage* imageDisable=[UIImage resizableImageNamed:@"nextDisable"];
    
    [nextBtn setBackgroundImage:image forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:imageDisable forState:UIControlStateDisabled];

    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    nextBtn.rac_command=self.loginViewModel.changePhoneNumCommand;
    //下一步按钮点击
//    nextBtn.rac_command=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
//            @strongify(self);
//            if(!self.phoneNum.isPhone){
//                [UIAlertView alertViewWithTitle:nil message:@"请输入正确的手机号!" block:^(NSInteger buttonIndex) {
//                }buttonTitle:@"确定"];
//            }else if(self.codeNum.length!=6){
//                [UIAlertView alertViewWithTitle:nil message:@"请输入正确的验证码!" block:^(NSInteger buttonIndex) {
//                }buttonTitle:@"确定"];
//            }else{
//                //马栎发请求该干嘛干嘛(判断成功或者失败,失败的几种类型)
//                XPSuccessChangeViewController* successChangeVC=[[XPSuccessChangeViewController alloc]init];
//                [self pushViewController:successChangeVC];
//            }
//            [subscriber sendNext:@YES];
//            [subscriber sendCompleted];
//            return nil;
//        }] ;
//    }];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(BackGroundviewCode.mas_bottom).with.offset(20);
        make.height.mas_equalTo(40);
    }];
    UILabel* tipLabel=[[UILabel alloc]init];
    tipLabel.numberOfLines=0;
    tipLabel.font=[UIFont systemFontOfSize:10];
    tipLabel.textColor=RGBA(154, 154, 154, 1);
    tipLabel.textAlignment=NSTextAlignmentCenter;
    tipLabel.text=@"颁奖台APP登录名为手机号,如更换手机号,则登录名会变更.原账号数据保留";
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(nextBtn.mas_bottom).with.offset(20);
        //        make.height.mas_equalTo(40);
    }];
    
}
#pragma mark 懒加载
-(XPLoginViewModel*)loginViewModel{
    if(!_loginViewModel){
        _loginViewModel=[[XPLoginViewModel alloc]init];
    }
    return _loginViewModel;
}

@end
