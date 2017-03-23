//
//  TasteMainTBCell.m
//  XPApp
//
//  Created by Pua on 16/5/17.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteMainTBCell.h"
#import "TasteMainModel.h"
#import "NSString+XPRemoteImage.h"
#import "UILabel+XPAttribute.h"

@interface TasteMainTBCell ()
@property (nonatomic, strong) TasteMainModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *StoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageSmall;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *prieceLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabelFirst;
@property (weak, nonatomic) IBOutlet UILabel *typeLabelSec;
@property (weak, nonatomic) IBOutlet UILabel *typeLabelThird;

@end

@implementation TasteMainTBCell

#pragma mark - Life Circle
-(void)awakeFromNib
{
    RAC(self.imageIcon, image) = [[RACObserve(self, model.storeLogo) flattenMap:^RACStream *(id value) {
        return value ? [value rac_remote_image] : [RACSignal return :nil];
    }] deliverOn:[RACScheduler mainThreadScheduler]];

    RAC(self.StoreLabel,text) = [[RACObserve(self,model.storeName)ignore:nil]map:^id(id value) {
        return [@""stringByAppendingString:value];
    }];
    RAC(self.adressLabel, text) = [[RACObserve(self, model.storeAddress) ignore:nil] map:^id(id value) {
        return [@"" stringByAppendingString:value];
    }];
    RAC(self.prieceLabel, text) = [[RACObserve(self, model.avgPrice) ignore:nil] map:^id(id value) {
        self.typeLabelFirst.backgroundColor = RGBA(123, 187, 61, 1);
        self.typeLabelFirst.textColor = [UIColor whiteColor];
        self.typeLabelFirst.cornerRadius = 6;
        if (_model.storeTags.count >= 3) {
            self.typeLabelFirst.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[0] objectForKey:@"storeTag"]];
            self.typeLabelThird.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[2]objectForKey:@"storeTag"]];
            self.typeLabelThird.backgroundColor = RGBA(123, 187, 61, 1);
            self.typeLabelThird.textColor = [UIColor whiteColor];
            self.typeLabelThird.cornerRadius = 6;
            self.typeLabelSec.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[1]objectForKey:@"storeTag"]];
            self.typeLabelSec.backgroundColor = RGBA(123, 187, 61, 1);
            self.typeLabelSec.textColor = [UIColor whiteColor];
            self.typeLabelSec.cornerRadius = 6;
        }else if (_model.storeTags.count ==2){
            self.typeLabelFirst.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[0] objectForKey:@"storeTag"]];
            self.typeLabelSec.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[1]objectForKey:@"storeTag"]];
            self.typeLabelThird.text = @"";
            self.typeLabelSec.backgroundColor = RGBA(123, 187, 61, 1);
            self.typeLabelSec.textColor = [UIColor whiteColor];
            self.typeLabelSec.cornerRadius = 6;
        }else if(_model.storeTags.count == 1){
            self.typeLabelFirst.text = [NSString stringWithFormat:@"  %@  ",[self.model.storeTags[0] objectForKey:@"storeTag"]];
        self.typeLabelThird.text = @"";
            self.typeLabelSec.text = @"";
        }else{
            self.typeLabelFirst.text = @"";
            self.typeLabelThird.text = @"";
            self.typeLabelSec.text = @"";
        }
        return [NSString stringWithFormat:@"￥%@/位",value];
    }];
}
#pragma mark - Public Interface
- (void)bindModel:(TasteMainModel *)model
{
    NSParameterAssert([model isKindOfClass:[TasteMainModel class]]);
    self.model = model;
}
@end
