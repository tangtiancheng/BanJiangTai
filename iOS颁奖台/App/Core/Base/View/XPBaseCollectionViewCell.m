//
//  XPBaseCollectionViewCell.m
//  Huaban
//
//  Created by huangxinping on 4/24/15.
//  Copyright (c) 2015 iiseeuu.com. All rights reserved.
//

#import "XPBaseCollectionViewCell.h"

@implementation XPBaseCollectionViewCell

- (void)bindViewModel:(XPBaseViewModel *)viewModel
{
    XPLogError(@"Opps，you must implement sub class.");
}

- (void)bindModel:(XPBaseModel *)model
{
    XPLogError(@"Opps，you must implement sub class.");
}

@end
