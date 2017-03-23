//
//  XPGiftCreateViewController.m
//  XPApp
//
//  Created by xinpinghuang on 12/30/15.
//  Copyright 2015 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"
#import "XPGiftCreateBottomView.h"
#import "XPGiftCreateViewController.h"
#import "XPGiftViewModel.h"
#import <XPKit/XPKit.h>
#import <MJRefresh.h>

@interface XPGiftCreateViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) IBOutlet XPGiftViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet XPGiftCreateBottomView *createBottomView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPGiftCreateViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.createBottomView bindViewModel:self.viewModel];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(0 == section) {
        return CGFLOAT_MIN;
    }
    
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section) {
        return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell_%ld_%ld", (long)indexPath.section, (long)indexPath.row] forIndexPath:indexPath];
    [cell bindViewModel:self.viewModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface

#pragma mark - Getter & Setter

@end
