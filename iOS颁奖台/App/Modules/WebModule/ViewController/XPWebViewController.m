//
//  XPWebViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/19/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPWebView.h"
#import "XPWebViewController.h"
#import <XPKit/XPKit.h>

@interface XPWebViewController ()



@end

@implementation XPWebViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.model.baseTransfer;
    [self.webView setRemoteUrl:@"https://www.github.com"];
}
//-(XPWebView*)webView{
//    if(!_webView){
//        XPWebView* webview=[[XPWebView alloc]init];
//        webview.backgroundColor=[UIColor greenColor];
//        webview.frame=self.view.bounds;
//        _webView=webview;
//        [self.view addSubview:webview];
//    }
//    return _webView;
//}
#pragma mark - Delegate

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
