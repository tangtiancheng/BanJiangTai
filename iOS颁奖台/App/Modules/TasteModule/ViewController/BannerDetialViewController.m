//
//  BannerDetialViewController.m
//  XPApp
//
//  Created by Pua on 16/6/3.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "BannerDetialViewController.h"

@interface BannerDetialViewController ()<UIWebViewDelegate>

@end

@implementation BannerDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"advertisement" withExtension:@"html" subdirectory:@"advertisement"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:backButton];
    view.userInteractionEnabled = YES;
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"发现美食";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 0.5)];
    LineView.backgroundColor = RGBA(143, 143, 143, 1);
    [view addSubview:LineView];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view);
    }];
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"banner_back_button"]];
    [view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(20);
        make.centerY.equalTo(view);
    }];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.height.equalTo(view);
        make.width.mas_equalTo(50);
    }];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
