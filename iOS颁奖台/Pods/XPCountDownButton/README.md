# JKCountDownButton
JKCountDownButton,子类化UIButton实现IOS倒计时按钮,常常用于注册等发送验证码的时候进行倒计时操作

##代码方式使用
    JKCountDownButton *_countDownCode;
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(81, 200, 108, 32);
    [_countDownCode setTitle:@"开始" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_countDownCode];
    
    [_countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;

        [sender startWithSecond:10];

        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];

    }];
    
##xib方式使用
    @property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;

    - (IBAction)countDownXibTouched:(JKCountDownButton*)sender {
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startWithSecond:10];
 
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
        
    }];}

##效果图
![](https://raw.githubusercontent.com/shaojiankui/JKCountDownButton/master/demo.gif)