//
//  RaffleViewController.m
//  XPApp
//
//  Created by Pua on 16/3/24.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "RaffleViewController.h"
#import "handWaveLayer.h"
#import "RaffleViewModel.h"
#import "XPWebView.h"
#import "XPLoginModel.h"

@interface RaffleViewController ()<UIWebViewDelegate>

{
 
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroupHand;
    CADisplayLink *_disPlayLink;
    UIImageView *boxImage;
    UIImageView *handImage;
    CALayer     *layer;
    UIImageView *underBackImageView;
    UIButton *btn;
    UIImageView *waveimage;
    UIImageView *backImage;
    NSInteger time;
    UIButton *howCoinBtn ;
}
@property (nonatomic , strong) UIBezierPath *path;
@property (nonatomic, strong) handWaveLayer *halo;
@property (nonatomic , strong) RaffleViewModel *Viewmodel;

@property (nonatomic, strong)UILabel* textLabel;
@property (nonatomic, strong)UILabel* coinLabel;
@property (nonatomic, strong)UILabel* textLabel2;
@property (nonatomic, strong)UILabel* timeLabel;
@property (nonatomic, strong)UILabel* textGeLabel;
//本活动每日限抽次数那个黑条条
@property (nonatomic , strong)UILabel *showNumOfRaffle;
@property (nonatomic, strong)UIImageView* nineNineNineAddImageView;
@property (nonatomic, strong)UIImageView* nineNineNineAddImageViewSecond;
//+1label
@property (nonatomic, strong)UILabel* addOneLabel;


//右边灰色的参与活动总次数
@property (nonatomic, strong)UILabel* numLabel;



#define angelToRandian(x) ((x)/180.0*M_PI)

@end

@implementation RaffleViewController
-(void)dealloc{
    NSLog(@"xiaohuile");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    self.showNumOfRaffle = [[UILabel alloc]init];
    self.showNumOfRaffle .hidden=YES;
//    UIButton* rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.Viewmodel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.Viewmodel, error) ignore:nil] map:^id (id value) {
        
        return value;
    }], nil];
  
    
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"raffle_rules_btn"] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
//    rightBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        return [[RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
//            NSLog(@"nini");
//            @strongify(self);
//            if([XPLoginModel singleton].signIn) {
//                [self enterTheH5HowToGetGold];
//            } else {
//                [self presentLogin];
//            }
//            
//            [subscriber sendNext:@YES];
//            [subscriber sendCompleted];
//            return nil;
//        }] then:^RACSignal *{
//            @strongify(self);
//            return [[self rac_signalForSelector:@selector(viewDidAppear:)] take:1];
//        }];
//    }];

    
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
    self.title=self.model.identifier;
    self.navigationItem.backBarButtonItem.width = 20;
    self.view.backgroundColor = [UIColor whiteColor];
    self.Viewmodel.podiumId = [(NSArray *)self.model.baseTransfer objectAtIndex:0];
    self.Viewmodel.joinNumber = [[(NSArray *)self.model.baseTransfer objectAtIndex:2] integerValue];
    NSLog(@"%ld",self.Viewmodel.joinNumber);
    
    
    [self.Viewmodel.raffleNumCommand execute:nil];
    
    [[[self.Viewmodel.raffleCommand executionSignals] concat] subscribeNext:^(id x) {
        @strongify(self);
        
        [self showSuccess];
    }];
    [[RACObserve(self, Viewmodel.raffleNumModel.remainPoint)ignore:nil] subscribeNext:^(NSString* x) {
        @strongify(self)
        //当抽奖所需金币为0时:
        if(self.Viewmodel.raffleNumModel.exchangePoint == 0){
                
            self.coinLabel.hidden=NO;
            self.textLabel2.hidden=NO;
            self.timeLabel.hidden=NO;
            self.textGeLabel.hidden=NO;
            [howCoinBtn addTarget:self action:@selector(enterTheH5HowToGetGold) forControlEvents:UIControlEventTouchUpInside];
            
            if([x integerValue]>999){
                self.coinLabel.text=[NSString stringWithFormat:@" 999  "];
                self.nineNineNineAddImageView.hidden=NO;
            }else{
                self.coinLabel.text = [NSString stringWithFormat:@" %@ ",x];
                self.nineNineNineAddImageView.hidden=YES;
            }
                //活动可以参与的次数为无限次时
                if(self.Viewmodel.raffleNumModel.activeJoinNum == -1){
                    self.textLabel2.text=@"个";
                    self.timeLabel.hidden = YES;
                    self.nineNineNineAddImageViewSecond.hidden=YES;
                    self.textGeLabel.hidden=YES;
                }else{
                //活动可以参与的次数为有限次时
                self.textLabel2.text=@"个,可抽奖";
//                NSInteger timeNum=[x integerValue]/self.Viewmodel.raffleNumModel.exchangePoint;
                    NSInteger timeNum = self.Viewmodel.raffleNumModel.activeJoinNum-self.Viewmodel.raffleNumModel.todayActiveNum;
                if(timeNum>999){
                    self.timeLabel.text=@" 999  ";
                    self.nineNineNineAddImageViewSecond.hidden=NO;
                }else{
                    self.timeLabel.text=[NSString stringWithFormat:@" %ld ",timeNum];
                    self.nineNineNineAddImageViewSecond.hidden=YES;
                }
                self.textGeLabel.text=@"次";
                [howCoinBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                }
            
        }else{
            //当抽奖所需金币不为0时
        
        self.coinLabel.hidden=NO;
        self.textLabel2.hidden=NO;
        self.timeLabel.hidden=NO;
        self.textGeLabel.hidden=NO;
        [howCoinBtn addTarget:self action:@selector(enterTheH5HowToGetGold) forControlEvents:UIControlEventTouchUpInside];

        if([x integerValue]>999){
            self.coinLabel.text=[NSString stringWithFormat:@" 999  "];
            self.nineNineNineAddImageView.hidden=NO;
        }else{
            self.coinLabel.text = [NSString stringWithFormat:@" %@ ",x];
            self.nineNineNineAddImageView.hidden=YES;
        }
        if([x integerValue]>=self.Viewmodel.raffleNumModel.exchangePoint){
            self.textLabel2.text=@"个,可抽奖";
            NSInteger timeNum=[x integerValue]/self.Viewmodel.raffleNumModel.exchangePoint;
            if(timeNum>999){
                self.timeLabel.text=@" 999  ";
                self.nineNineNineAddImageViewSecond.hidden=NO;
            }else{
                self.timeLabel.text=[NSString stringWithFormat:@" %ld ",timeNum];
                self.nineNineNineAddImageViewSecond.hidden=YES;
            }

            
            
            self.textGeLabel.text=@"次";
            [howCoinBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            NSLog(@"%@",x);
             [howCoinBtn setBackgroundImage:[UIImage imageNamed:@"raffle_hou_nocoin"] forState:UIControlStateNormal];
            if([x integerValue]==0){
                self.textLabel.text=@"你没有奖金币,不能进行抽奖";
                self.coinLabel.hidden=YES;
                self.textLabel2.hidden=YES;
                self.timeLabel.hidden=YES;
                self.textGeLabel.hidden=YES;
            }else{
            self.nineNineNineAddImageViewSecond.hidden=YES;
            self.textLabel2.text=@"个,还差";
            self.timeLabel.text= [NSString stringWithFormat:@" %ld " ,self.Viewmodel.raffleNumModel.exchangePoint-[x integerValue]];
                       NSLog(@" %@ ",self.timeLabel.text);
            self.textGeLabel.text=@"个即可抽奖";
            }
        }
        }
    }];
    RAC(self.showNumOfRaffle,text)=[[[RACObserve(self, Viewmodel.raffleNumModel.activeJoinNum) ignore:nil]map:^id(id value) {
        if([value integerValue]==-1){
            @strongify(self)
            self.showNumOfRaffle.hidden=YES;
        }else{
            @strongify(self)
            self.showNumOfRaffle.hidden=NO;
        }
        
        return [NSString stringWithFormat:@"本活动每日限抽%@次", value];
    }] startWith:@"0"];

    /**
     * 抽奖触发
     */
    [self createBackImage];
    [self createCoinAndTimeUI];
}
-(void)enterTheH5HowToGetGold{

        @weakify(self)
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
            @strongify(self)
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                //                x.identifier = self.viewModel.ruleURL;
                
                x.identifier=self.Viewmodel.raffleNumModel.pointsRule;
                x.baseTransfer = @"奖金币规则";
            }];
        }]];
}
/**
 *  创建动画效果
 */
-(void)createBackImage
{
    /**
     背景图片
     */
    backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"raffle_backImage"];
    backImage.frame = self.view.frame;
    [self.view addSubview:backImage];
    UIImageView *lightImage = [[UIImageView alloc]init];
    lightImage.image = [UIImage imageNamed:@"raffle_brilliant_image"];
    lightImage.layer.cornerRadius = 6;
    [backImage addSubview:lightImage];
    [lightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImage).with.offset(74);
        make.left.equalTo(backImage).with.offset(31);
        make.right.equalTo(backImage).with.offset(-31);
//        make.centerX.mas_equalTo(backImage.mas_centerX);
//        make.height.mas_equalTo(340);

    }];
    backImage.userInteractionEnabled = YES;
    lightImage.userInteractionEnabled = YES;
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *numImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"raffle_num_image"]];
    [lightImage addSubview:numImageView];
    [numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lightImage).with.offset(-1);
        make.bottom.equalTo(lightImage).with.offset(-40);
    }];
    self.numLabel = [[UILabel alloc]init];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:12];
    RAC(self.numLabel,text)=[[[RACObserve(self, Viewmodel.raffleNumModel.totalActiveNum)ignore:nil]map:^id(NSString* value) {
        return [NSString stringWithFormat:@"共%@次",value];
    }]startWith:@"0"];
   //+1按钮
    self.addOneLabel=[[UILabel alloc]init];
    self.addOneLabel.text=@"+1";
    self.addOneLabel.textColor=[UIColor redColor];
    self.addOneLabel.backgroundColor=[UIColor clearColor];
    self.addOneLabel.alpha=0;
    
    [lightImage addSubview:self.addOneLabel];
    
    
    [numImageView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(numImageView);
        make.bottom.mas_equalTo(numImageView);
        make.top.mas_equalTo(numImageView);
        
    }];
    [self.addOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lightImage).with.offset(-10);
        make.bottom.mas_equalTo(numImageView.mas_top);
    }];
    
    /**
     *  动画
     */
    boxImage = [[UIImageView alloc]init];
    boxImage.image = [UIImage imageNamed:@"raffle_box_btn"];
    [lightImage addSubview:boxImage];
    [boxImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(lightImage).with.offset(164);
        make.centerX.mas_equalTo(lightImage.centerX);
    }];
       handImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"raffle_finger"]];
    [lightImage addSubview:handImage];
    [handImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(lightImage.mas_centerX).with.offset(12);
        make.top.mas_equalTo(268);
    }];
    [boxImage addSubview:btn];
    boxImage.userInteractionEnabled = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(boxImage);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(140);
    }];
    /**
     限制次数
     */
    
    self.showNumOfRaffle.backgroundColor = [UIColor blackColor];
    self.showNumOfRaffle.alpha = 0.7;
    self.showNumOfRaffle.textAlignment=NSTextAlignmentCenter;
    self.showNumOfRaffle.font=[UIFont systemFontOfSize:14];
   
    self.showNumOfRaffle.text=@"本活动每日限抽3次";
//    _showNumOfRaffle.clipsToBounds = YES;
    self.showNumOfRaffle.layer.masksToBounds=YES;
    
//    _showNumOfRaffle.layer.cornerRadius = 4;
    self.showNumOfRaffle.textColor = [UIColor whiteColor];

    [lightImage addSubview:self.showNumOfRaffle];
    [self.showNumOfRaffle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lightImage).with.offset(1);
        make.right.equalTo(lightImage).with.offset(-1);
        make.bottom.equalTo(lightImage.mas_bottom).with.offset(-2);
        make.height.mas_equalTo(20);
    }];
    /**
     *  下半部分
     */
    underBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"raffle_under_image"]];
    [backImage addSubview:underBackImageView];
    [underBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lightImage.mas_bottom).with.offset(5);
//        make.centerX.mas_equalTo(backImage.mas_centerX);
        make.left.equalTo(backImage).with.offset(31);
        make.right.equalTo(backImage).with.offset(-31);
//        make.height.mas_equalTo(60);
    }];
    howCoinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [howCoinBtn setImage:[UIImage imageNamed:@"raffle_how_coin"] forState:UIControlStateNormal];
    [backImage addSubview:howCoinBtn];
    [howCoinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(underBackImageView.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(backImage.mas_centerX);
    }];
    
    [howCoinBtn layoutIfNeeded];
    UIWebView *ruleWebView = [[UIWebView alloc]init];
    [ruleWebView setBackgroundColor:[UIColor clearColor]];
    [ruleWebView setOpaque:NO];

    ruleWebView.frame = CGRectMake(0, howCoinBtn.frame.origin.y+howCoinBtn.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-howCoinBtn.frame.origin.y-howCoinBtn.frame.size.height);
//    ruleWebView.delegate = self;
    ruleWebView.scalesPageToFit = YES;
    NSString *str = [[NSString alloc]init];
    @weakify(str);
    [[RACObserve(self, Viewmodel.raffleNumModel.activeRuleUrl)ignore:nil]subscribeNext:^(id x) {
        @strongify(str);
        str =x;
        NSString *UrlStr = [NSString stringWithFormat:@"%@?activityId=%@",str,self.Viewmodel.podiumId];
        NSURL *url = [[NSURL alloc]initWithString:UrlStr];
        [ruleWebView loadRequest:[NSURLRequest requestWithURL:url]];
        //        NSData *data = [NSData dataWithContentsOfURL:url];

//        [ruleWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];

    }];
    [backImage addSubview:ruleWebView];

    /**
     *  曲线
     */
      self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(300, 120)];
    
    /**
     *  画二元曲线，一般和moveToPoint配合使用
     *
     *  @param endPoint     曲线的终点 - 箱子按钮的坐标
     *  @param controlPoint 画曲线的基准点
     */
    [self.path addQuadCurveToPoint:CGPointMake(180, 250) controlPoint:CGPointMake(200, 100)];
    [self handAnimation];
}
-(void)createCoinAndTimeUI
{
    
    self.textLabel = [[UILabel alloc]init];
    NSLog(@"%@", [[UIDevice currentDevice] systemVersion]);
    self.textLabel.font=[UIFont systemFontOfSize:14];
    self.textLabel.text = @"您有奖金币";
    self.textLabel.textColor = RGBA(220, 105, 95,1);
    [underBackImageView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(underBackImageView).with.offset(0);
        make.top.equalTo(underBackImageView).with.offset(20);
    }];
    self.coinLabel = [[UILabel alloc]init];
    self.coinLabel.font=[UIFont systemFontOfSize:14];
    self.coinLabel.backgroundColor = RGBA(254, 111, 98, 1);
    self.coinLabel.textColor = RGBA(222, 255, 67, 1);
    self.coinLabel.font = [UIFont systemFontOfSize:20];
    self.coinLabel.layer.cornerRadius = 6;
    self.coinLabel.clipsToBounds = YES;
    [underBackImageView addSubview:self.coinLabel];
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).with.offset(2);
        make.top.equalTo(underBackImageView).with.offset(16);
    }];
    self.nineNineNineAddImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nineNineNine"]];
    [self.coinLabel addSubview:self.nineNineNineAddImageView];
    [self.nineNineNineAddImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coinLabel.mas_left);
//        make.right.mas_equalTo(self.coinLabel.mas_right);
        make.top.mas_equalTo(self.coinLabel.mas_top);
//        make.bottom.mas_equalTo(self.coinLabel.mas_bottom);
    }];
    
    self.textLabel2 = [[UILabel alloc]init];
    self.textLabel2.font=[UIFont systemFontOfSize:14];
    self.textLabel2.text = @"个,可抽奖";
    self.textLabel2.textColor = RGBA(220, 105, 95,1);
    
    [underBackImageView addSubview:self.textLabel2];
    [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinLabel.mas_right).with.offset(2);
        make.top.equalTo(underBackImageView).with.offset(20);

    }];
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font=[UIFont systemFontOfSize:14];
    self.timeLabel.backgroundColor = RGBA(254, 111, 98, 1);
    self.timeLabel.textColor = RGBA(222, 255, 67, 1);
    self.timeLabel.font = [UIFont systemFontOfSize:20];
    self.timeLabel.layer.cornerRadius = 6;
    self.timeLabel.clipsToBounds=YES;
    [underBackImageView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel2.mas_right).with.offset(2);
        make.top.equalTo(underBackImageView).with.offset(16);
    }];
    
    self.nineNineNineAddImageViewSecond = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nineNineNine"]];
    [self.timeLabel addSubview:self.nineNineNineAddImageViewSecond];
    [self.nineNineNineAddImageViewSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_left);
        //        make.right.mas_equalTo(self.coinLabel.mas_right);
        make.top.mas_equalTo(self.timeLabel.mas_top);
        //        make.bottom.mas_equalTo(self.coinLabel.mas_bottom);
    }];

    self.textGeLabel = [[UILabel alloc]init];
    
    self.textGeLabel.font=[UIFont systemFontOfSize:14];
    self.textGeLabel.text = @"次";
    self.textGeLabel.textColor = RGBA(220, 105, 95,1);
    
    [underBackImageView addSubview:self.textGeLabel];
    
    [self.textGeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).with.offset(2);
        make.top.equalTo(underBackImageView).with.offset(20);
        make.right.equalTo(underBackImageView.mas_right);
    }];

 

}
-(void)startAnimation
{
//  @weakify(self)
    
    //若次数足够且金币足够,就做那个+1动画
    if((self.Viewmodel.raffleNumModel.activeJoinNum > self.Viewmodel.raffleNumModel.todayActiveNum || self.Viewmodel.raffleNumModel.activeJoinNum ==(-1)) && self.Viewmodel.raffleNumModel.remainPoint >= self.Viewmodel.raffleNumModel.exchangePoint){
    self.addOneLabel.alpha=1;
    [UIView animateWithDuration:1 animations:^{
        self.addOneLabel.transform=CGAffineTransformMakeTranslation(0, -30);
        self.addOneLabel.alpha=0;
    } completion:^(BOOL finished) {
        self.addOneLabel.transform=CGAffineTransformIdentity;
        
    }];
    }else{
        [self showTips];
        return;
    }
    
    if (!layer) {
        btn.enabled = NO;
        layer = [CALayer layer];
        layer.contents = (__bridge id)[UIImage imageNamed:@"raffle_lotteries"].CGImage;
        layer.contentsGravity = kCAGravityResizeAspectFill;
        layer.bounds = CGRectMake(0, 0, 200,100);
        layer.masksToBounds = YES;
        layer.position = CGPointMake(50, 150);
//                layer.transform = CATransform3DMakeRotation(M_PI,0,0,1);
        [self.view.layer addSublayer:layer];
    }
    [self groupAnimation];
   
}
-(void)groupAnimation
{
    btn.enabled=NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    
    CABasicAnimation *smallAnimation = [CABasicAnimation animation];
    smallAnimation.keyPath = @"transform.scale";
    smallAnimation.beginTime = 0.3;
    smallAnimation.duration = 1.5f;
    smallAnimation.toValue = [NSNumber numberWithInt:0.5f];
    smallAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation,smallAnimation];
    groupAnimation.duration = 1.0f;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode =kCAFillModeForwards;
    groupAnimation.delegate = self;
    [layer addAnimation:groupAnimation forKey:@"group"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [layer animationForKey:@"group"]) {
        
        
        [layer removeFromSuperlayer];
        layer = nil;
        CAKeyframeAnimation* anima=[CAKeyframeAnimation animation];
        anima.keyPath=@"transform.rotation";
        anima.values=@[@(angelToRandian(-7)),@(angelToRandian(7)),@(angelToRandian(-7))];
        anima.repeatCount=2;
        anima.duration=0.2;
        anima.timeOffset = 1;
        anima.delegate = self;
        [boxImage.layer addAnimation:anima forKey:@"boxshake"];
        [self performSelector:@selector(showTips) withObject:nil afterDelay:1];
    }

    
}
-(void)showTips{
    
    if(self.Viewmodel.raffleNumModel.activeJoinNum <= self.Viewmodel.raffleNumModel.todayActiveNum && self.Viewmodel.raffleNumModel.activeJoinNum!=(-1)) {
        // 当前活动参与次数已经达到允许的次数
        [self showNoTimes];
    } else {//当前还有参与活动次数
        if(self.Viewmodel.raffleNumModel.remainPoint >= (self.Viewmodel.raffleNumModel.exchangePoint)){
            //若当前剩余金币够
            //把参加的次数加上1
            self.Viewmodel.raffleNumModel.totalActiveNum+=1;
            self.Viewmodel.raffleNumModel.todayActiveNum+=1;
            //把金币减掉
            self.Viewmodel.raffleNumModel.remainPoint -= self.Viewmodel.raffleNumModel.exchangePoint;
           
            [self.Viewmodel.raffleCommand execute:nil];
        }else {
            //若当前剩余金币不够
            [self showCoinNotEnough];
        }
    }

}
-(void)handAnimation
{
    self.halo = [handWaveLayer layer];
    self.halo.position = handImage.center;
    self.halo.backgroundColor = [UIColor yellowColor].CGColor;
    waveimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"raffle_light"]];
    [boxImage addSubview:waveimage];
    [self.view.layer insertSublayer:self.halo below:waveimage.layer];
    [waveimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(40);
    }];
        self.halo.frame = CGRectMake(waveimage.width/6,waveimage.height/6, 100,100);
    self.halo.cornerRadius = 50;
        [waveimage.layer addSublayer:self.halo];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    [handImage.layer addAnimation:scaleAnimation forKey:@"transform.scale"];
}
- (void)removeLayer
{
    [self.halo removeFromSuperlayer];
    [waveimage removeFromSuperview];
    [handImage removeFromSuperview];

}
-(void)showSuccess
{
    @weakify(self);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIView *backimageView = [[UIView alloc]init];
    backimageView.frame = self.view.bounds;
    backimageView.backgroundColor = [UIColor blackColor];
    backimageView.alpha = 0.5;
    [window addSubview:backimageView];
    
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor whiteColor];
    showView.frame = CGRectMake(28, (self.view.height-200)/2, self.view.frame.size.width-56, 200);
    showView.layer.cornerRadius = 10;
    [window addSubview:showView];
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"show_success_icon"]];
    [showView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showView).with.offset(78);
        make.top.equalTo(showView).with.offset(10);
    }];
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"参与成功！";
    tipLabel.font = [UIFont systemFontOfSize:15];
    [showView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(20);
        make.top.equalTo(showView).with.offset(28);
    }];
    UILabel *textWordLabel = [[UILabel alloc]init];
    textWordLabel.numberOfLines = 0;
    textWordLabel.textColor = RGBA(117, 117, 117, 1);
    textWordLabel.font = [UIFont systemFontOfSize:14];
    [[RACObserve(self, Viewmodel.raffleNumModel)ignore:nil]subscribeNext:^(id x) {
        @strongify(self)
        NSString *stringg = [[NSString alloc]init];
        stringg = [self.Viewmodel.raffleModel.publishTime substringToIndex:12];
        textWordLabel.text = [NSString stringWithFormat:@"请在'开奖公告'处准时关注开奖结果.\n本次活动开奖时间为：\n%@",stringg];
    }];
    [showView addSubview:textWordLabel];
    [textWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showView).with.offset(18);
        make.top.equalTo(iconImageView.mas_bottom).with.offset(10);
        make.right.equalTo(showView).with.offset(-18);
    }];
    UIButton *continieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continieBtn setImage:[UIImage imageNamed:@"show_success_continie"] forState:UIControlStateNormal];
    [showView addSubview:continieBtn];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"show_success_back"] forState:UIControlStateNormal];
    [showView addSubview:backBtn];
    [continieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showView).with.offset(18);
        
        make.top.equalTo(textWordLabel.mas_bottom).with.offset(16);
        make.right.equalTo(backBtn.mas_left).with.offset(-10);
        make.width.equalTo(backBtn);
    }];

    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(continieBtn.mas_right).with.offset(10);
        make.top.equalTo(textWordLabel.mas_bottom).with.offset(16);
        make.right.equalTo(showView).with.offset(-18);
        make.width.equalTo(continieBtn);

    }];
    [[continieBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [showView removeFromSuperview];
        [backimageView removeFromSuperview];
    }];
  
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [backimageView removeFromSuperview];
        [showView removeFromSuperview];
        @strongify(self);
        [self popToRoot];
    }];
    [backimageView whenTapped:^{
        @strongify(self)
        [showView removeFromSuperview];
        [backimageView removeFromSuperview];
    }];
    //让按钮的enable=YES;
    
    btn.enabled=YES;
}
/**
 *  没次数了
 */
-(void)showNoTimes
{
    @weakify(self);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIView *backimageView = [[UIView alloc]init];
    backimageView.frame = self.view.bounds;
    backimageView.backgroundColor = [UIColor blackColor];
    backimageView.alpha = 0.5;
    [window addSubview:backimageView];
    
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor whiteColor];
   showView.frame = CGRectMake(28, (self.view.height-200)/2, self.view.frame.size.width-56, 200);    showView.layer.cornerRadius = 10;
    [window addSubview:showView];
    UIView* bgView=[[UIView alloc]init];
    [showView addSubview:bgView];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"show_noTime_icon"]];
    [bgView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(bgView).with.offset(0);
        make.bottom.equalTo(bgView).with.offset(0);
    }];
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"限制次数用完";
    tipLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(20);
        make.top.equalTo(bgView).with.offset(0);
        make.bottom.equalTo(bgView).with.offset(0);
        make.right.equalTo(bgView).with.offset(0);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showView.mas_centerX);
        make.top.equalTo(showView).with.offset(10);
    }];
    
    
    UILabel *textWordLabel = [[UILabel alloc]init];
    textWordLabel.numberOfLines = 0;
    textWordLabel.textColor = RGBA(117, 117, 117, 1);
    textWordLabel.font = [UIFont systemFontOfSize:14];
    
    
    
    [[RACObserve(self, Viewmodel.raffleNumModel)ignore:nil]subscribeNext:^(id x) {
        @strongify(self)
        textWordLabel.text = [NSString stringWithFormat:@"本次活动每日限抽%ld次,您今日抽奖次数已用完，去参加别的活动吧",(long)self.Viewmodel.raffleNumModel.activeJoinNum];
    }];
    [showView addSubview:textWordLabel];
    [textWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showView).with.offset(18);
        make.top.equalTo(iconImageView.mas_bottom).with.offset(10);
        make.right.equalTo(showView).with.offset(-18);
    }];
    UIButton *showbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showView addSubview:showbtn];
    [showbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textWordLabel.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(showView.mas_centerX);
    }];
    
    [showbtn setImage:[UIImage imageNamed:@"show_noTime_btn"] forState:UIControlStateNormal];
    [[showbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [showView removeFromSuperview];
        [backimageView removeFromSuperview];
        [self popToRoot];
    }];
    [backimageView whenTapped:^{
        @strongify(self)
        [showView removeFromSuperview];
        [backimageView removeFromSuperview];
    }];
    //让按钮的enable=YES;
    
    btn.enabled=YES;
}
/**
 *  奖金币不够了
 */
-(void)showCoinNotEnough
{
    @weakify(self)
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIView *backimageView = [[UIView alloc]init];
    backimageView.frame = self.view.bounds;
    backimageView.backgroundColor = [UIColor blackColor];
    backimageView.alpha = 0.5;
    [window addSubview:backimageView];
    
    UIView *showView = [[UIView alloc]init];
    showView.backgroundColor = [UIColor whiteColor];
   showView.frame = CGRectMake(28, (self.view.height-200)/2, self.view.frame.size.width-56, 200);    showView.layer.cornerRadius = 10;
    [window addSubview:showView];
    UIView* bgView=[[UIView alloc]init];
    [showView addSubview:bgView];
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"show_howNocoin_icon"]];
    [bgView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(0);
        make.top.equalTo(bgView).with.offset(0);
        make.bottom.equalTo(bgView).with.offset(0);
    }];
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"奖金币不够！";
    tipLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(20);
        make.top.equalTo(bgView).with.offset(0);
        make.bottom.equalTo(bgView).with.offset(0);
        make.right.equalTo(bgView).with.offset(0);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showView.mas_centerX);
        make.top.equalTo(showView).with.offset(10);
    }];
    
    
    
    
    UILabel *textWordLabel = [[UILabel alloc]init];
    textWordLabel.numberOfLines = 0;
    textWordLabel.textColor = RGBA(117, 117, 117, 1);
    textWordLabel.font = [UIFont systemFontOfSize:14];
    [[RACObserve(self, Viewmodel.raffleNumModel)ignore:nil]subscribeNext:^(id x) {
        @strongify(self)
        textWordLabel.text = [NSString stringWithFormat:@"您现在奖金币不足%ld个，不能抽奖，快去积累奖金币吧!",(long)self.Viewmodel.raffleNumModel.exchangePoint];
    }];
    [showView addSubview:textWordLabel];
    [textWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showView).with.offset(18);
        make.top.equalTo(iconImageView.mas_bottom).with.offset(10);
        make.right.equalTo(showView).with.offset(-18);
    }];
    UIButton *showbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showView addSubview:showbtn];
    
    [showbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textWordLabel.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(showView.mas_centerX);
    }];
    [showbtn setImage:[UIImage imageNamed:@"show_howNoCoin_btn"] forState:UIControlStateNormal];
 
    showbtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"]tap:^(XPBaseViewController *x) {
            @strongify(self)
            x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                @strongify(self);
                
                x.identifier=self.Viewmodel.raffleNumModel.pointsRule;
                x.baseTransfer = @"奖金币规则";

    }];
        }]];
        [backimageView removeFromSuperview];
        [showView removeFromSuperview];
        
        return [RACSignal empty];
    }];
    [backimageView whenTapped:^{
        @strongify(self)
        [showView removeFromSuperview];
        [backimageView removeFromSuperview];
    }];
    //让按钮的enable=YES;
    
    btn.enabled=YES;

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.showNumOfRaffle.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight    cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-62, 14);
    
    maskLayer.path = maskPath.CGPath;
    self.showNumOfRaffle.layer.mask = maskLayer;

}



-(RaffleViewModel*)Viewmodel{
    if(!_Viewmodel){
        _Viewmodel=[[RaffleViewModel alloc]init];
    }
    return _Viewmodel;
}
@end
