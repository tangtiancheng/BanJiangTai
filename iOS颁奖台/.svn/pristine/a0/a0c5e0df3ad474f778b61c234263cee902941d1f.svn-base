//
//  TasteFindResultCell.m
//  XPApp
//
//  Created by Pua on 16/5/30.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteFindResultCell.h"
#import "TasteMainModel.h"
#import "UILabel+XPAttribute.h"

@interface TasteFindResultCell ()
@property (nonatomic, strong) TasteFilterModel *model;


@end

@implementation TasteFindResultCell

//-(instancetype)init
//{
//    if (self = [super init]) {
//        [self cellConfig];
//    }
//    return self;
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FindCell"]) {
//        [self cellConfig];
    }
    return self;
}
-(void)cellConfig
{
    RAC(self.textLabel,text) = [[RACObserve(self,model.name)ignore:nil]map:^id(id value) {
    return [@""stringByAppendingString:value];
    }];
    RAC(self.detailTextLabel,text) = [[RACObserve(self,model.count)ignore:nil]map:^id(id value) {
        return [@""stringByAppendingString:value];
    }];
    
}
#pragma mark - Public Interface
- (void)bindModel:(TasteFilterModel *)model
{
    NSParameterAssert([model isKindOfClass:[TasteFilterModel class]]);
    self.model = model;
}
@end
