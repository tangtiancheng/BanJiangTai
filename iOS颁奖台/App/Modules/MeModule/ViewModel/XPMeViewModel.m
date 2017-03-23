//
//  XPMeViewModel.m
//  XPApp
//
//  Created by xinpinghuang on 2/16/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "UIImage+XPCompress.h"
#import "XPAPIManager+Me.h"
#import "XPAPIManager+XPPostImage.h"
#import "XPLoginModel.h"
#import "XPMeViewModel.h"
#import "XPSingleton.h"
#import "XPAPIManager+Main.h"

@interface XPMeViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *submitCommand;
@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong,readwrite)RACCommand* signInCommand;


@end

@implementation XPMeViewModel

#pragma mark - Life Circle
- (instancetype)init
{
    if(self = [super init]) {
    }
    
    return self;
}

#pragma mark - Public Interface

#pragma mark - Private Methods

#pragma mark - Getter & Setter
- (RACCommand *)submitCommand
{
    if(_submitCommand == nil) {
        @weakify(self);
        _submitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[self.apiManager rac_postRemoteImage:[self.avatarImage xp_compress]] doNext:^(id x) {
                @strongify(self);
                self.avatarURL = x;
                [XPLoginModel singleton].userImage = x;
            }] then:^RACSignal *{
                return [self.apiManager updateProfileWithNick:nil sex:[XPLoginModel singleton].userSex avatar:self.avatarURL birthday:nil];
            }];
        }];
        XPViewModelShortHand(_submitCommand);
    }
    
    return _submitCommand;
}

//天成修改  签到的commend
- (RACCommand*)signInCommand{
    if(!_signInCommand){
        @weakify(self)
        _signInCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [self.apiManager userSignIn];
        }];
        
        [[[_signInCommand executionSignals] concat] subscribeNext:^(XPMainSignInModel *x) {
            @strongify(self);
            self.signInModel = x;
            [XPSingleton shareSingleton].continuousDays=x.continuousDays;
            [XPSingleton shareSingleton].continuousTotalDays=x.continuousTotalDays;
//            [NSUserDefaults ]
//            [[NSUserDefaults standardUserDefaults]setObject:x.continuousDays forKey:@"continuousDays"];
//            [[NSUserDefaults standardUserDefaults]setObject:x.continuousTotalDays forKey:@"continuousTotalDays"];
        }];
        XPViewModelShortHand(_signInCommand);
    }
    
    
    return _signInCommand;
    
}
@end
