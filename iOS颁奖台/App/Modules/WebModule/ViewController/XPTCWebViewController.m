//
//  XPTCWebViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/4/4.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "XPTCWebViewController.h"

@interface XPTCWebViewController ()<UIWebViewDelegate>

@end

@implementation XPTCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = self.model.baseTransfer;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.identifier]]];
    self.view.backgroundColor=RGBA(215, 215, 215, 1);
    // Do any additional setup after loading the view.
}

-(UIWebView*)webView{
    if(!_webView){
        UIWebView* webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        webView.delegate=self;
        _webView=webView;
    
        [_webView setUserInteractionEnabled:YES];
        [_webView setBackgroundColor:[UIColor clearColor]];
        [_webView setOpaque:NO];
        _webView.scalesPageToFit = YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}
#pragma mark UIWebViewDelegate
////加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"kjkjkjkjkjjkjkjk%@",[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
    NSString *js = @"window.onload = function(){document.body.style.backgroundColor = 'red';}";

[webView stringByEvaluatingJavaScriptFromString:js];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    return YES;
//}
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
