//
//  TTCWebViewController.m
//  XPApp
//
//  Created by 唐天成 on 2017/1/10.
//  Copyright © 2017年 ShareMerge. All rights reserved.
//

#import "TTCWebViewController.h"
#import <XPWebView.h>

@interface TTCWebViewController ()

@property (nonatomic, strong) XPWebView *webView;


@end

@implementation TTCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[XPWebView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.webView];
    self.webView.remoteUrl = @"https://www.baidu.com";
    // Do any additional setup after loading the view.
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
