//
//  XPMainViewController.m
//  App
//
//  Created by huangxinping on 4/21/15.
//  Copyright (c) 2015 ShareMerge. All rights reserved.
//

#import "XPAutoNIBColor.h"
#import "XPMainViewController.h"
#import "XPSingleton.h"
#import "NSString+XPCaptureAnalyse.h"
#import "UIImage+XPCompress.h"
#import "UIView+XPEmptyData.h"
#import "XPAPIManager+XPPostImage.h"
#import "XPBaseTableViewCell.h"
#import "XPCaptureViewController.h"
#import "XPLoginModel.h"
#import "XPMainHeadTableViewCell.h"
#import "XPMainSignTableViewCell.h"
#import "XPMainModel.h"
#import "XPMainViewController+XPAutoLogin.h"
#import "XPMainViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <XPKit/XPKit.h>
#import "calendarView.h"
#import "RaffleViewController.h"
#import "XPMotionManager.h"
#import <XPWebView.h>
#import "TTCWebViewController.h"

@interface XPMainViewController ()<UITableViewDelegate, UITableViewDataSource,BMKLocationServiceDelegate>
#define kCoinCountKey 20 //金币个数


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMainViewModel *viewModel;

#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XPCaptureViewController *captureViewController;
@property (nonatomic, strong) NSString *captureJoinedGroupId;
@property (nonatomic, strong) calendarView* calendView;

//这是签到的时候后面那层蒙版
@property (nonatomic, strong)UIView* bgView;

@property (nonatomic, strong)XPMainSignInModel* signModel;



@property (nonatomic, strong)NSMutableArray* coinTagsArr;

@property (nonatomic , strong) BMKLocationService *locService ;
@end

@implementation XPMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
//    _locService.distanceFilter = 1;
    [_locService startUserLocationService];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    _locService.delegate = nil;
}
#pragma mark - Life Cycle
- (void)viewDidLoad

{   
    _coinTagsArr = [NSMutableArray array];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    
    [self.tableView hideEmptySeparators];
    @weakify(self);


    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];
    
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            if([XPLoginModel singleton].signIn) {
                self.captureViewController = (XPCaptureViewController *)[self instantiateInitialViewControllerWithStoryboardName:@"Capture"];
                [[self.captureViewController rac_captureOutput] subscribeNext:^(id x) {
                    NSArray *buffer = [x xp_captureAnalyse];
                    if(buffer && 2 == buffer.count) {
                        self.viewModel.fromUserId = buffer[0];
                        self.viewModel.groupId = buffer[1];
                        [self.viewModel.groupJoinCommand execute:nil];
                    }
                }];
                
                [self pushViewController:self.captureViewController];
            } else {
                [self presentLogin];
            }
            
            [subscriber sendNext:@YES];
            [subscriber sendCompleted];
            return nil;
        }] then:^RACSignal *{
            @strongify(self);
            NSLog(@"12");
            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
        }];
    }];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            @strongify(self);
            if([XPLoginModel singleton].signIn) {
                [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Message"]];
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
    
    [[RACObserve(self.viewModel, groupJoinFinished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        self.captureJoinedGroupId = self.viewModel.groupId;
        [self performSegueWithIdentifier:@"embed_group" sender:self];
    }];
    
    [[RACObserve(self.viewModel, finished) ignore:@(NO)] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.viewModel, list) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    //观察单例[XPSingleton shareSingleton]的isSignIn变化
    [RACObserve([XPSingleton shareSingleton], isSignIn ) subscribeNext:^(id x) {
        NSLog(@"%@",x);
        [self.tableView reloadData];
    }];
    [[RACObserve(self, viewModel.signInModel.isContinuous)ignore:nil]subscribeNext:^(NSString* x) {
        if([x isEqualToString:@"Y"]){
            //爆炸效果
                [self getCoinAction];


        }
    }];
    
    [[RACSignal combineLatest:@[[RACObserve(self.viewModel, list) ignore:@(NO)], [RACObserve(self.viewModel, finished) ignore:nil]] reduce:^id (NSArray *list, NSNumber *finishd){
        return @([finishd boolValue] && list.count == 0);
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if([x boolValue]) {
            [self.tableView showEmptyData];
        } else {
            [self.tableView destoryEmptyData];
        }
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.reloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.viewModel.moreCommand execute:nil];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    [[[RACObserve([XPLoginModel singleton], signIn) distinctUntilChanged] skip:1] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.reloadCommand execute:nil];
        [self.tableView.mj_header beginRefreshing];
    }];
    
    [self autoLogin];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    XPMotionManager *Xpmanager = [XPMotionManager sharedInstance];
    Xpmanager.location = userLocation.location;
    
    
}
-(void)closeBtn
{
    UIWindow* window=[UIApplication sharedApplication].keyWindow;
    [[self.bgView viewWithTag:99]removeFromSuperview];
    [[window viewWithTag:100]removeFromSuperview];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:[self.tableView selectedCell]];
    if([segue.identifier isEqualToString:@"embed_group"]) {
        if(self.captureJoinedGroupId) {  // 如果当前是扫描申请加入群组
            [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                x.identifier = _captureJoinedGroupId;;
            }]];
            self.captureJoinedGroupId = nil;
            self.captureViewController = nil;
        } else {
            XPMainModel *model=nil;
            //如果不是当前扫描加入的群组,而是之前的
            //天成修改
            if([XPLoginModel singleton].signIn && [XPSingleton shareSingleton].isSignIn==0){
                model= (XPMainModel *)self.viewModel.list[indexPath.row-2];
            }else{
                model= (XPMainModel *)self.viewModel.list[indexPath.row-1];
            }
            [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                x.identifier = model.groupId;
            }]];

        }
    } else if([segue.identifier isEqualToString:@"embed_plain"]) {
        //这里是当属于获得,不属于群组时,给跳过去的那个controller的model赋值   那个model就是只有  identifier有值,就是一个表示作用
        XPMainModel *model=nil;
        //天成修改
        if([XPLoginModel singleton].signIn && [XPSingleton shareSingleton].isSignIn==0){
            model= (XPMainModel *)self.viewModel.list[indexPath.row-2];
        }else{
            model= (XPMainModel *)self.viewModel.list[indexPath.row-1];
        }
        [(XPBaseViewController *)segue.destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
            x.identifier = model.podiumId;
        }]];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{//天成修改
    if(0 == indexPath.row) {
        return tableView.width/2;
    }else if((1==indexPath.row) && [XPSingleton shareSingleton].isSignIn==0 && [XPLoginModel singleton].signIn){
        //登陆且未签到且是第一行
        return 51;
    }
    
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//天成修改
    NSLog(@"%ld",self.viewModel.isSignIn);
    //已签到
    if(self.viewModel.list){
    if([XPLoginModel singleton].signIn && [XPSingleton shareSingleton].isSignIn==0){
        //登陆且未签到
        return self.viewModel.list.count+2;
    }else{
        return self.viewModel.list.count+1;
    }}else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self)
    XPBaseTableViewCell *cell = nil;
    //天成修改
    if([XPLoginModel singleton].signIn && [XPSingleton shareSingleton].isSignIn==0){
        //登陆且未签到
        if(0 == indexPath.row) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Head" forIndexPath:indexPath];
            //给滚动条上的(牛肉丸和恒大)cell的models赋值
            [(XPMainHeadTableViewCell *)cell configWithBanners:self.viewModel.banners];//banners是XPMainBannerModel类型的数组
        } else if(1==indexPath.row) {
            cell=[tableView dequeueReusableCellWithIdentifier:@"Sign" forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            //天成修改
            XPMainSignTableViewCell* cel=(XPMainSignTableViewCell*)cell;
            cel.signCoinNum=self.viewModel.signCoinNum;
            //签到按钮点击
            [cel.signButton addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            //给cell的model赋值
            [cell bindModel:self.viewModel.list[indexPath.row-2]];
        }
    }else{
        //已签到
        if(0 == indexPath.row) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Head" forIndexPath:indexPath];
            //给滚动条上的(牛肉丸和恒大)cell的models赋值
            [(XPMainHeadTableViewCell *)cell configWithBanners:self.viewModel.banners];//banners是XPMainBannerModel类型的数组
        } else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            //给cell的model赋值
            [cell bindModel:self.viewModel.list[indexPath.row-1]];
        }
    }
    
    return cell;
}
//签到按钮点击
-(void)signBtnClick:(UIButton*)btn{
    if([XPLoginModel singleton].signIn){
        @weakify(self)
        [self.viewModel.signInCommand execute:nil];
        [[RACObserve(self.viewModel, signInModel) ignore:nil]subscribeNext:^(XPMainSignInModel* x) {
            @strongify(self)
            self.viewModel.isSignIn=1;
            [XPSingleton shareSingleton].isSignIn=1;

            NSArray *dateArray = [[NSArray alloc]init];
            dateArray = [x.signDays componentsSeparatedByString:@","];
            NSMutableArray *dateFinishArray =[NSMutableArray array];
            NSMutableArray *lastMonthArray = [NSMutableArray array];
            NSString*lastStr = [dateArray lastObject];
            for (int i = 0; i<dateArray.count; i++) {
                NSString *str= dateArray[i];
                NSString *newStr = [[NSString alloc]init];
                newStr = [str substringFromIndex:8];
                NSNumber *num = [NSNumber numberWithInt:[newStr intValue]+1];
                if ([[str substringWithRange:NSMakeRange(5, 2)]intValue]==[[lastStr substringWithRange:NSMakeRange(5, 2)]intValue]) {
                    [dateFinishArray addObject:num];
                }else
                {
                    [lastMonthArray addObject:num];
                }
            }
            [self createDateCalendar:dateFinishArray With:lastMonthArray];

            [self.tableView reloadData];
        }];
    }else{
        [self presentLogin];
    }
}
/**
 *  日历页面
 */
-(void)createDateCalendar:(NSMutableArray *)dateArray With:(NSMutableArray *)lastMonthArray
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.calendView.backgroundColor = [UIColor whiteColor];
    self.calendView.bounds = CGRectMake(0, 0, size.width - 76, 366);
    
    self.calendView.tag = 99;
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView.backgroundColor = [UIColor colorWithColor:[UIColor blackColor] alpha:0.6];
    self.bgView.tag  = 100;
    [window addSubview:self.bgView];
    [self.bgView addSubview:self.calendView];
    NSLog(@"%@",NSStringFromCGPoint(self.view.center));
    self.calendView.center=self.bgView.center;
    self.calendView.signArray =dateArray;
    self.calendView.model=self.viewModel.signInModel;
    self.calendView.lastMonthSingDaysArr = lastMonthArray;
    self.calendView.date = [NSDate date];
    
    UIImageView *closeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"calendar_delete"]];
    closeImage.frame = CGRectMake(self.calendView.frame.size.width-30, 7, 30, 30);
    [self.calendView addSubview:closeImage];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(self.calendView.frame.size.width-30, 7, 30, 30);
    
    [self.calendView addSubview:closeBtn];

 
    
    NSDateComponents *comp = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    __weak typeof (calendarView )*weekdemo = self.calendView;
    self.calendView.calendarBlock = ^(NSInteger day,NSInteger month,NSInteger year){
        if ([comp day]==day) {
            NSLog(@"%li-%li-%li",year,month,day);
            [weekdemo setStyle_Today_Signed:weekdemo.dayButton];
        }
    };
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTCWebViewController *webv = [[TTCWebViewController alloc]init];
    [self.navigationController pushViewController:webv animated:YES];
//    NSLog(@"%zd",indexPath.row);
//    if(0 == indexPath.row){
//        
//        return;
//    }//天成修改
//    //登陆且未签到
//    if([XPLoginModel singleton].signIn && [XPSingleton shareSingleton].isSignIn==0){
//        
//        if(1 == indexPath.row) {
//            
//            return;
//        }
//        
//        XPMainModel *model = (XPMainModel *)self.viewModel.list[indexPath.row-2];
//        if(1 == model.noticeTag) {  // 群组
//            if([XPLoginModel singleton].signIn) {
//                [self performSegueWithIdentifier:@"embed_group" sender:self];
//            } else {
//                [self presentLogin];
//            }
//        } else {//不是群组
//            [self performSegueWithIdentifier:@"embed_plain" sender:self];
//        }
//        
//        
//    }else {
//        XPMainModel *model = (XPMainModel *)self.viewModel.list[indexPath.row-1];
//        if(1 == model.noticeTag) {  // 群组
//            if([XPLoginModel singleton].signIn) {
//                [self performSegueWithIdentifier:@"embed_group" sender:self];
//            } else {
//                [self presentLogin];
//            }
//        } else {//不是群组
//            [self performSegueWithIdentifier:@"embed_plain" sender:self];
//        }
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - coinAnimation
/**
 *  金币爆炸效果
 */
static int coinCount = 0;
-(void)getCoinAction
{
    coinCount = 0;
    for (int i = 0; i<kCoinCountKey; i++) {
        [self performSelector:@selector(initCoinViewWithInt:) withObject:[NSNumber numberWithInt:i]afterDelay:i*0.01];
    }
    
}
-(void)initCoinViewWithInt:(NSNumber *)i
{
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"money_coin"]];
    coin.center = CGPointMake(CGRectGetMidX(self.view.frame)+arc4random()%40*(arc4random()%3-1), CGRectGetMidY(self.view.frame)+20);
    coin.tag = [i intValue] + 999;
    [_coinTagsArr addObject:[NSNumber numberWithInteger:coin.tag]];
    
    [self.bgView addSubview:coin];
    [self setAnimationWithLayer:coin];
}
-(void)setAnimationWithLayer:(UIView *)coin
{
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"金币音效.mp3" withExtension:nil];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlayAlertSound(soundID);
    
    CGFloat duration = 1.0f;
    CGFloat positionX = coin.layer.position.x;
    CGFloat positionY = coin.layer.position.y;
    CGMutablePathRef path = CGPathCreateMutable();
    int formX = arc4random() % 320;
    int height = [UIScreen mainScreen].bounds.size.height -200- coin.frame.size.height;
    int formY  = arc4random() % (int)positionY;
    CGFloat cpx = positionX + (formX - positionX)/2;
    CGFloat cpy = formY / 2 - positionY;
    
    CGPathMoveToPoint(path, NULL, positionX, positionY);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy+400, formX, height);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path];
    CFRelease(path);
    path = nil;
    
    CGFloat from3DScale = 1 + arc4random() % 10 *0.1;
    CGFloat to3DScale = from3DScale * 0.5;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
    scaleAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[scaleAnimation,animation];
    [coin.layer addAnimation:group forKey:@"position and transform"];
}
//动画结束代理   动画结束时调用
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
   
   if (flag) {
       
        UIView *coinView = (UIView *)[self.bgView viewWithTag:[[self.coinTagsArr firstObject]intValue]];
        [coinView removeFromSuperview];
        [self.coinTagsArr removeObjectAtIndex:0];
       UIImageView *backImageCoinView = [[UIImageView alloc]init];
       backImageCoinView.image = [UIImage imageNamed:@"calander_bigbong"];
       backImageCoinView.frame =self.view.frame;
       backImageCoinView.tag = 888;
       [self.bgView addSubview:backImageCoinView];
       [self performSelector:@selector(removeCoinImage) withObject:nil afterDelay:1];
    }
}
-(void)removeCoinImage
{
    
    UIView *view = (UIView *)[self.bgView viewWithTag:888];
    [view removeFromSuperview];
}

-(UIView*)bgView{
    if(!_bgView){
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _bgView=[[UIView alloc]initWithFrame:window.bounds];
    }
    return _bgView;
}
-(calendarView*)calendView{
    if(!_calendView){
        _calendView=[[calendarView alloc]init];
    }
    return _calendView;
}
#pragma mark - Event Response

#pragma mark - Private Methods

#pragma mark - Getters & Setters

@end
