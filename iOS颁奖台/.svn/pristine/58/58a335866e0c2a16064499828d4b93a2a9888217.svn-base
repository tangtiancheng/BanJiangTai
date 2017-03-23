//
//  XPMessageWatchViewController.m
//  XPApp
//
//  Created by xinpinghuang on 1/23/16.
//  Copyright 2016 ShareMerge. All rights reserved.
//

#import "XPBaseTableViewCell.h"
#import "XPMessageModel.h"
#import "XPMessageViewModel.h"
#import "XPMessageWatchViewController.h"
#import <XPKit/XPKit.h>

@interface XPMessageWatchViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong) XPMessageViewModel *viewModel;
#pragma clang diagnostic pop
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XPMessageWatchViewController

#pragma mark - Life Circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView hideEmptySeparators];
    
    self.viewModel.messageId = [(XPMessageModel *)self.model messageId];
    [self.viewModel.readedCommand execute:nil];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = tableView.width;
    NSString *content = [(XPMessageModel *)self.model messageContent];
    CGSize size = [content findHeightForHavingWidth:width-49-8 andFont:[UIFont systemFontOfSize:12]];
    return size.height+33+12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XPBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [(XPMessageModel *)self.model setMessageRead:1];
    [cell bindModel:self.model];
    return cell;
}

#pragma mark - Event Responds

#pragma mark - Private Methods

#pragma mark - Public Interface
- (void)bindViewModel:(XPMessageViewModel *)viewModel
{
    NSParameterAssert([viewModel isKindOfClass:[XPMessageViewModel class]]);
    self.viewModel = viewModel;
}

#pragma mark - Getter & Setter

@end
