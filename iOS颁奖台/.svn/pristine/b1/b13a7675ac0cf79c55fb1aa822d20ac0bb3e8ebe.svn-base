//
//  XPMainPlainShakeViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/25/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPMainPlainShakeViewController.h"
#import "XPMainPlainShakeViewModel.h"
#import "XPMainPlainViewModel.h"
#import "XPMotionManager.h"
#import "XPPlainNotScoreExchangeView.h"
#import "XPPlainScoreExchangeView.h"
#import "XPPlainTheShakeNumberOverView.h"
#import "XPPlainTheGoldNumberOverView.h"
#import "XPPlainWinningView.h"
#import <XPKit/XPKit.h>
#import <XPShouldPop/UINavigationController+XPShouldPop.h>

@interface XPMainPlainShakeViewController ()<UINavigationControllerShouldPop>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMainPlainShakeViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UILabel *activeCanJoinNumLabel;

@property (nonatomic, weak) IBOutlet UILabel *remainPointCanJoinNumLabel;
//如何获得奖金币按钮
@property (weak, nonatomic) IBOutlet UIButton *howToGetGoldButton;

@property (nonatomic, assign) BOOL closeShake;

@property (nonatomic, assign) BOOL isAutomaticShake; // 如果shareNumber>0则是自动进入的摇奖界面，不需要用户点击Go按钮。所以导航栏点击返回时应该跳转到颁奖台首页！！！

@end

@implementation XPMainPlainShakeViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.howToGetGoldButton.layer.masksToBounds=YES;
    self.howToGetGoldButton.layer.cornerRadius=self.howToGetGoldButton.height/2;
    self.howToGetGoldButton.hidden=YES;
    self.howToGetGoldButton.layer.borderWidth=2;
    self.howToGetGoldButton.layer.borderColor=RGBA(71, 65, 82, 1).CGColor;
    //    self.title = self.model.identifier;
    UILabel *titleView = [[UILabel alloc] initWithFrame:ccr(40, 28, self.view.width-80, 22)];
    
    titleView.text = self.model.identifier;
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:17];
    titleView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleView];
    
    self.viewModel.podiumId = [(NSArray *)self.model.baseTransfer objectAtIndex:0];
    self.isAutomaticShake = [[(NSArray *)self.model.baseTransfer objectAtIndex:1] boolValue];
    //天成添加
    self.viewModel.joinNumber=[[(NSArray*)self.model.baseTransfer objectAtIndex:2]integerValue];
    
    
    self.closeShake = NO;
    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    [self.viewModel.shakeNumberCommand execute:nil];
    
    //如何获得奖金币url跳转
    @weakify(self);
    self.howToGetGoldButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.closeShake = YES;
        
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
//                x.identifier = self.viewModel.ruleURL;
                
                x.identifier=self.viewModel.shakeNumerModel.pointsRule;
                NSLog(@"%@",self.viewModel.shakeNumerModel.pointsRule);
                x.baseTransfer = @"奖金币规则";
            }];
        }]];
        
        return [RACSignal empty];
    }];

    RAC(self.activeCanJoinNumLabel, text) = [[[RACObserve(self, viewModel.shakeNumerModel.activeJoinNum) ignore:nil] map:^id (id value) {
        @strongify(self)
        //摇奖无限次时
        if([value integerValue]==-1){
            if(self.viewModel.shakeNumerModel.exchangePoint == 0){
                return [NSString stringWithFormat:@"请尽情嗨摇"];
            }else{
                self.activeCanJoinNumLabel.hidden=YES;
            }
            
        }
        
        return [NSString stringWithFormat:@"本活动每日限摇%@次", value];
    }] startWith:@"0"];
    RAC(self.remainPointCanJoinNumLabel, attributedText) = [[[RACObserve(self, viewModel.shakeNumerModel.remainPoint) ignore:nil] map:^id (NSString* remainPoint) {
         @strongify(self)
        //如果参与活动所需金币数为0
        if(self.viewModel.shakeNumerModel.exchangePoint == 0){
            self.howToGetGoldButton.hidden=YES;
            self.remainPointCanJoinNumLabel.hidden=YES;
//            //如果该活动可以参与的活动次数为无限次
//            if(self.viewModel.shakeNumerModel.activeJoinNum == -1){
//                
//            }else{//如果该活动可以参与的活动次数为有限次
//                
//            }
            return nil;
            
        }else{
            //如果参与活动所需金币数不为0
        //如果奖金币数大于参与活动所需的奖金币数
        if([remainPoint integerValue] >= self.viewModel.shakeNumerModel.exchangePoint){
            self.howToGetGoldButton.hidden=YES;
//            return [NSString stringWithFormat:@"你有奖金币%@个 可摇奖 %ld 次",remainPoint,[remainPoint integerValue]/self.viewModel.shakeNumerModel.exchangePoint];
            
            NSMutableAttributedString* strM=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"你有奖金币%@个 可摇奖",remainPoint]];

           
            NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %ld ",[remainPoint integerValue]/self.viewModel.shakeNumerModel.exchangePoint] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"MarkerFelt-Thin" size:30]}];
            
            NSAttributedString* attribuuteString2=[[NSAttributedString alloc]initWithString:@"次" ];
            [strM appendAttributedString:attribuuteString];
            [strM appendAttributedString:attribuuteString2];
        
            return strM;
            
        }else if([remainPoint integerValue] < self.viewModel.shakeNumerModel.exchangePoint && [remainPoint integerValue]!=0){
            self.howToGetGoldButton.hidden=NO;
//            return [NSString stringWithFormat:@"你有奖金币%@个  还差%ld个即可摇奖", remainPoint,self.viewModel.shakeNumerModel.exchangePoint-[remainPoint integerValue]];
            
            NSMutableAttributedString* strM=[[NSMutableAttributedString alloc]initWithString:@"你有奖金币" ];
            
            
            NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",remainPoint] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"MarkerFelt-Thin" size:30]}];
            NSAttributedString* attribuuteString1=[[NSAttributedString alloc]initWithString:@"枚  "];
            
            NSAttributedString* attribuuteString2=[[NSAttributedString alloc]initWithString:@"还差" ];
            
            NSAttributedString* attribuuteStrin3=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",self.viewModel.shakeNumerModel.exchangePoint-[remainPoint integerValue]] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"MarkerFelt-Thin" size:30]}];
            
            NSAttributedString* attribuuteString4=[[NSAttributedString alloc]initWithString:@"个既可摇奖"];
            
            [strM appendAttributedString:attribuuteString];
            [strM appendAttributedString:attribuuteString1];
            [strM appendAttributedString:attribuuteString2];
            [strM appendAttributedString:attribuuteStrin3];
            [strM appendAttributedString:attribuuteString4];
            return strM;
            
        }else{
            self.howToGetGoldButton.hidden=NO;
             NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:@"你没有奖金币,不能进行摇奖" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
           
            return attribuuteString;
//            return @"你没有奖金币,不能进行抽奖";
            
            
        }
        }
        
    }] startWith:[[NSAttributedString alloc]initWithString:@"0"]];
    
    //摇一摇触发
    [[[self.viewModel.shakeCommand executionSignals] concat] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"摇一摇那要以摇摇椅啊要意思奥雅iyaio");
        [self showShakeResultTip];
    }];
    
    [self detectionShake];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.closeShake = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     self.closeShake = YES;
}
-(void)dealloc{
    NSLog(@"xiaohui");
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_shake_result"]) {
        @weakify(self)
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self)
            x.identifier = [self.viewModel.shakeModel.sponsor stringByAppendingFormat:@"-%@", self.model.identifier];
        }]];
        [(XPBaseViewController *)segue.destinationViewController bindViewModel:self.viewModel];
    }
}

#pragma mark - Delegate
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
    if(!self.isAutomaticShake) {
        return YES;
    }
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self popToRoot];
    });
    return NO;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    if(!self.isAutomaticShake) {
        return YES;
    }
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self popToRoot];
    });
    return NO;
}

#pragma mark - Event Responds

#pragma mark - Private Methods
- (void)detectionShake
{
    @weakify(self);

    [[[RACObserve([XPMotionManager sharedInstance], shaking) ignore:@(NO)] takeUntilBlock:^BOOL (id x) {
        @strongify(self);
        NSLog(@"yyy");
        NSLog(@"%d",self.closeShake);
        return self.closeShake;
    }] subscribeNext:^(id x) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if(![window viewWithTag:9999]) {
            [[UIApplication sharedApplication] sendSock];
            @strongify(self);
            [self checkShakeResultType];
        }
    }];
}

- (void)checkShakeResultType
{
    if(self.viewModel.shakeNumerModel.activeJoinNum <= self.viewModel.shakeNumerModel.todayActiveNum && self.viewModel.shakeNumerModel.activeJoinNum!=(-1)) {
        // 当前活动参与次数已经达到允许的次数
        [self showShakeNumberOverTip];
    } else {//当前还有参与活动次数
        if(self.viewModel.shakeNumerModel.remainPoint >= (self.viewModel.shakeNumerModel.exchangePoint)){
            //若当前剩余金币够
            //把金币减掉
            self.viewModel.shakeNumerModel.remainPoint -= self.viewModel.shakeNumerModel.exchangePoint;
            //把参加的次数加上1
            self.viewModel.shakeNumerModel.todayActiveNum+=1;
            [self.viewModel.shakeCommand execute:nil];
        }else {
            //若当前剩余金币不够
            [self showGoldNumberOverTip];
        }
    }
}

- (void)showShakeResultTip
{
    self.closeShake = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XPPlainWinningView *winningView = [XPPlainWinningView loadFromNib];
    winningView.tag = 9999;
    [winningView setFrame:window.bounds];
    [window addSubview:winningView];
    
    winningView.sponsorLabel.text = [NSString stringWithFormat:@"本次奖品由%@提供，点击礼物盒，查看大奖。", self.viewModel.shakeModel.sponsor];
    [winningView shakeView];
    
    @weakify(self);
    [[winningView.gotoShakeResultButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.closeShake = YES;
        [winningView removeFromSuperview];
        [self performSegueWithIdentifier:@"embed_shake_result" sender:self];
        
    }];
    [winningView whenTapped:^{
        @strongify(self)
        self.closeShake = NO;
        [winningView removeFromSuperview];
    }];
}

//显示金币数不足
-(void)showGoldNumberOverTip{
        @weakify(self);
        self.closeShake = YES;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        XPPlainTheGoldNumberOverView *goldNumberOverView = [XPPlainTheGoldNumberOverView loadFromNib];
        goldNumberOverView.tag = 9999;
        [goldNumberOverView setFrame:window.bounds];
        [window addSubview:goldNumberOverView];
    
        goldNumberOverView.goldNumberOverLabel.text = [NSString stringWithFormat:@"您现在奖金币不足%ld个,不能参加抽奖,快去积累奖金币吧!",self.viewModel.shakeNumerModel.exchangePoint];
        [goldNumberOverView shakeView];
    [goldNumberOverView whenTapped:^{
        @strongify(self)
        self.closeShake = NO;
        [goldNumberOverView removeFromSuperview];
    }];

    
    //如何获得奖金币按钮点击
    //天成修改
        goldNumberOverView.howToGetGoldBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
             @strongify(self)
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                //                x.identifier = self.viewModel.ruleURL;
                x.identifier=self.viewModel.shakeNumerModel.pointsRule;
                x.baseTransfer = @"奖金币规则";
//                NSLog(@"金币");
            }];
        }]];
            [goldNumberOverView removeFromSuperview];
        return [RACSignal empty];
    }];

        [goldNumberOverView whenTapped:^{
            @strongify(self);
            self.closeShake = NO;
            [goldNumberOverView removeFromSuperview];
        }];
}

//显示次数已经用完,天成添加
-(void)showShakeNumberOverTip{
        self.closeShake = YES;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        XPPlainTheShakeNumberOverView *shakeNumberOverView = [XPPlainTheShakeNumberOverView loadFromNib];
        shakeNumberOverView.tag = 9999;
        [shakeNumberOverView setFrame:window.bounds];
        [window addSubview:shakeNumberOverView];
        [shakeNumberOverView shakeView];
    shakeNumberOverView.shakeNumberOverLabel.text=[NSString stringWithFormat:@"本次活动每日限摇%ld次,您今日摇奖次数已用完,去参加别的活动吧!",self.viewModel.shakeNumerModel.activeJoinNum];
    
        @weakify(self);
        [[shakeNumberOverView.goTomorrowBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [shakeNumberOverView removeFromSuperview];
            @strongify(self);
            [self popToRoot];
        }];
    [shakeNumberOverView whenTapped:^{
        @strongify(self)
        self.closeShake = NO;
        [shakeNumberOverView removeFromSuperview];
    }];

}


#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
