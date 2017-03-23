//
//  TCorderMenuCell.m
//  XPApp
//
//  Created by 唐天成 on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TCorderMenuCell.h"
#import "XPTastStoreModel.h"
#import "NSString+XPRemoteImage.h"
#import <ReactiveCocoa.h>

@interface TCorderMenuCell()

@property (nonatomic, strong)XPTastOrderingModel *tastOrderingModel;
//菜图片
@property (weak, nonatomic) IBOutlet UIImageView *dashImageView;
//菜名
@property (weak, nonatomic) IBOutlet UILabel *dashNameLabel;
//数目
@property (weak, nonatomic) IBOutlet UILabel *dashCountLabel;
//总价
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
//添加
@property (weak, nonatomic) IBOutlet UIButton *addButton;
//减少
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;

@end

@implementation TCorderMenuCell

-(void)awakeFromNib{
    RAC(self.dashImageView, image) = [[RACObserve(self, tastOrderingModel.dashInfoModel.dashImg) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    
    RAC(self.dashNameLabel,text)=RACObserve(self, tastOrderingModel.dashInfoModel.dashName);
//    [RACObserve(self, tastOrderingModel.count)subscribeNext:^(id x) {
//        self.dashNameLabel.text=
//    }];
    [[RACObserve(self, tastOrderingModel)ignore:nil]subscribeNext:^(XPTastOrderingModel* x) {
        NSLog(@"%ld",x.count);
         [self observerCount];
           }];
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
            self.tastOrderingModel.count++;
       [self observerCount];
    }];
    [[self.reduceButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if(self.tastOrderingModel.count!=0){
            self.tastOrderingModel.count--;
            [self observerCount];
        }
    }];
    
}
//监听数量变化
-(void)observerCount{
    XPTastOrderingModel* x = self.tastOrderingModel;
    self.dashCountLabel.text=[NSString stringWithFormat:@"%ld", x.count];
    XPDashInfoModel* dashInfoModel = x.dashInfoModel;
    NSString* price = [dashInfoModel.cutPrize isEqualToString:@""]?dashInfoModel.oldPrize:dashInfoModel.cutPrize;
    CGFloat priceFloat = price.floatValue;
    self.allPriceLabel.text=[NSString stringWithFormat:@"￥%.0lf",priceFloat* x.count];

}
-(void)bindModel:(XPBaseModel *)model{
     NSParameterAssert([model isKindOfClass:[XPTastOrderingModel class]]);
    self.tastOrderingModel=model;
    
}
@end
