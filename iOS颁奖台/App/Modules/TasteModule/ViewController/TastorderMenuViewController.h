//
//  TastorderMenuViewController.h
//  XPApp
//
//  Created by 唐天成 on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPTastStoreModel.h"

@interface TastorderMenuViewController : UIViewController
@property (nonatomic, strong)NSArray<XPTastOrderingModel*>* tastOrderingModelArray;

@end
