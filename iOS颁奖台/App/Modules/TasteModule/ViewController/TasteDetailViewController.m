//
//  TasteDetailViewController.m
//  XPApp
//
//  Created by Pua on 16/5/30.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteDetailViewController.h"

@interface TasteDetailViewController ()<UIWebViewDelegate>
{
    UIWebView *DetailWebView;
}
@end

@implementation TasteDetailViewController
-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    DetailWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSString *UrlStr = [[NSString alloc]init];
    if ([XPLoginModel singleton].accessToken==NULL){
        UrlStr = [NSString stringWithFormat:@"http://101.201.75.27:8080/ernie/taste/customerDish.ernie?businessId=%@&accessToken=&sourceType=&storeId=%@&userId=&userPhone=",_TModel.businessId,_TModel.storeId];

    }else{
        UrlStr = [NSString stringWithFormat:@"http://101.201.75.27:8080/ernie/taste/customerDish.ernie?businessId=%@&accessToken=%@&sourceType=&storeId=%@&userId=%@&userPhone=%@",_TModel.businessId,[XPLoginModel singleton].accessToken,_TModel.storeId,[XPLoginModel singleton].userId,[XPLoginModel singleton].userPhone];
    }

    NSLog(@"%@",UrlStr);
    
    DetailWebView.delegate = self;
    NSURL * BaseUrl = [NSURL URLWithString:UrlStr];
    NSString * urlStr = [NSString stringWithContentsOfURL:BaseUrl encoding:NSUTF8StringEncoding error:nil];
    [DetailWebView loadHTMLString:urlStr baseURL:BaseUrl];

    [self.view addSubview:DetailWebView];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *  UrlStr = [[request URL] absoluteString];
    
    UrlStr = [UrlStr  stringByRemovingPercentEncoding];
    
    NSLog(@"-----%@",UrlStr);
    
    if ([UrlStr hasSuffix:@"loginOut"]) {
        
        [self testFunc];
        return NO;
    }else if ([UrlStr containsString:@"phoneCall?phoneNum="]){
        //截取手机号
        NSRange range = [UrlStr rangeOfString:@"phoneCall?phoneNum="];
        NSInteger location = range.location + range.length;
        NSRange newRange = NSMakeRange(location, UrlStr.length - location);
        NSString * numberStr = [UrlStr substringWithRange:newRange];
        //使用手机号打电话
        [self phoneCallWithNumber:numberStr];
    }
    
    return YES;
}
- (void)printLog:(NSString *)str
{
    NSLog(@"%@", str);
}

- (void)testFunc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 打电话
-(void)phoneCallWithNumber:(NSString *)phoneNumber{
    UIWebView * phoneCallWeb = [[UIWebView alloc]init];
    NSURL * phoneCallURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    [phoneCallWeb loadRequest:[NSURLRequest requestWithURL:phoneCallURL]];
    [self.view addSubview:phoneCallWeb];
}
@end
