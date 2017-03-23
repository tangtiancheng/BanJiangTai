//
//  XPMeViewController.m
//  XPApp
//
//  Created by huangxinping on 15/10/17.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPLoginModel.h"
#import "XPMeViewController.h"
#import "XPMeViewModel.h"
#import "XPProfileView.h"
#import <XPKit/XPKit.h>
#import "XPMainSignTableViewCell.h"
#import "XPSingleton.h"
#import "calendarView.h"

@interface XPMeViewController ()<UITableViewDelegate, UITableViewDataSource>
#define kCoinCountKey 20 //金币个数

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (strong, nonatomic) IBOutlet XPMeViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet XPProfileView *profileView;
@property (nonatomic, strong) calendarView* calendView;
@property (nonatomic, strong)NSMutableArray* coinTagsArr;

//签到后后面的那层蒙版
@property (nonatomic, strong)UIView* bgView;


//@property (nonatomic, strong)XPMainSignInModel* signModel;

@end

@implementation XPMeViewController



#pragma mark - LifeCircle
-(void)dealloc{
    NSLog(@"xiaohuile");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    @property NSString *signDays;//签到日期
    //    @property NSString *isContinuous;//是否达到要求的连续签到日期
    //    @property NSString *dayGolds;//每日签到获得的金币数
    //    @property NSString *continuousTotalDays;//要求要达到的连续签到天数
    //    @property NSString *continuousDays;//已经连续签到的天数
    //    @property NSString *continuousGolds;//达到连续签到的天数的额外给的金币数
    
    
//    self.signModel=[[XPMainSignInModel alloc]init];
    
  
    
    
    
    
    
      _coinTagsArr = [NSMutableArray array];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
    [self.profileView bindViewModel:self.viewModel];
    
    //观察单例[XPSingleton shareSingleton]的isSignIn变化
    [RACObserve([XPSingleton shareSingleton], isSignIn) subscribeNext:^(id x) {
        //刷新tableView
        [self.tableView reloadData];
    }];
    [[RACObserve(self,viewModel.signInModel.isContinuous)ignore:nil]subscribeNext:^(NSString* x) {
        if([x isEqualToString:@"Y"]){
            //爆炸效果
            [self getCoinAction];
        }
    }];

}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section) {
        return 1;
    }else if(1 == section){
        return 3;
    }
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section==0){
        cell=[tableView dequeueReusableCellWithIdentifier:@"Sign" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //天成修改
        XPMainSignTableViewCell* cel=(XPMainSignTableViewCell*)cell;
        
        cel.signCoinNum=[XPSingleton shareSingleton].signCoinNum;
        cel.signButton.enabled=YES;
        cel.signButton.layer.borderColor=[UIColor redColor].CGColor;
//        cel.signButton.text=[NSString stringWithFormat:@""]
        NSLog(@"%ld",(long)[XPSingleton shareSingleton].isSignIn);
        if([XPSingleton shareSingleton].isSignIn==1){
            cel.signButton.enabled=NO;
            cel.signButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
            
                XPSingleton* singleton=[XPSingleton shareSingleton];
            NSInteger remainDayNum;
            if([singleton.continuousTotalDays integerValue]>[singleton.continuousDays integerValue]){
                remainDayNum=[singleton.continuousTotalDays integerValue]-[singleton.continuousDays integerValue];
            }else{
                remainDayNum=[singleton.continuousTotalDays integerValue]-([singleton.continuousDays integerValue]%[singleton.continuousTotalDays integerValue]);
            }
                cel.goldsLabel.text=[NSString stringWithFormat: @"您已连续签到%@天,差%ld天获得额外奖励",singleton.continuousDays,remainDayNum];
        }
        
        //签到按钮点击
        [cel.signButton addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld_%ld", (long)indexPath.section-1, (long)indexPath.row] forIndexPath:indexPath];
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

-(void)closeBtn
{
    UIWindow* window=[UIApplication sharedApplication].keyWindow;
    [[self.bgView viewWithTag:99]removeFromSuperview];
    [[window viewWithTag:101]removeFromSuperview];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch(indexPath.section) {
        case 0:{
        }
            break;
        case 1: {
            switch(indexPath.row) {
                case 0: { // 参与的活动
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Activity"];
                }
                    break;
                    
                case 1: { // 我的奖品
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Award"];
                }
                    break;
                    
                case 2: { // 我的奖金币
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Points"];
                }
                    break;
                    
                default: {
                }
                    break;
            }
        }
            break;
            
        case 2: {
            switch(indexPath.row) {
                case 0: { // 我的发奖
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Gift"];
                }
                    break;
                    
                case 1: { // 邀请
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Invite"];
                }
                    break;
                    
                case 2: { // 帮助
                    [self checkLoginAndPushViewControllerWithStoryboardName:@"Help"];
                }
                    break;
                    
                case 3: { // 设置
                    [self pushViewController:[self instantiateInitialViewControllerWithStoryboardName:@"Setting"]];
                }
                    
                    break;
                    
                default: {
                }
                    break;
            }
        }
            break;
            
        default: {
        }
            break;
    }
}
/**
 *  日历页面
 */
-(void)createDateCalendar:(NSMutableArray *)dateArray With:(NSMutableArray *)lastMonthArray
{
    NSLog(@"日历界面日历界面日历界面日历界面日历界面日历界面日历界面日历界面");
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    self.calendView.backgroundColor = [UIColor whiteColor];
    self.calendView.bounds = CGRectMake(0, 0, size.width - 76, 366);
    
    self.calendView.tag = 99;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView.backgroundColor = [UIColor colorWithColor:[UIColor blackColor] alpha:0.6];
    self.bgView.tag  = 101;
    [window addSubview:self.bgView];
    [self.bgView addSubview:self.calendView];
    NSLog(@"%@",NSStringFromCGPoint(self.view.center));
    self.calendView.center=self.bgView.center;
    //        [calendarV mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.centerX.mas_equalTo(bgview.mas_centerX);
    //            make.centerY.mas_equalTo(bgview.mas_centerY);
    //            }];
    //    NSMutableArray *_signArray = [[NSMutableArray alloc]init];
    //    [_signArray addObject:[NSNumber numberWithInt:2]];
    //    [_signArray addObject:[NSNumber numberWithInt:6]];
    //    [_signArray addObject:[NSNumber numberWithInt:10]];
    //
    
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
@end
