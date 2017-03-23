//
//  XMainPViewScrapeViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/4/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPMainPlainScrapeViewController.h"
#import "XPLoginModel.h"
#import "XPMainPlainScrapeViewModel.h"
#import "XPWebViewController.h"
#import "XPTCWebViewController.h"
#import "XPScrapePrizeListView.h"
#import "XPMainGroupModel.h"
#import "XPMainPlainModel.h"
#import "ScratchShowNoWin.h"
#import "ScratchShowNoTime.h"
#import "ScratchShowSuccess.h"
#import "scratchTouchView.h"
#import "XPMainPlainShakeResultViewController.h"
#import "XPAwardViewController.h"
#import "ScratchTicketTouchView.h"
#import "ScratchBtn.h"

#define navigationBarH 64
#define TabBarH 49

@interface XPMainPlainScrapeViewController ()<UIWebViewDelegate>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"

@property (strong, nonatomic)XPMainPlainScrapeViewModel *ViewModel;

//刮刮乐那个奖券图
@property (nonatomic, strong)UIImageView* ticketImageView;
//开始刮奖时的刮奖(以下3个都是)
//@property (nonatomic, weak)UIImageView* imageView;
//@property (nonatomic, weak)scratchTouchView* touchView;
//@property (nonatomic, weak)UILabel* prizeLabel;
@property (nonatomic, weak)ScratchTicketTouchView* ticketTouchView;



//刮一次花费10奖金币
@property (strong, nonatomic)UILabel *userGoldOnceLabel;
//点击开始挂机
@property (strong, nonatomic)UIButton *startScrapeBtn;
//有奖金币多少个,可刮奖几次
@property (strong, nonatomic)UILabel *canScrapeNumberLabelL;
//可刮奖几次
@property (strong, nonatomic)UILabel *canScrapeNumberLabelR;
//活动规则
//@property (strong, nonatomic)UIButton *activeRuleUrlBtn;
@property (nonatomic, strong)ScratchBtn* scratchBtn;

//创建下面的那些奖项(一等,二等,三等)
@property (strong, nonatomic)XPScrapePrizeListView* scrapePrizeView;

@property (nonatomic, weak)ScratchShowNoWin* scratchShowNoWin;
@property (nonatomic, strong)ScratchShowNoTime* scratchShowNoTime;
@property (nonatomic, weak)ScratchShowSuccess* scratchShowSuccess;

@end

@implementation XPMainPlainScrapeViewController
-(void)dealloc{
    NSLog(@"刮奖销毁");
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    @weakify(self)
    self.view.backgroundColor=RGBA(255, 56, 26, 1);
    NSLog(@"%@  %lu",self.model.baseTransfer,(unsigned long)[(NSArray *)self.model.baseTransfer count]);
    self.title=self.model.identifier;
    NSLog(@"1%@1",self.title);
    self.ViewModel.podiumId = [(NSArray *)self.model.baseTransfer objectAtIndex:0];
    self.ViewModel.joinNumber = [[(NSArray *)self.model.baseTransfer objectAtIndex:2] integerValue];
    self.ViewModel.prizeList=[(NSArray *)self.model.baseTransfer objectAtIndex:3];
   
    
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    //观察model
    [self observeWay];
    //创建界面
    [self crateTheInterface];

    
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.ViewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.ViewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];

   
    //活动规则点击
    self.scratchBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            
            @strongify(self);
            if([XPLoginModel singleton].signIn) {
                [self enterTheH5ActivityRule];
            } else {
                [self presentLogin];
            }
            
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            @strongify(self);
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
    }];

    //执行scrapeNumber
    [self.ViewModel.scrapeNumberCommand execute:nil];
    
    UIWindow* window=[UIApplication sharedApplication].keyWindow;

    [[[self.ViewModel.scrapeCommand executionSignals] concat] subscribeNext:^(id x) {
        @strongify(self);
        
        self.ticketTouchView.touchBlock=^{
            UIWindow* window=[UIApplication sharedApplication].keyWindow;
            @strongify(self)
            [self.ticketTouchView.touchView removeFromSuperview];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(self.ViewModel.scrapeModel.isWinning == NO){
                    [window addSubview:self.scratchShowNoWin];
                    
                }else{
                    
                    self.scratchShowSuccess.prizeName=self.ViewModel.scrapeModel.prizeTitle;
                    
                    [window addSubview:self.scratchShowSuccess];
                    
                }
                
            });
             };
        if(self.ViewModel.scrapeModel.isWinning == NO){
            self.ticketTouchView.label.text=@"谢谢参与";
        }else{
            self.ticketTouchView.label.text=self.ViewModel.scrapeModel.prizeGradeName;
        }
       
    }];
    
 }
//创建右边
//创建页面
-(void)crateTheInterface{
    //创建刮刮乐头部的图片
    UIImage* headImage=[UIImage imageNamed:@"scrape_Header"];
    NSLog(@"%lf  %lf",headImage.height,headImage.width);
    CGFloat headImageScale=headImage.height/headImage.width;
    NSLog(@"%lf",headImageScale);
    UIImageView* headImageView=[[UIImageView alloc]initWithImage:headImage];
    headImageView.contentMode=UIViewContentModeScaleAspectFit;
    headImageView.left=21;
    headImageView.width=ScreenW-42;
    headImageView.top=10+navigationBarH;
    headImageView.height=headImageScale*headImageView.width;
    NSLog(@"%lf   %lf",headImageView.width, headImageView.height);
    [self.view addSubview:headImageView];
    
    //创建刮刮乐下面那个奖券图片
    UIImage* ticketImage=[UIImage imageNamed:@"scrape_Ticket"];
    CGFloat ticketImageScale=ticketImage.height/ticketImage.width;
    self.ticketImageView.userInteractionEnabled=YES;
    self.ticketImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.ticketImageView.left=26;
    self.ticketImageView.width=ScreenW-26*2;
    self.ticketImageView.top=headImageView.bottom+17;
    self.ticketImageView.height=ticketImageScale * self.ticketImageView.width;
    NSLog(@"%lf   %lf",self.ticketImageView.width, self.ticketImageView.height);
    [self.view addSubview:self.ticketImageView];
    //刮一次花费10个奖金币label
    self.userGoldOnceLabel.text=@"刮一次花费10奖金币";
    self.userGoldOnceLabel.textColor=[UIColor colorWithHexString:@"#066666"];
    self.userGoldOnceLabel.textAlignment=NSTextAlignmentCenter;
    [self.ticketImageView addSubview:self.userGoldOnceLabel];
    self.userGoldOnceLabel.font=[UIFont systemFontOfSize:18];
    [self.userGoldOnceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ticketImageView.mas_centerX);
        make.top.equalTo(self.ticketImageView.mas_top).with.offset(40);
    }];
//    //点击开始刮奖按钮
    [self.startScrapeBtn setImage:[UIImage imageNamed:@"startScrapeBtn"] forState:UIControlStateNormal];
    [self.ticketImageView addSubview:self.startScrapeBtn];
    [self.startScrapeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ticketImageView.mas_centerX);
        make.bottom.equalTo(self.ticketImageView).with.offset(-25);
    }];
    
    
    
    //创建//有奖金币多少个,可刮奖几次Label
    self.canScrapeNumberLabelL.textColor=[UIColor whiteColor];
    self.canScrapeNumberLabelL.font=[UIFont systemFontOfSize:14];
    self.canScrapeNumberLabelL.text=@"";
    [self.view addSubview:self.canScrapeNumberLabelL];
    [self.canScrapeNumberLabelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ticketImageView.mas_bottom);
        make.left.equalTo(self.view).with.offset(46);
        make.height.equalTo(@33);
    }];
    [self.canScrapeNumberLabelL layoutIfNeeded];
    self.canScrapeNumberLabelR.textColor=[UIColor whiteColor];
    self.canScrapeNumberLabelR.font=[UIFont systemFontOfSize:14];
    self.canScrapeNumberLabelR.text=@"";
    [self.view addSubview:self.canScrapeNumberLabelR];
    [self.canScrapeNumberLabelR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ticketImageView.mas_bottom);
        make.right.equalTo(self.view).with.offset(-46);
        make.height.equalTo(@33);
    }];
    
    
    //创建奖项设置那个图
    UIImage* awardsImage=[UIImage imageNamed:@"scrape_Bgd"];
    CGFloat awardImageScale=awardsImage.height/awardsImage.width;
    UIImageView* awardImageView=[[UIImageView alloc]initWithImage:awardsImage];
    awardImageView.userInteractionEnabled=YES;
    awardImageView.contentMode=UIViewContentModeScaleAspectFit;
    awardImageView.left=31;
    awardImageView.width=ScreenW-31*2;
    awardImageView.top=self.canScrapeNumberLabelL.bottom;
    awardImageView.height=awardImageScale * self.ticketImageView.width;
     NSLog(@"%lf   %lf",awardImageView.width, awardImageView.height);
    [self.view addSubview:awardImageView];
    //奖项设置Label
    UILabel* setLabel=[[UILabel alloc]init];
    setLabel.text=@"奖项设置";
    setLabel.font=[UIFont systemFontOfSize:14];
    setLabel.textColor=[UIColor whiteColor];
    [awardImageView addSubview:setLabel];
    [setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(awardImageView.mas_centerX);
        make.top.equalTo(awardImageView.mas_top).with.offset(23);
    }];
    //左边的横线与右边的横线
    UIView* leftLine=[[UIView alloc]init];
    leftLine.backgroundColor=[UIColor whiteColor];
    [awardImageView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(setLabel.mas_centerY);
        make.height.mas_equalTo(@1);
        make.width.mas_equalTo(@50);
        make.right.mas_equalTo(setLabel.mas_left);
    }];
    UIView* rightLine=[[UIView alloc]init];
    rightLine.backgroundColor=[UIColor whiteColor];
    [awardImageView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(setLabel.mas_centerY);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(50);
        make.left.mas_equalTo(setLabel.mas_right);
    }];
    //创建下面的那些奖项(一等,二等,三等)
    [awardImageView addSubview:self.scrapePrizeView];
    [self.scrapePrizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(awardImageView).with.offset(15);
        make.right.mas_equalTo(awardImageView).with.offset(-15);
        make.top.mas_equalTo(setLabel.mas_bottom).with.offset(10);
        make.bottom.mas_equalTo(awardImageView).with.offset(-23);
    }];
    
    //创建活动规则button
    [self.scratchBtn setTitleColor:[UIColor whiteColor]];
    [self.scratchBtn setTitle:@"活动规则" forState:UIControlStateNormal];
    self.scratchBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    self.scratchBtn.centerX=self.view.centerX;
    self.scratchBtn.centerY=(ScreenH-awardImageView.bottom)/2+awardImageView.bottom;
    [self.scratchBtn setImage:[UIImage imageNamed:@"iconfont-icon"] forState:UIControlStateNormal];
    [self.view addSubview:self.scratchBtn];
    NSLog(@"%@",NSStringFromCGRect(self.scratchBtn.frame));
}

//观察
-(void)observeWay{
    @weakify(self)
    [[RACObserve(self, ViewModel.scrapeNumerModel.todayActiveNum)ignore:nil]subscribeNext:^(NSString* x) {
        NSInteger remainPoint=self.ViewModel.scrapeNumerModel.remainPoint;
        @strongify(self)
        if (self.ViewModel.scrapeNumerModel.exchangePoint == 0) {
            self.canScrapeNumberLabelL.hidden=NO;
            self.canScrapeNumberLabelR.hidden=NO;
            NSMutableAttributedString* canScrapeNumberStrML=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您有奖金币"]];
            NSAttributedString* canScrapeNumberString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld个",remainPoint] attributes:@{NSForegroundColorAttributeName:RGBA(248, 242, 69, 1)}];
            [self.startScrapeBtn addTarget:self action:@selector(startScrape) forControlEvents:UIControlEventTouchUpInside];
            [self.startScrapeBtn setImage:[UIImage imageNamed:@"startScrapeBtn"] forState:UIControlStateNormal];
            NSMutableAttributedString* strM=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"刮一次花费"]];
            NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",self.ViewModel.scrapeNumerModel.exchangePoint] attributes:@{NSForegroundColorAttributeName:RGBA(255, 37, 70, 1)}];
            NSMutableAttributedString* canScrapeNumberStrMR=[[NSMutableAttributedString alloc]initWithString:@"可刮奖" ];
            NSAttributedString* canScrapeNumberString3=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld次",self.ViewModel.scrapeNumerModel.activeJoinNum-self.ViewModel.scrapeNumerModel.todayActiveNum] attributes:@{NSForegroundColorAttributeName:RGBA(248, 242, 69, 1)}];
            
            [canScrapeNumberStrML appendAttributedString:canScrapeNumberString];
            //            [canScrapeNumberStrM appendAttributedString:canScrapeNumberString2];
            [canScrapeNumberStrMR appendAttributedString:canScrapeNumberString3];
            self.canScrapeNumberLabelL.attributedText=canScrapeNumberStrML;
            self.canScrapeNumberLabelR.attributedText=canScrapeNumberStrMR;
            NSAttributedString* attribuuteString2=[[NSAttributedString alloc]initWithString:@"个奖金币" ];
            [strM appendAttributedString:attribuuteString];
            [strM appendAttributedString:attribuuteString2];
            self.userGoldOnceLabel.attributedText=strM;
            
            if (self.ViewModel.scrapeNumerModel.activeJoinNum == -1) {
                self.canScrapeNumberLabelR.hidden = YES;
            }else{

  
            }
        }else if (remainPoint >= self.ViewModel.scrapeNumerModel.exchangePoint){
            //开始刮奖按钮点击
            [self.startScrapeBtn addTarget:self action:@selector(startScrape) forControlEvents:UIControlEventTouchUpInside];
            [self.startScrapeBtn setImage:[UIImage imageNamed:@"startScrapeBtn"] forState:UIControlStateNormal];
            
            self.canScrapeNumberLabelL.hidden=NO;
            self.canScrapeNumberLabelR.hidden=NO;
            NSMutableAttributedString* canScrapeNumberStrML=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您有奖金币"]];
            NSAttributedString* canScrapeNumberString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld个",remainPoint] attributes:@{NSForegroundColorAttributeName:RGBA(248, 242, 69, 1)}];
            
            NSMutableAttributedString* canScrapeNumberStrMR=[[NSMutableAttributedString alloc]initWithString:@"可刮奖" ];
             NSAttributedString* canScrapeNumberString3=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld次",remainPoint/self.ViewModel.scrapeNumerModel.exchangePoint] attributes:@{NSForegroundColorAttributeName:RGBA(248, 242, 69, 1)}];
            
            [canScrapeNumberStrML appendAttributedString:canScrapeNumberString];
//            [canScrapeNumberStrM appendAttributedString:canScrapeNumberString2];
            [canScrapeNumberStrMR appendAttributedString:canScrapeNumberString3];
            self.canScrapeNumberLabelL.attributedText=canScrapeNumberStrML;
            self.canScrapeNumberLabelR.attributedText=canScrapeNumberStrMR;
            
            NSMutableAttributedString* strM=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"刮一次花费"]];
            NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",self.ViewModel.scrapeNumerModel.exchangePoint] attributes:@{NSForegroundColorAttributeName:RGBA(255, 37, 70, 1)}];
            
            NSAttributedString* attribuuteString2=[[NSAttributedString alloc]initWithString:@"个奖金币" ];
            [strM appendAttributedString:attribuuteString];
            [strM appendAttributedString:attribuuteString2];
            
            
            self.userGoldOnceLabel.attributedText=strM;
        }else{
            //如何获得奖金币
            [self.startScrapeBtn addTarget:self action:@selector(enterTheH5HowToGetGold) forControlEvents:UIControlEventTouchUpInside];
            [self.startScrapeBtn setImage:[UIImage imageNamed:@"scrape_getGold"] forState:UIControlStateNormal];

            if(remainPoint==0){
                self.canScrapeNumberLabelL.hidden=YES;
                self.canScrapeNumberLabelR.hidden=YES;
                self.userGoldOnceLabel.text=@"很遗憾没有奖金币不能刮奖哦~";
            }else{
                self.canScrapeNumberLabelL.hidden=YES;
                self.canScrapeNumberLabelR.hidden=YES;
                NSMutableAttributedString* strM=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"还差"]];
                NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",self.ViewModel.scrapeNumerModel.exchangePoint-remainPoint] attributes:@{NSForegroundColorAttributeName:RGBA(255, 37, 70, 1)}];
            
                NSAttributedString* attribuuteString2=[[NSAttributedString alloc]initWithString:@"个奖金币才能刮奖哦~" ];
                [strM appendAttributedString:attribuuteString];
                [strM appendAttributedString:attribuuteString2];
            

                self.self.userGoldOnceLabel.attributedText=strM;
            }
        }
    }];
    RAC(self.scrapePrizeView,prizeList)= [RACObserve(self, ViewModel.prizeList)ignore:nil];

}

//开始刮奖
-(void)startScrape{

    UIWindow* window= [UIApplication sharedApplication].keyWindow;
    if(self.ViewModel.scrapeNumerModel.activeJoinNum <= self.ViewModel.scrapeNumerModel.todayActiveNum && self.ViewModel.scrapeNumerModel.activeJoinNum!=(-1)) {
        // 当前活动参与次数已经达到允许的次数
        [window addSubview:self.scratchShowNoTime];
    } else {//当前还有参与活动次数
        if(self.ViewModel.scrapeNumerModel.remainPoint >= (self.ViewModel.scrapeNumerModel.exchangePoint)){
            [self.ViewModel.scrapeCommand execute:nil];
            //若当前剩余金币够
            //把金币减掉
            self.ViewModel.scrapeNumerModel.remainPoint -= self.ViewModel.scrapeNumerModel.exchangePoint;
            //把参加的次数加上1
            self.ViewModel.scrapeNumerModel.totalActiveNum+=1;
            self.ViewModel.scrapeNumerModel.todayActiveNum+=1;
        }else {
            //若当前剩余金币不够
            //            [self showCoinNotEnough];
        }
    }


}


-(void)enterTheH5HowToGetGold{
    
    @weakify(self)
    [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
        @strongify(self)
        x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);
            
            x.identifier=self.ViewModel.scrapeNumerModel.pointsRule;
            x.baseTransfer = @"奖金币规则";
        }];
    }]];
}
-(void)enterTheH5ActivityRule{
    
    @weakify(self)
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
        @strongify(self)
        x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);
            //                x.identifier = self.viewModel.ruleURL;
            x.identifier=[NSString stringWithFormat:@"%@?activityId=%@",self.ViewModel.scrapeNumerModel.activeRuleUrl,self.ViewModel.podiumId];
            x.baseTransfer = @"活动规则";
        }];
    }]];
}


#pragma mark- 以下的是懒加载
-(XPMainPlainScrapeViewModel*)ViewModel{
    if(!_ViewModel){
        _ViewModel=[[XPMainPlainScrapeViewModel alloc]init];
    }
    return _ViewModel;
}
-(UIImageView *)ticketImageView{
    if(!_ticketImageView ){
        UIImage* ticketImage=[UIImage imageNamed:@"scrape_Ticket"];
        _ticketImageView=[[UIImageView alloc]initWithImage:ticketImage];
    }
    return _ticketImageView;
}
-(ScratchTicketTouchView*)ticketTouchView{
    if(!_ticketTouchView){
        @weakify(self)
        ScratchTicketTouchView* ticketTouchView=[[ScratchTicketTouchView alloc]initWithFrame:self.ticketImageView.bounds];
        _ticketTouchView=ticketTouchView;
        [self.ticketImageView addSubview:_ticketTouchView];


    }
    return _ticketTouchView;
}


-(UILabel *)userGoldOnceLabel{
    if(!_userGoldOnceLabel){
        _userGoldOnceLabel=[[UILabel alloc]init];
    }
    return _userGoldOnceLabel;
}
-(UIButton *)startScrapeBtn{
    if(!_startScrapeBtn){
        _startScrapeBtn=[[UIButton alloc]init];
    }
    return _startScrapeBtn;
}
-(UILabel *)canScrapeNumberLabelL{
    if(!_canScrapeNumberLabelL){
        _canScrapeNumberLabelL=[[UILabel alloc]init];
    }
    return _canScrapeNumberLabelL;
}
-(UILabel *)canScrapeNumberLabelR{
    if(!_canScrapeNumberLabelR){
        _canScrapeNumberLabelR=[[UILabel alloc]init];
    }
    return _canScrapeNumberLabelR;
}

-(ScratchBtn*)scratchBtn{
    if(!_scratchBtn){
        _scratchBtn=[[ScratchBtn alloc]init];
    }
    return _scratchBtn;
}
-(XPScrapePrizeListView*)scrapePrizeView{
    if(!_scrapePrizeView){
        _scrapePrizeView=[[XPScrapePrizeListView alloc]init];
    }
    return _scrapePrizeView;
}


//没关系,谢谢参与
-(ScratchShowNoWin*)scratchShowNoWin{
    if(!_scratchShowNoWin){
        @weakify(self)
        ScratchShowNoWin* noWin=[[ScratchShowNoWin alloc]initWithFrame:self.view.bounds];
        _scratchShowNoWin=noWin;
        UIWindow* window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:noWin];
        [_scratchShowNoWin.blackBgView whenTapped:^{
            @strongify(self)
           
            [_scratchShowNoWin removeFromSuperview];
            [self.ticketTouchView removeFromSuperview];
        }];
        [_scratchShowNoWin.NoWinBtn addTarget:self action:@selector(againBtnClick) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _scratchShowNoWin;
}
//再玩一次
-(void)againBtnClick{
     UIWindow* window=[UIApplication sharedApplication].keyWindow;
    [self.scratchShowNoWin removeFromSuperview];
     [self.ticketTouchView removeFromSuperview];
}

-(ScratchShowSuccess*)scratchShowSuccess{
    if(!_scratchShowSuccess){
        @weakify(self)
        ScratchShowSuccess* success=[[ScratchShowSuccess alloc]initWithFrame:self.view.bounds];
        _scratchShowSuccess=success;
        UIWindow* window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:_scratchShowSuccess];
        [_scratchShowSuccess.blackBgView whenTapped:^{
            @strongify(self)
            
            [_scratchShowSuccess removeFromSuperview];
             [self.ticketTouchView removeFromSuperview];
        }];
        [_scratchShowSuccess.scratchNext addTarget:self action:@selector(againBtnClickSuccess) forControlEvents:UIControlEventTouchUpInside];
        [_scratchShowSuccess.scratchSuccess addTarget:self action:@selector(acceptThePrize) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scratchShowSuccess;
}
//再玩一次
-(void)againBtnClickSuccess{
    UIWindow* window=[UIApplication sharedApplication].keyWindow;
    
    [self.scratchShowSuccess removeFromSuperview];
     [self.ticketTouchView removeFromSuperview];
}
//去领奖
-(void)acceptThePrize{
    [self.scratchShowSuccess removeFromSuperview];
    XPMainPlainShakeResultViewController* shakeResultViewController=(XPMainPlainShakeResultViewController*)[self instantiateViewControllerWithStoryboardName:@"Main" identifier:@"activityResult"];
    XPAwardViewController* awardViewController=[self instantiateInitialViewControllerWithStoryboardName:@"Award"];
    awardViewController.isAutomaticShake=YES;
    [self pushViewController:awardViewController];
    
}
-(ScratchShowNoTime*)scratchShowNoTime{
    
    if(!_scratchShowNoTime){
        @weakify(self)
        _scratchShowNoTime=[[ScratchShowNoTime alloc]initWithFrame:self.view.bounds];
        [_scratchShowNoTime.blackBgView whenTapped:^{
            @strongify(self)

            [_scratchShowNoTime removeFromSuperview];
             [self.ticketTouchView removeFromSuperview];
        }];
        [[_scratchShowNoTime.knowBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.scratchShowNoTime removeFromSuperview];
            [self popToRoot];
        }];
    }
    return _scratchShowNoTime;
}

@end
