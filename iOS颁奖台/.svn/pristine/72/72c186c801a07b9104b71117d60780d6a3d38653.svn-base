//
//  XPMainHeadTableViewCell.m
//  XPApp
//
//  Created by xinpinghuang on 12/28/15.
//  Copyright © 2015 ShareMerge. All rights reserved.
//

#import "XPBaseViewController.h"
#import "XPMainHeadTableViewCell.h"
#import "XPMainModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <XPAdPageView/XPADView.h>
#import <XPAutoNIBColor/XPAutoNIBColor.h>
#import <XPAutoNIBi18n/XPAutoNIBi18n.h>

@interface XPMainHeadTableViewCell ()<XPAdViewDelegate>

@property (nonatomic, strong) XPADView *adView;
@property (nonatomic, strong) NSArray *models;

@end

@implementation XPMainHeadTableViewCell

#pragma mark - Life Circle
- (void)awakeFromNib
{
    [self addSubview:self.adView];
    [self.adView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.leading.top.trailing.bottom.equalTo(self);
    }];
}

#pragma mark - XPAdPageView Delegate
- (void)adView:(XPADView *)adView didSelectedAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView imagePath:(NSString *)imagePath
{
    @weakify(self);
    XPBaseViewController *destinationViewController = (XPBaseViewController *)[(XPBaseViewController *)[self belongViewController] instantiateViewControllerWithStoryboardName:@"Main" identifier:@"Plain"];
    [destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
        @strongify(self);
        x.identifier = [(XPMainBannerModel *)self.models[index] activeId];
    }]];
    [(XPBaseViewController *)[self.superview belongViewController] pushViewController:destinationViewController];
}

#pragma mark - Delegate
- (void)adView:(XPADView *)adView lazyLoadAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView imageURL:(NSString *)imageURL
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    //    [imageView removeAllSubviews];
    //    if(self.models.count <= index) {
    //        return;
    //    }
    
    /*
     { // 主办方
     UILabel *sponsor = [[UILabel alloc] initWithFrame:ccr(15, adView.height-39-15, adView.width-30, 15)];
     sponsor.font = [UIFont systemFontOfSize:13];
     sponsor.text = [@"主办方：" stringByAppendingString:[(XPMainBannerModel *)self.models[index] sponsor]];
     sponsor.textColor = [UIColor whiteColor];
     [imageView addSubview:sponsor];
     }
     
     { // 活动时间
     UILabel *date = [[UILabel alloc] initWithFrame:ccr(15, adView.height-16-15, adView.width-30, 15)];
     date.font = [UIFont systemFontOfSize:12];
     date.text = [@"活动时间：" stringByAppendingFormat:@"%@~%@ %@-%@", [(XPMainBannerModel *)self.models[index] startDate], [(XPMainBannerModel *)self.models[index] endDate], [(XPMainBannerModel *)self.models[index] startTime], [(XPMainBannerModel *)self.models[index] endTime]];
     date.textColor = [UIColor whiteColor];
     [imageView addSubview:date];
     }
     */
}

#pragma mark - Public Interface
- (void)configWithBanners:(NSArray *)banners
{
    if(!banners) {
        return;
    }
    
    self.models = banners;
    [self.adView setDataArray:[[[banners rac_sequence] map:^id (XPMainBannerModel *value) {
        return value.imageUrl;
    }] array]];
    if(banners.count <= 1) {
        [self.adView.pageControl setHidden:YES];
        return;
    }
    
    [self.adView setUserInteractionEnabled:YES];
    [self.adView.pageControl setHidden:NO];
    [self.adView perform];
}

#pragma mark - Getter && Setter
- (XPADView *)adView
{
    if(!_adView) {
        _adView = [[XPADView alloc] initWithFrame:self.bounds];
        //        _adView.pageControl.currentPageIndicatorTintColor = [XPAutoNIBColor colorWithName:@"c1"];
        //        _adView.pageControl.pageIndicatorTintColor = [XPAutoNIBColor colorWithName:@"c3"];
        _adView.displayTime = 4;
        _adView.delegate = self;
    }
    
    return _adView;
}

@end
