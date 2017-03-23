//
//  XPHelpViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/29/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPHelpViewController.h"
#import "XPHelpViewModel.h"
#import <XPKit/XPKit.h>

@interface XPHelpViewController ()<UITableViewDataSource, UITableViewDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, weak) IBOutlet XPHelpViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPHelpViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.viewModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.viewModel, error) ignore:nil] map:^id (id value) {
        return value;
    }], nil];
    
        [self.viewModel.helpCommand execute:nil];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld", (long)indexPath.row] forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if(1 == indexPath.row) {
            @weakify(self);
            [self pushViewController:[[self instantiateInitialViewControllerWithStoryboardName:@"Web"] tap:^(XPBaseViewController *x) {
                x.model = [[[XPBaseModel alloc] init] tap:^(XPBaseModel *x) {
                    @strongify(self);
                    NSLog(@"%@",self.viewModel.helpURL);
                    x.identifier = self.viewModel.helpURL;
                    x.baseTransfer = @"帮助中心";
                }];
            }]];
        }
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Getter & Setter

@end
