//
//  TCCollectionViewCell.m
//  味道demo
//
//  Created by 唐天成 on 16/7/6.
//  Copyright © 2016年 唐天成. All rights reserved.
//

#import "TCCollectionViewCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSString+XPRemoteImage.h"
#import <Masonry.h>

@interface TCCollectionViewCell()
@property (nonatomic, strong) XPDashInfoModel *model;



@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(nonatomic,assign)NSInteger count;
@end

@implementation TCCollectionViewCell
- (IBAction)addBtnClick:(id)sender {
    self.backGrayView.hidden=NO;
//    self.count++;
    self.model.orderCount++;
    [UIView animateWithDuration:0.5 animations:^{
        self.countLabel.alpha=0.0;
    } completion:^(BOOL finished) {
        self.countLabel.alpha=1;
        self.countLabel.text=[NSString stringWithFormat:@"x %ld",self.model.orderCount];
    }];
    //执行代理
    if([self.delegate respondsToSelector:@selector(collectionViewCell:addOrderWithDashModel:)]){
        [self.delegate collectionViewCell:self addOrderWithDashModel:self.model];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
     @weakify(self);
//    self.backGrayView.hidden=YES;
    RAC(self.imageView, image) = [[RACObserve(self, model.dashImg) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];
    
   
    RAC(self.dishNameLabel, text) = [RACObserve(self, model.dashName)ignore:nil] ;
    
    [[RACObserve(self, model.cutPrize) ignore:nil]subscribeNext:^(NSString* cutPrice) {
        
        
        
        if([cutPrice isEqualToString: @""]){
            self.dishPrice.text=[NSString stringWithFormat:@"￥%@", self.model.oldPrize];
            self.dishOldPrice.hidden=YES;
            [self.dishPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-4);
                make.bottom.equalTo(self);
            }];
//            return [NSString stringWithFormat:@"￥%@", self.model.oldPrize];
        }else{
            self.dishPrice.text=[NSString stringWithFormat:@"￥%@", cutPrice];
            
            
            NSAttributedString* attribuuteString=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",self.model.oldPrize] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)}];
            
            self.dishOldPrice.attributedText=attribuuteString;
        }
//        return [NSString stringWithFormat:@"￥%@", cutPrice];
    }];
//    }];
//   [[[RACObserve(self, model.cutPrize) ignore:nil] map:^id (NSString *cutPrice) {
//        NSLog(@"%@",cutPrice);
//        
//        if([cutPrice isEqualToString: @""]){
//            return [NSString stringWithFormat:@"￥%@", self.model.oldPrize];
//        }
//            return [NSString stringWithFormat:@"￥%@", cutPrice];
//        }]subscribeNext:^(id x) {
//            <#code#>
//        }];

    
}
- (void)bindModel:(XPDashInfoModel *)model
{
    NSParameterAssert([model isKindOfClass:[XPDashInfoModel class]]);
    self.model = model;
    self.model.typeDish=arc4random()%3;
    
    if(self.model.orderCount == 0){
        self.backGrayView.hidden=YES;
        self.countLabel.text=@"";
    }else{
        self.backGrayView.hidden=NO;
        self.countLabel.text=[NSString stringWithFormat:@"x %ld",self.model.orderCount];
    }
    NSLog(@"%ld",self.model.typeDish);
}

@end
