//
//  TasteResultViewController.m
//  XPApp
//
//  Created by Pua on 16/5/30.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteResultViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <Foundation/Foundation.h>
#import <XPKit/XPKit.h>
#import "TasteViewModel.h"
#import "UIView+XPEmptyData.h"
#import "TasteMainTBCell.h"
#import "TasteFindViewController.h"
#import "TasteMainModel.h"
#import "TasteDetailViewController.h"
#import "TasteShowCell.h"
@interface TasteResultViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *headView;
    UIButton *backButton;
    UIImageView *searchView;
    UIButton *headButton;
    UILabel *searchLabel;
    TasteMainModel *tasteMainModel;
}
@property (strong, nonatomic)  TasteViewModel *TasteVModel;
@property (strong, nonatomic)  UITableView *tableView;

@end
@implementation TasteResultViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.view.backgroundColor =  [UIColor whiteColor];
    
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.userInteractionEnabled = YES;
    [self.view addSubview:headView];
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"searh_Result_Back"] forState:UIControlStateNormal];
    [headView addSubview:backButton];
    searchLabel = [[UILabel alloc]init];
    searchLabel.text = self.storeName;
    searchLabel.font = [UIFont systemFontOfSize:12];
    searchView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"taste_search_searchbarBg"]];
    [headView addSubview:searchView];
    [searchView addSubview:searchLabel];
    headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = headView.frame;
    [headView addSubview:headButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left).with.offset(15);
        make.centerY.equalTo(headView);
    }];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.mas_right).with.offset(15);
        make.centerY.equalTo(headView);
    }];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(searchView);
        make.centerY.equalTo(searchView);
    }];
    
    [[headButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    _TasteVModel=[[TasteViewModel alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView hideEmptySeparators];
    @weakify(self);
    [self rac_liftSelector:@selector(cleverLoader:) withSignals:RACObserve(self.TasteVModel, executing), nil];
    [self rac_liftSelector:@selector(showToastWithNSError:) withSignals:[[RACObserve(self.TasteVModel, error) ignore:nil] map:^id (id value) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return value;
    }], nil];

    [[RACObserve(self.TasteVModel, finished)ignore:@(NO)]subscribeNext:^(id x) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    [[RACObserve(self.TasteVModel, list) ignore:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    [[RACSignal combineLatest:@[[RACObserve(self.TasteVModel, list) ignore:@(NO)], [RACObserve(self.TasteVModel, finished) ignore:nil]] reduce:^id (NSMutableArray *list, NSNumber *finishd){
        return @([finishd boolValue] && list.count == 0);
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if([x boolValue]) {
            [self.tableView showEmptyData];
        } else {
            [self.tableView destoryEmptyData];
        }
    }];
    self.TasteVModel.storeName=self.storeName;
    self.TasteVModel.dishName=@"";
    self.TasteVModel.avgPrice=@"";
    self.TasteVModel.storeTag=@"";
    self.TasteVModel.storeType=@"";
    self.TasteVModel.storeArea= @"";
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.TasteVModel.reloadCommand execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.TasteVModel.moreCommand execute:nil];
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Delegate
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.TasteVModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"TasteShowCell";
    //自定义cell类
    TasteShowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TasteShowCell" owner:self options:nil] lastObject];
    }
//    TasteMainModel *model = self.TasteVModel.list[indexPath.row];
    
    [cell bindModel:self.TasteVModel.list[indexPath.row]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        TasteDetailViewController *detailVc = [[TasteDetailViewController alloc]init];
        detailVc.TModel = self.TasteVModel.list[indexPath.row];
        [self presentViewController:detailVc animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(TasteViewModel*)tasteFindModel{
    if(!_TasteVModel){
        _TasteVModel=[[TasteViewModel alloc]init];
    }
    return _TasteVModel;
}
@end
