//
//  XPBaseViewController+XPAppStore.m
//  XPApp
//
//  Created by xinpinghuang on 1/20/16.
//  Copyright © 2016 ShareMerge. All rights reserved.
//

#import "XPBaseViewController+XPAppStore.h"
#import <StoreKit/StoreKit.h>
#import <XPKit/NSObject+XPKit.h>

@interface XPBaseViewController () <SKStoreProductViewControllerDelegate>

xp_property_as_associated_strong(SKStoreProductViewController *, storeProductViewContorller);

@end

@implementation XPBaseViewController (XPAppStore)

xp_property_def_associated_strong(SKStoreProductViewController *, storeProductViewContorller)

- (void)evaluate
{
    [self showLoader];
    self.storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    self.storeProductViewContorller.delegate = self;
    @weakify(self);
    [self.storeProductViewContorller loadProductWithParameters:
     @{SKStoreProductParameterITunesItemIdentifier:@"991897864"}
                                               completionBlock:^(BOOL result, NSError *error) {
                                                   @strongify(self);
                                                   if(error) {
                                                       [self showToastWithNSError:error];
                                                   } else {
                                                       [self hideLoader];
                                                       [self presentViewController:self.storeProductViewContorller animated:YES completion:^{
                                                       }
                                                        ];
                                                   }
                                               }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
