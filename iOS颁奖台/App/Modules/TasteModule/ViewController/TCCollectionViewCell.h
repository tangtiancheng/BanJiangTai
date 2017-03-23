//
//  TCCollectionViewCell.h
//  味道demo
//
//  Created by 唐天成 on 16/7/6.
//  Copyright © 2016年 唐天成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPTastStoreModel.h"
#import "XPBaseCollectionViewCell.h"
@class TCCollectionViewCell;

@protocol TCCollectionViewCellDelegate<NSObject>
-(void)collectionViewCell:(TCCollectionViewCell*)collectionViewCell addOrderWithDashModel:(XPDashInfoModel*)dashModel;
@end

@interface TCCollectionViewCell :XPBaseCollectionViewCell

@property (nonatomic, weak)id<TCCollectionViewCellDelegate> delegate;
//遮罩
@property (weak, nonatomic) IBOutlet UIView *backGrayView;
//菜图
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//菜名
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *dishPrice;
//原价
@property (weak, nonatomic) IBOutlet UILabel *dishOldPrice;


@end
