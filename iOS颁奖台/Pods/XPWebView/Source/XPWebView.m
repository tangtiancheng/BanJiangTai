//
//  XPWebView.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "XPWebView.h"
#import <NJKWebViewProgress/NJKWebViewProgress.h>
#import <NJKWebViewProgress/NJKWebViewProgressView.h>

@interface XPWebView (belongViewController)

- (UIViewController *)xp_webview_belongViewController;

@end

@implementation XPWebView (belongViewController)

- (UIViewController *)xp_webview_belongViewController
{
    for(UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

@end

@interface XPWebView ()<UIWebViewDelegate, NJKWebViewProgressDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets;
@property (nonatomic, strong) UILabel *sourceLabel;

@end

@implementation XPWebView

#pragma mark - Life Circle
- (void)awakeFromNib
{
    if([self xp_webview_belongViewController].automaticallyAdjustsScrollViewInsets) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.delegate = self.progressProxy;
    [self addSubview:self.progressView];
}

#pragma mark - Delegate
#pragma mark - NJKWebViewProgress Delegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
    self.title = [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.sourceLabel) {
        CGRect headerFrame = self.sourceLabel.frame;
        headerFrame.origin.y = scrollView.contentOffset.y+8+64;
        self.sourceLabel.frame = headerFrame;
    }
}

#pragma mark - Public Interface
- (void)setRemoteUrl:(NSString *)remoteUrl
{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:remoteUrl]]];
    if(!self.sourceLabel) {
        self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, [UIScreen mainScreen].bounds.size.width, 13)];
        NSURL *url = [NSURL URLWithString:remoteUrl];
        self.sourceLabel.text = [NSString stringWithFormat:@"网页由 %@ 提供", url.host];
        self.sourceLabel.font = [UIFont systemFontOfSize:10];
        self.sourceLabel.textColor = [UIColor colorWithWhite:0.455 alpha:1.000];
        self.sourceLabel.textAlignment = NSTextAlignmentCenter;
        if(![self.sourceLabel superview]) {
            [self.scrollView addSubview:self.sourceLabel];
            [self.scrollView sendSubviewToBack:self.sourceLabel];
        }
    }
}

#pragma mark - Getter && Setter
- (NJKWebViewProgressView *)progressView
{
    if(_progressView == nil) {
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, self.automaticallyAdjustsScrollViewInsets ? 64 : 0, self.bounds.size.width, 2)];
    }
    
    return _progressView;
}

- (NJKWebViewProgress *)progressProxy
{
    if(_progressProxy == nil) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
    }
    
    return _progressProxy;
}

@end
