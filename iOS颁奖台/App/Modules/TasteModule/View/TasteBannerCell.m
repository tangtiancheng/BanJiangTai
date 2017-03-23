//
//  TasteBannerCell.m
//  XPApp
//
//  Created by Pua on 16/5/18.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//
#import "XPBaseViewController.h"
#import "TasteBannerCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <XPAdPageView/XPADView.h>
#import "TasteMainModel.h"
#import "BannerDetialViewController.h"
@interface TasteBannerCell()<XPAdViewDelegate>
@property (nonatomic, strong) XPADView *adView;
@property (nonatomic, strong) NSArray *models;
@end

@implementation TasteBannerCell

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
    BannerDetialViewController *bdvc = [[BannerDetialViewController alloc]init];
    
    [[self GetviewController] presentViewController:bdvc animated:YES completion:nil];
//    @weakify(self);
//    XPBaseViewController *destinationViewController = (XPBaseViewController *)[(XPBaseViewController *)[self belongViewController] instantiateViewControllerWithStoryboardName:@"Taste" identifier:@"TasteHead"];
//    [destinationViewController setModel:[[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
//        @strongify(self);
//        x.identifier = [(TasteBannerModel *)self.models[index] storeId];
//    }]];
//    [(XPBaseViewController *)[self.superview belongViewController] pushViewController:destinationViewController];
}
#pragma mark - Delegate
- (void)adView:(XPADView *)adView lazyLoadAtIndex:(NSUInteger)index imageView:(UIImageView *)imageView imageURL:(NSString *)imageURL
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}
#pragma mark - Public Interface
- (void)configWithBanner:(NSArray *)banners
{
    if(!banners) {
        return;
    }
    
    self.models = banners;
    [self.adView setDataArray:[[[banners rac_sequence] map:^id (TasteBannerModel *value) {
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
        _adView.displayTime = 4;
        _adView.delegate = self;
    }
    
    return _adView;
}
//获得View的UIViewController
- (UIViewController *)GetviewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    return nil;
}

@end
