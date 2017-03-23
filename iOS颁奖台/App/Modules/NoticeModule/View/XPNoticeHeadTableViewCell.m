//
//  XPNoticeHeadTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "XPNoticeHeadTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <XPAdPageView/XPADView.h>
#import <XPAutoNIBColor/XPAutoNIBColor.h>
#import <XPAutoNIBi18n/XPAutoNIBi18n.h>

@interface XPNoticeHeadTableViewCell ()<XPAdViewDelegate>

@property (nonatomic, strong) XPADView *adView;

@end

@implementation XPNoticeHeadTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    [self addSubview:self.adView];
    [self.adView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.leading.top.trailing.bottom.equalTo(self);
    }];
}

#pragma mark - Delegate
#pragma mark - XPAdPageView Delegate
- (void)adView:(XPADView *)adView didSelectedAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView imagePath:(NSString *)imagePath
{
}

- (void)adView:(XPADView *)adView lazyLoadAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView imageURL:(NSString *)imageURL
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

#pragma mark - Public Interface
- (void)configWithBanners:(NSArray *)banners
{
    if(!banners) {
        return;
    }
    
    [self.adView setDataArray:[[[banners rac_sequence] map:^id (id value) {
        return value[@"imageUrl"];
    }] array]];
    //    [self.adView perform];
}

#pragma mark - Getter && Setter
- (XPADView *)adView
{
    if(!_adView) {
        _adView = [[XPADView alloc] initWithFrame:self.bounds];
        //        _adView.pageControl.currentPageIndicatorTintColor = [XPAutoNIBColor colorWithName:@"c1"];
        //        _adView.pageControl.pageIndicatorTintColor = [XPAutoNIBColor colorWithName:@"c3"];
        [_adView.pageControl setHidden:YES];
        [_adView setUserInteractionEnabled:NO];
        _adView.displayTime = INT_MAX;
        _adView.delegate = self;
    }
    
    return _adView;
}

@end
