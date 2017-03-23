//
//  TCTableViewCell.h
//  味道demo
//
//  Created by 唐天成 on 16/7/6.
//  Copyright © 2016年 唐天成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPBaseTableViewCell.h"
@interface TCTableViewCell : XPBaseTableViewCell
//菜品类型label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
