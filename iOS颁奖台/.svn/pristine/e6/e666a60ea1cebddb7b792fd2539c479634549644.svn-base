//
//  XPMainPlainViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/24/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "NSObject+XPShareSDK.h"
#import "NSString+XPRemoteImage.h"
#import "XPLoginModel.h"
#import "XPMainPlainModel.h"
#import "XPMainPlainViewController.h"
#import "XPMainPlainViewModel.h"
#import "XPPlainFinishedView.h"
#import "XPPlainJoinedView.h"
#import "XPPlainOverflowFinishedView.h"
#import "XPPlainShareableAndNotStartView.h"
#import "XPPlainShareableAndStartedView.h"
#import "XPPlainTenMinuteCounterView.h"
#import "XPPlainTenSecondCounterView.h"
#import <DateTools/DateTools.h>
#import <XPKit/XPKit.h>
#import <XPShouldPop/UINavigationController+XPShouldPop.h>
#import "XPPlainIntroductionView.h"
//#import "XPPlainShareableAndStartedDrawView.h"
//#import "XPPlainShareableAndNotStartDrawView.h"
#import "XPPlainStartView.h"
//#import "XPPlainStartDrawView.h"
#import "RaffleViewController.h"
//#import "XPPlainStartScrapeView.h"
//#import "XPPlainShareableAndStartedScrapeView.h"
//#import "XPPlainShareableAndNotStartScrapeView.h"
#import "XPMainPlainScrapeViewController.h"
#import "XPPlainIntroductionedView.h"
#import "showShareToView.h"

typedef NS_ENUM (NSInteger, PlainActivityState) {
    Plain_Activity_End = 0,//结束
    Plain_Activity_Not_Start,//未开始
    Plain_Activity_Started//已经开始
};

@interface XPMainPlainViewController ()<UINavigationControllerShouldPop>
{
    CGFloat offsetHeight;
    UIView *sharebgView;
    showShareToView *showSView;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMainPlainViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)RACSignal* observeSignal;

@property (nonatomic, strong) NSTimer *checkTimer;
@property (nonatomic, assign) NSInteger currentServerTimeStamp;
//本活动已经结束
@property (nonatomic, strong) XPPlainFinishedView *finishedView;
//已经参与过本次活动
@property (nonatomic, strong) XPPlainJoinedView *joinedView;
//今日活动已结束
@property (nonatomic, strong) XPPlainOverflowFinishedView *overflowFinishedView;
//分享即可参与摇奖/抽奖/刮奖(活动未开始)
@property (nonatomic, strong) XPPlainShareableAndNotStartView *shareableAndNotStartView;

//天成添加,判断是否是活动未开始的那个条条.写这个是因为无论是否需要分享的,只要活动没开始,点go之后都会去分享
@property(nonatomic,assign)BOOL isTheNotStartView;


//分享立即摇奖
@property (nonatomic, strong) XPPlainShareableAndStartedView *shareableAndStartedView;
////分享立即抽奖
//@property (nonatomic, strong) XPPlainShareableAndStartedDrawView *shareableAndStartedDrawView;
////分享立即刮奖
//@property (nonatomic, strong) XPPlainShareableAndStartedScrapeView *shareableAndStartedScrapeView;
//立即摇奖
@property (nonatomic, strong)XPPlainStartView *startView;

//10分钟  嗨摇倒计时
@property (nonatomic, strong) XPPlainTenMinuteCounterView *tenMinuteCounterView;
//数秒 9,8,7,6,5,4,3,2,1,0后开始活动
@property (nonatomic, strong) XPPlainTenSecondCounterView *tenSecondCounterView;
//未开始||已经开始||结束
@property (nonatomic, assign) PlainActivityState activityState;

//活动简介button
@property(nonatomic,strong)UIButton* IntroductionBtn;
//活动简介
//@property (nonatomic, strong)XPPlainIntroductionView* plainIntroductionView;
@property (nonatomic, strong)XPPlainIntroductionedView* plainIntroductionedView;


//@property (nonatomic, strong)NSString* change;
//@property (nonatomic, strong)NSString* change2;

@end

@implementation XPMainPlainViewController

#pragma mark - Life Circle
- (void)dealloc
{
    [_checkTimer invalidate];
    _checkTimer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    @weakify(self);

    self.activityState = Plain_Activity_End;
    
    //若self.viewModel的executing发生变化,则执行cleverLoader方法
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    //若self.viewModel的error发生变化且不为nil,则 执行showToastWithNSError:并把error作为参数传进去
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    // 黄新平 2016-02-16 导航栏右上角按钮去掉
    //    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithEnabled:[[RACObserve(self.viewModel, model) map:^id (id value) {
    //        return value ? @(YES) : @(NO);
    //    }] startWith:@(NO)] signalBlock:^RACSignal *(id input) {
    //        @strongify(self);
    //        [self shareButtonTaped];
    //        return [RACSignal empty];
    //    }];
    self.viewModel.podiumId = self.model.identifier;
    //将self.model.identifier赋值给self.viewModel.podiumId  因为这个参数是我们从跳转前拿来的,也是发出请求所需要的
    [self.viewModel.detailCommand execute:nil];
    
    RAC(self.navigationItem, title) = [RACSignal combineLatest:@[RACObserve(self.viewModel, model.sponsor), RACObserve(self.viewModel, model.title)] reduce:^id (NSString *sponsor, NSString *title){
        return [sponsor stringByAppendingFormat:@"-%@", title];
    }];
    //skip表示跳过第一次,因为刚开始self.activityState = Plain_Activity_End;
    [[RACObserve(self, activityState) skip:1] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        switch(x.integerValue) {
            case Plain_Activity_End: {
                self.navigationItem.rightBarButtonItem = nil;
            }
                break;
                
            case Plain_Activity_Started: {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
                break;
                
            case Plain_Activity_Not_Start: {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
                break;
                
            default: {
            }
                break;
        }
    }];
    [[RACObserve(self.viewModel, model) ignore:nil] subscribeNext:^(XPMainPlainModel *model) {
        @strongify(self);
        NSLog(@"%@",self.viewModel.model);
        
        //观察self.viewModel.model,若有值,则配置活动图片    并且每秒检查一次活动是否开始还是过期
        [self configScrollView];
        [self judgeActivityType];
        //活动简介//天成修改
        [self plainDetailView];

    }];
    [[[self rac_signalForSelector:@selector(viewWillAppear:)] skip:1]subscribeNext:^(id x) {
        [self.viewModel.detailCommand execute:nil];
    }];
    
    
    [[[[self.viewModel.shareReportCommand executionSignals] concat] bufferWithTime:0.5 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) { // 分享成功之后，跳到摇奖界面（已登录情况下）
        @strongify(self);
        self.viewModel.model.shareNumber++;
        if(self.activityState == Plain_Activity_Started) {
            if([XPLoginModel singleton].signIn ) {
                if([self canEnterTheGame:self.viewModel.model] ){
//                    //抽的
                    if([self.viewModel.model.activityType isEqualToString: @"L"]){
                        //马栎
                        RaffleViewController* raffleViewController=[[RaffleViewController alloc]init];
                        [raffleViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                            @strongify(self);
                            x.identifier = self.viewModel.model.title;
                            x.baseTransfer = @[self.viewModel.model.podiumId,@(NO),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
                        }]];
                        [self pushViewController:raffleViewController];
                        
                        
                    }else if([self.viewModel.model.activityType isEqualToString: @"E"]){
                        //摇的
                        [self performSegueWithIdentifier:@"embed_plain_shake" sender:@(NO)];
                    }else if([self.viewModel.model.activityType isEqualToString: @"G"]){
                        //刮奖
                        XPMainPlainScrapeViewController* mainPlainScrapeViewController=[[XPMainPlainScrapeViewController alloc]init];
                    [mainPlainScrapeViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                        @strongify(self);
                        x.identifier = self.viewModel.model.title;
                        x.baseTransfer = @[self.viewModel.model.podiumId,@(NO),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
                    }]];
                        [self pushViewController:mainPlainScrapeViewController];
                    }
                }
            } else {
                [self presentLogin];
            }
        }
    }];
}
//天成添加
//初步判断当前时间是否在活动时间内 包括当天时间  该方法是判断是否可以
-(BOOL)canEnterTheGame:(XPMainPlainModel*)model{
    // 如果shareNumber>0 且在时间戳内,且在当日活动时间范围内，则直接进入摇奖界面
    // 黄新平 2016-02-22
    
    NSString *startTime = model.startTime;
    NSString* endTime=model.endTime;
    NSInteger startSeconds = 0;
    NSInteger endSeconds = 0;
    NSArray *startTimeBuffer = [startTime componentsSeparatedByString:@":"];
    startSeconds = [startTimeBuffer[0] integerValue]*3600+[startTimeBuffer[1] integerValue]*60+0;
    NSArray *endTimeBuffer = [endTime componentsSeparatedByString:@":"];
    endSeconds = [endTimeBuffer[0] integerValue]*3600+[endTimeBuffer[1] integerValue]*60+0;
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceReferenceDate:self.currentServerTimeStamp];
    NSInteger nowSeconds = nowDate.hour*3600+nowDate.minute*60+nowDate.second;
    
    self.currentServerTimeStamp=model.requestServerTimeStamp;
    if( model.startTimeStamp <= self.currentServerTimeStamp && self.currentServerTimeStamp<model.stopTimeStamp && nowSeconds>=startSeconds && nowSeconds<=endSeconds && (model.joinNumber<model.joinTotal || model.joinTotal==(-1))) {
        return YES;
    }else{
        return NO;
    }
}

//这里是连线摇奖
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"embed_plain_shake"]) {
        @weakify(self);
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            @strongify(self);

            x.identifier = self.viewModel.model.title;
            x.baseTransfer = @[self.viewModel.model.podiumId, sender,@(self.viewModel.model.joinNumber)];
        }]];
    }
}

#pragma mark - Delegate
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController
{
    [_checkTimer invalidate];
    _checkTimer = nil;
    if(self.tenMinuteCounterView) {
        [self.tenMinuteCounterView forceKillTimer];
    }
    
    return YES;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    [_checkTimer invalidate];
    _checkTimer = nil;
    if(self.tenMinuteCounterView) {
        [self.tenMinuteCounterView forceKillTimer];
    }
    
    return YES;
}

#pragma mark - Event Responds
- (void)shareButtonTaped
{
    @weakify(self)
    if([self.viewModel.model.eligibility isEqualToString:@"N"]){
        //如果不需要分享的
        if(![XPLoginModel singleton].signIn) {
            [self presentLogin];
            return;
        }
        
        XPMainPlainModel *model = self.viewModel.model;
        //
        // 黄新平 2016-02-16
        if( [self canEnterTheGame:self.viewModel.model] && !self.isTheNotStartView) {
           
            if([self.viewModel.model.activityType isEqualToString: @"L"]){
                //抽的
                //马栎
                @weakify(self)
                RaffleViewController* raffleViewController=[[RaffleViewController alloc]init];
                [raffleViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                    @strongify(self);
                    x.identifier = self.viewModel.model.title;
                    x.baseTransfer = @[self.viewModel.model.podiumId,@(NO),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
                }]];
                [self pushViewController:raffleViewController];
            }else if([self.viewModel.model.activityType isEqualToString: @"E"]){
                //摇的
                [self performSegueWithIdentifier:@"embed_plain_shake" sender:@(NO)];
            }else if([self.viewModel.model.activityType isEqualToString: @"G"]){
                //刮奖
         XPMainPlainScrapeViewController* mainPlainScrapeViewController=[[XPMainPlainScrapeViewController alloc]init];
            [mainPlainScrapeViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                x.identifier = self.viewModel.model.title;
                x.baseTransfer = @[self.viewModel.model.podiumId,@(YES),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
            }]];

            [self pushViewController:mainPlainScrapeViewController];
            }
            return;
        }
        //如果是活动未开始的
        if(self.isTheNotStartView){
            //进入分享
            [self showShareView];
        }
    }else{
        //如果需要分享的
        if(![XPLoginModel singleton].signIn) {
            [self presentLogin];
            return;
        }
        XPMainPlainModel *model = self.viewModel.model;
        // 如果shareNumber>0，则直接进入摇奖界面
        // 黄新平 2016-02-16
         NSLog(@"%@",self.viewModel.model.activityType);
        if(model.shareNumber > 0 && [self canEnterTheGame:self.viewModel.model]) {
            if([self.viewModel.model.activityType isEqualToString: @"L"]){
                //马栎
                @weakify(self)
                RaffleViewController* raffleViewController=[[RaffleViewController alloc]init];
                [raffleViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                    @strongify(self);
                    x.identifier = self.viewModel.model.title;
                    x.baseTransfer = @[self.viewModel.model.podiumId,@(NO),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
                }]];
                [self pushViewController:raffleViewController];
                
            }else if([self.viewModel.model.activityType isEqualToString: @"E"]){
                [self performSegueWithIdentifier:@"embed_plain_shake" sender:@(NO)];
            }else if([self.viewModel.model.activityType isEqualToString: @"G"]){
                //刮奖
            XPMainPlainScrapeViewController* mainPlainScrapeViewController=[[XPMainPlainScrapeViewController alloc]init];
            [mainPlainScrapeViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
  
                x.identifier = self.viewModel.model.title;
                x.baseTransfer = @[self.viewModel.model.podiumId,@(NO),@(self.viewModel.model.joinNumber),self.viewModel.model.prizeList];
            }]];
            [self pushViewController:mainPlainScrapeViewController];
                        }
            return;
        }
        //进入分享
        [self showShareView];
    }
}
//进入分享界面
-(void)showShareView
{
    sharebgView = [[UIView alloc]initWithFrame:self.view.frame];
    sharebgView.backgroundColor = [UIColor blackColor];
    sharebgView.alpha = 0.3;
    showSView = [[showShareToView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [self.view addSubview:sharebgView];
    [self.view addSubview:showSView];
    [showSView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [[showSView.weChatBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self enterWeChat];
    }];
    [[showSView.weFriendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self enterTheShareInterface];
    }];
    [[showSView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [sharebgView removeFromSuperview];
        [showSView removeFromSuperview];
    
    }];


}
-(void)enterTheShareInterface{
    XPMainPlainModel *model = self.viewModel.model;
    NSMutableString *imageBuffer = [NSMutableString string];
    for(NSInteger i = 0; i < model.imageList.count; i++) {
        [imageBuffer appendFormat:@"%@,", model.imageList[i][@"image"]];
    }
    [imageBuffer deleteCharactersInRange:NSMakeRange(imageBuffer.length-1, 1)];
    
//    NSString *time = [NSString stringWithFormat:@"%@~%@ %@-%@", model.startDate, model.endDate, model.startTime, model.endTime];
    NSLog(@"%@",[model.shareUrl removeWhitespaceAndNewline]);
    @weakify(self);
    [[self shareWithTitle:model.shareTitle content:model.shareContent images:@[model.shareImage] url:[[model.shareUrl removeWhitespaceAndNewline] stringByAppendingFormat:@"?fromUserid=%@&fromUserPhone=%@&activityId=%@&title=%@", [XPLoginModel singleton].userId, [XPLoginModel singleton].userPhone,model.podiumId, [model.title urlEncode]] platformType:SSDKPlatformSubTypeWechatTimeline] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.activityTitle = self.viewModel.model.title;
        self.viewModel.activeSharePoint = self.viewModel.model.activeSharePoint;
        [self.viewModel.shareReportCommand execute:nil];
    }];
    [sharebgView removeFromSuperview];
    [showSView removeFromSuperview];
}
-(void)enterWeChat{
    XPMainPlainModel *model = self.viewModel.model;
    NSMutableString *imageBuffer = [NSMutableString string];
    for(NSInteger i = 0; i < model.imageList.count; i++) {
        [imageBuffer appendFormat:@"%@,", model.imageList[i][@"image"]];
    }
    [imageBuffer deleteCharactersInRange:NSMakeRange(imageBuffer.length-1, 1)];
    
//    NSString *time = [NSString stringWithFormat:@"%@~%@ %@-%@", model.startDate, model.endDate, model.startTime, model.endTime];
    NSLog(@"%@",[model.shareUrl removeWhitespaceAndNewline]);
    @weakify(self);
    [[self shareWithTitle:model.shareTitle content:model.shareContent images:@[model.shareImage] url:[[model.shareUrl removeWhitespaceAndNewline] stringByAppendingFormat:@"?fromUserid=%@&fromUserPhone=%@&activityId=%@&title=%@", [XPLoginModel singleton].userId, [XPLoginModel singleton].userPhone,model.podiumId, [model.title urlEncode]] platformType:SSDKPlatformSubTypeWechatSession] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.activityTitle = self.viewModel.model.title;
        self.viewModel.activeSharePoint = self.viewModel.model.activeSharePoint;
        [self.viewModel.shareReportCommand execute:nil];
    }];
    [sharebgView removeFromSuperview];
    [showSView removeFromSuperview];
}
#pragma mark - Private Methods
- (void)judgeActivityType
{
    XPMainPlainModel *model = self.viewModel.model;
    self.currentServerTimeStamp = model.requestServerTimeStamp;
    //    self.currentServerTimeStamp = model.startTimeStamp-13;
    [self.checkTimer invalidate];
    self.checkTimer = nil;
    
    @weakify(self);// 每秒检查一次
    self.checkTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
        @strongify(self);
        [self checkActivityState];
    }
                                                      repeats:YES];
}

//每秒检查一次
- (void)checkActivityState
{
    self.currentServerTimeStamp += 1;
    XPMainPlainModel *model = self.viewModel.model;
    if(model.stopTimeStamp <= self.currentServerTimeStamp) { // 活动全部结束
        [self showActivityEndTip];
    } else{
        if(model.startTimeStamp > self.currentServerTimeStamp) {  // 活动未开始
            if(model.startTimeStamp-self.currentServerTimeStamp <= 600) {
                if(model.startTimeStamp-self.currentServerTimeStamp <= 10) { // 10秒倒计时（也许一进来就是从7秒开始倒计时）
                    XPLog(@"10秒倒计时");
                    [self showTenSecondCounterTipWithOffset:model.startTimeStamp-self.currentServerTimeStamp];
                } else { // 600秒（10分钟）倒计时（也许只有8分30秒）
                    XPLog(@"10分钟倒计时");
                    [self showTenMinutenCounterTipWithOffset:model.startTimeStamp-self.currentServerTimeStamp];
                }
            } else { // 600秒外
                XPLog(@"10分钟之外-分享（底部）");
                //摇奖或抽奖
                [self showActivityShareableAndNotStartTip];
            }
        } else { // 活动进行中（可能跨越几天，如3天）
            /*
             活动进行中需要判断3种情况：
             1、当前时间比当日活动开始时间要早
             2、当前时间正好在活动开始时间和活动结束时间之间
             3、当前时间比当日活动结束时间要晚
             */
            NSDate *nowDate = [NSDate dateWithTimeIntervalSinceReferenceDate:self.currentServerTimeStamp];
            NSLog(@"%@",model.startTime);
            NSLog(@"%@",model.endTime);
            NSLog(@"%ld   %ld   %ld",nowDate.hour,nowDate.minute,nowDate.second);
            NSInteger nowSeconds = nowDate.hour*3600+nowDate.minute*60+nowDate.second;
            NSInteger startSeconds = 0;
            NSInteger endSeconds = 0;
            {
                NSString *startTime = model.startTime;
                NSArray *startTimeBuffer = [startTime componentsSeparatedByString:@":"];
                startSeconds = [startTimeBuffer[0] integerValue]*3600+[startTimeBuffer[1] integerValue]*60+0;
            }
            {
                NSString *endTime = model.endTime;
                NSArray *endTimeBuffer = [endTime componentsSeparatedByString:@":"];
                endSeconds = [endTimeBuffer[0] integerValue]*3600+[endTimeBuffer[1] integerValue]*60+0;
            }
            if(nowSeconds >= endSeconds) { // 当前时间 >= 当日的抽奖结束时间（如：抽奖时间11:00:00-16:00:00，现在时间17:10:45）
                XPLog(@"明天再来");
                [self showActivityOverflowTip];
            } else if(nowSeconds >= startSeconds && nowSeconds <= endSeconds) { // 现在时间在抽奖时间范围内
                if(model.joinNumber >= model.joinTotal && model.joinTotal!=(-1)) {
                    XPLog(@"显示今日已参加过-底部");
                    [self showActivityTodayJoinedTip];
                } else {
                    //天成添加
//                    XPLog(@"显示分享-顶部");
                    if([model.eligibility isEqualToString:@"N"]){
                        //若不需要分享的
                            //立即摇奖/抽奖/刮奖
                            [self showActivityStartedTip];

                    }else{
                        //若需要分享的
                            //摇奖/抽奖/刮奖
                            [self showActivityShareableAndStartedTip];
                    }
                }
            } else if(nowSeconds < startSeconds) { // 当前时间 < 当日的抽奖时间（可能需要判断600秒外、600秒内、10秒内）
                if(startSeconds-nowSeconds <= 600) {
                    if(startSeconds-nowSeconds <= 10) { // 10秒倒计时（也许一进来就是从7秒开始倒计时）
                        XPLog(@"10秒倒计时");
                        [self showTenSecondCounterTipWithOffset:startSeconds-nowSeconds];
                    } else { // 600秒（10分钟）倒计时（也许只有8分30秒）
                        XPLog(@"10分钟倒计时");
                        [self showTenMinutenCounterTipWithOffset:startSeconds-nowSeconds];
                    }
                } else { // 600秒外
                    XPLog(@"10分钟之外-分享（底部）");
                    //摇奖或抽奖
                    [self showActivityShareableAndNotStartTip];
                }
            }
        }
    }
}


#pragma mark - 整个活动已结束
- (void)showActivityEndTip
{@weakify(self)
    self.activityState = Plain_Activity_End;
    [self.startView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.finishedView) {
        return;
    }
    
    self.finishedView = [XPPlainFinishedView loadFromNib];
    [self.finishedView setFrame:ccr(0, self.view.height-73, self.view.width, 73)];
    [self.view addSubview:self.finishedView];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+73)];

}

#pragma mark - 当日活动已结束
- (void)showActivityOverflowTip
{@weakify(self)
    self.activityState = Plain_Activity_Not_Start;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.overflowFinishedView) {
        return;
    }
    
    self.overflowFinishedView = [XPPlainOverflowFinishedView loadFromNib];
    [self.overflowFinishedView setFrame:ccr(0, self.view.height-113, self.view.width, 113)];
    XPMainPlainModel *model = self.viewModel.model;
    if([model.startDate isEqualToString:model.endDate]) {
        self.overflowFinishedView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@ %@-%@", model.startDate, model.startTime, model.endTime];
    } else {
        self.overflowFinishedView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@~%@ %@-%@", model.startDate, model.endDate, model.startTime, model.endTime];
    }
    
    [self.view addSubview:self.overflowFinishedView];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+113)];

}

#pragma mark - 当日活动已参与
- (void)showActivityTodayJoinedTip
{
    self.activityState = Plain_Activity_Not_Start;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.joinedView) {
        return;
    }
    self.joinedView = [XPPlainJoinedView loadFromNib];
    [self.joinedView setFrame:ccr(0, self.view.height-113, self.view.width, 113)];
    XPMainPlainModel *model = self.viewModel.model;
    if([model.startDate isEqualToString:model.endDate]) {
        self.joinedView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@ %@-%@", model.startDate, model.startTime, model.endTime];
    } else {
        self.joinedView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@~%@ %@-%@", model.startDate, model.endDate, model.startTime, model.endTime];
    }
    @weakify(self);
    [[self.joinedView.popRootButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.checkTimer invalidate];
        self.checkTimer = nil;
        [self popToRoot];
    }];
    [self.view addSubview:self.joinedView];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+113)];

}

#pragma mark - 当前时间离当日活动开始时间或整个活动开始时间超过十分钟
- (void)showActivityShareableAndNotStartTip
{
    self.activityState = Plain_Activity_Not_Start;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    self.isTheNotStartView=YES;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.shareableAndNotStartView) {
        return;
    }
    
    self.shareableAndNotStartView = [XPPlainShareableAndNotStartView loadFromNib];
    [self.shareableAndNotStartView setFrame:ccr(0, self.view.height-113, self.view.width, 113)];
    XPMainPlainModel *model = self.viewModel.model;
    if([model.startDate isEqualToString:model.endDate]) {
        self.shareableAndNotStartView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@ %@-%@", model.startDate, model.startTime, model.endTime];
    } else {
        self.shareableAndNotStartView.activityTimeLabel.text = [NSString stringWithFormat:@"开抢时间 %@~%@ %@-%@", model.startDate, model.endDate, model.startTime, model.endTime];
    }
    
    @weakify(self);
    [[self.shareableAndNotStartView.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self shareButtonTaped];
    }];
    [self.view addSubview:self.shareableAndNotStartView];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+113)];

}

#pragma mark - 当前时间正好在抽奖时间区间，并且可以抽奖（即：joinNumber<joinTotal）
//分享立即摇奖
- (void)showActivityShareableAndStartedTip
{
    self.activityState = Plain_Activity_Started;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.shareableAndStartedView) {
        return;
    }
    
    self.shareableAndStartedView = [XPPlainShareableAndStartedView loadFromNib];
//    if([self.viewModel.model.activityType isEqualToString: @"L"]){
//        self.shareableAndStartedView.textLabel.text = @"分享立即抽奖";
//    }else if([self.viewModel.model.activityType isEqualToString: @"E"]){
//        self.shareableAndStartedView.textLabel.text = @"分享立即摇奖";
//
//    }else if([self.viewModel.model.activityType isEqualToString: @"G"]){
//        self.shareableAndStartedView.textLabel.text = @"分享立即刮奖";
//    }

    [self.shareableAndStartedView setFrame:ccr(0, self.view.height-73, self.view.width, 73)];
    @weakify(self);
    [[self.shareableAndStartedView.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self shareButtonTaped];
    }];
    [self.view addSubview:self.shareableAndStartedView];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+73)];

    
}
//立即摇奖
-(void)showActivityStartedTip
{
    self.activityState = Plain_Activity_Started;
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.startView) {
        return;
    }
    
    self.startView = [XPPlainStartView loadFromNib];
//    if([self.viewModel.model.activityType isEqualToString: @"L"]){
//        self.startView.textLabel.text = @"立即抽奖";
//    }else if([self.viewModel.model.activityType isEqualToString: @"E"]){
//        self.startView.textLabel.text = @"立即摇奖";
//        
//    }else if([self.viewModel.model.activityType isEqualToString: @"G"]){
//        self.startView.textLabel.text = @"立即刮奖";
//    }

    [self.startView setFrame:ccr(0, self.view.height-73, self.view.width, 73)];
    @weakify(self);
    [[self.startView.shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self shareButtonTaped];
    }];
    [self.view addSubview:self.startView];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+73)];
    
}


- (void)showTenMinutenCounterTipWithOffset:(NSInteger)offset
{
    self.activityState = Plain_Activity_Not_Start;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenSecondCounterView removeFromSuperview];
    if(self.tenMinuteCounterView) {
        return;
    }
    
    self.tenMinuteCounterView = [XPPlainTenMinuteCounterView loadFromNib];
    [self.tenMinuteCounterView setFrame:ccr(0, self.view.height-73, self.view.width, 73)];
    [self.view addSubview:self.tenMinuteCounterView];
    [self.tenMinuteCounterView startCounterWithOffset:offset];
    
    @weakify(self);
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight+73)];

}

- (void)showTenSecondCounterTipWithOffset:(NSInteger)offset
{
    self.activityState = Plain_Activity_Not_Start;
    [self.startView removeFromSuperview];
    [self.finishedView removeFromSuperview];
    [self.joinedView removeFromSuperview];
    [self.overflowFinishedView removeFromSuperview];
    [self.shareableAndNotStartView removeFromSuperview];
    self.isTheNotStartView=NO;
    [self.shareableAndStartedView removeFromSuperview];
    [self.tenMinuteCounterView removeFromSuperview];

    if(self.tenSecondCounterView) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.tenSecondCounterView = [XPPlainTenSecondCounterView loadFromNib];
    [self.tenSecondCounterView setFrame:window.bounds];
    [window addSubview:self.tenSecondCounterView];
    [self.tenSecondCounterView startCounterWithOffset:offset];
    
    @weakify(self);
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.trailing.top.leading.bottom.equalTo(self.view);
    }];
}

#pragma mark - 配置活动图片
- (void)configScrollView
{
    [self.scrollView removeAllSubviews];
    offsetHeight = 0;
#define USE_WIDTH_HEIGHT_SUFFIX 1
    for(NSInteger i = 0; i < self.viewModel.model.imageList.count; i++) {
        NSString *imageURL = [self.viewModel.model.imageList[i] objectForKey:@"image"];
        CGFloat imageHeight = self.view.width*0.526;
#if USE_WIDTH_HEIGHT_SUFFIX
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(width=\\d{0,}.\\b|height=\\d{0,}.)" options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *result = [regex matchesInString:imageURL options:0 range:NSMakeRange(0, [imageURL length])];
        if(result && 2 != result.count) {
        } else {
            NSTextCheckingResult *widthResult = result[0];
            NSTextCheckingResult *heightResult = result[1];
            CGFloat realityWidth = [[[[imageURL substringWithRange:widthResult.range] stringByReplacingOccurrencesOfString:@"width=" withString:@""] stringByReplacingOccurrencesOfString:@"&" withString:@""] floatValue];
            CGFloat realityHeight = [[[imageURL substringWithRange:heightResult.range] stringByReplacingOccurrencesOfString:@"height=" withString:@""] floatValue];
            imageHeight = (realityHeight/realityWidth)*self.view.width;
            imageURL = [imageURL componentsSeparatedByString:@"?"][0];
        }
        
#else
        
#endif
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:ccr(0, offsetHeight, self.view.width, imageHeight)];
        [self.scrollView addSubview:imageView];
        RAC(imageView, image) = [[imageURL rac_remote_image] deliverOn:[RACScheduler mainThreadScheduler]];
        offsetHeight += imageView.height;
    }
    [self.scrollView setContentSize:ccs(self.view.width, offsetHeight)];
}
#pragma mark - 配置活动简介
//天成修改
-(void)plainDetailView{
    NSLog(@"活动简介    s%@",self.viewModel.model.activityIntro);
    if(self.viewModel.model.activityIntro.length>0){
        [self.view addSubview:self.IntroductionBtn];
//        self.plainIntroductionView.plainIntroduction=self.viewModel.model.activityIntro;
        self.plainIntroductionedView.plainIntroduction=self.viewModel.model.activityIntro;
        
    }
}
//-(XPPlainIntroductionView*)plainIntroductionView{
//    if(!_plainIntroductionView){
//        CGFloat width=[UIScreen mainScreen].bounds.size.width;
//        _plainIntroductionView=[[XPPlainIntroductionView alloc]initWithFrame:CGRectMake(width-38, 94, ([UIScreen mainScreen].bounds.size.width * 0.8)+2, 126)];
//        _plainIntroductionView.backgroundColor=[UIColor clearColor];
//        [self.view addSubview:_plainIntroductionView];
//        
//        
//    }
//    return _plainIntroductionView;
//}
-(UIButton*)IntroductionBtn{
    if(!_IntroductionBtn){
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
        _IntroductionBtn=[[UIButton alloc]initWithFrame:CGRectMake( width-38,96, 38, 128)];
        [_IntroductionBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [[_IntroductionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            UIView* backBlackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            NSLog(@"%p",backBlackView);
//            backBlackView.backgroundColor=[UIColor colorWithColor:[UIColor blackColor] alpha:0.6];
            [[UIApplication sharedApplication].keyWindow addSubview:backBlackView];
            [backBlackView addSubview:self.plainIntroductionedView];
        }];
        
    }
    return _IntroductionBtn;
}
-(XPPlainIntroductionedView*)plainIntroductionedView{
    if(!_plainIntroductionedView){
       
        
        CGFloat width=[UIScreen mainScreen].bounds.size.width;
        NSLog(@"%f   %f   %f",width,width-27*2,(410.0/320)*(width-27*2)+35);
        _plainIntroductionedView=[[XPPlainIntroductionedView alloc]initWithFrame:CGRectMake(0, 0,width-27*2,(410.0/320)*(width-27*2)+35)];//width-27*2,410/320*(width-27*2)+35)];
        _plainIntroductionedView.center=self.view.center;
//        _plainIntroductionView.backgroundColor=[UIColor clearColor];
        
        
    }
    return _plainIntroductionedView;
}
#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
