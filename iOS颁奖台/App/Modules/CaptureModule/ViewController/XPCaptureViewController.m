//
//  XPCaptureViewController.m
//  XPApp
//
//  Created by huangxinping on 15/10/20.
//  Copyright © 2015年 iiseeuu.com. All rights reserved.
//

#import "XPCaptureViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <XPKit/XPKit.h>
#import <objc/runtime.h>

#import "XPQRCaptureView+RACSignalSupport.h"

static void *kXPCaptureSubscriberKey = &kXPCaptureSubscriberKey;
@interface XPCaptureViewController ()

@property (nonatomic, strong) XPQRCaptureView *captureView;

@end

@implementation XPCaptureViewController

#pragma mark - LifeCircle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self showLoaderWithText:@"载入中..."];
    
    @weakify(self);
    [self performBlock:^{
        @strongify(self);
        [self.view addSubview:self.captureView];
        [self.captureView sendToBack];
        [self hideLoader];
    }
            afterDelay:0.0f onMainThread:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods
- (RACSignal *)rac_captureOutput
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        @strongify(self);
        objc_setAssociatedObject(self, &kXPCaptureSubscriberKey, subscriber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return nil;
    }];
}

#pragma mark - Getter && Setter
- (XPQRCaptureView *)captureView
{
    if(!_captureView) {
        @weakify(self);
        _captureView = [[XPQRCaptureView alloc] initWithFrame:self.view.bounds];
        [[_captureView rac_startCapture]
         subscribeNext:^(id x) {
             @strongify(self);
             id <RACSubscriber> subscriber = objc_getAssociatedObject(self, &kXPCaptureSubscriberKey);
             [subscriber sendNext:x];
             //             [subscriber sendCompleted];
             [self pop];
         }];
    }
    
    return _captureView;
}

@end
