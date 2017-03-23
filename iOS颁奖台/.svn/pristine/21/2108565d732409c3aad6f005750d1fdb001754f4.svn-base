//
//  TasteFindViewController.m
//  XPApp
//
//  Created by Pua on 16/5/20.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TasteFindViewController.h"
#import "TasteFindViewModel.h"
#import "TasteSingleManager.h"
#import "TasteMainModel.h"
#import "TasteFindResultCell.h"
#import "TasteMainTBCell.h"
#import "TasteViewModel.h"
#import "TasteResultViewController.h"
#define fontCOLOR [UIColor colorWithRed:163/255.0f green:163/255.0f blue:163/255.0f alpha:1]
@interface TasteFindViewController()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *FindsearchBar;
    UITableView *SearchtableView;
    BOOL startFind;
    TasteFilterModel *tasteModel;
}
@property (nonatomic , strong) TasteFindViewModel *tasteFindModel;
@property (nonatomic , strong) TasteViewModel *TasteVModel;
@property (nonatomic,strong)NSMutableArray * searchHistory;
@property (nonatomic,strong)NSArray *myArray;//搜索记录的数组
@end

@implementation TasteFindViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    startFind = 0;
    [self readNSUserDefaults];
}
-(void)viewDidLoad
{    _searchHistory = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    tasteModel = [[TasteFilterModel alloc]init];
    FindsearchBar = [[UISearchBar alloc]init];
    FindsearchBar.frame = CGRectMake(10, 20, self.view.frame.size.width-80, 40);
    FindsearchBar.layer.cornerRadius = 20;
    FindsearchBar.delegate = self;
    FindsearchBar.keyboardType=UIKeyboardTypeDefault;
    FindsearchBar.placeholder = @"请输入商家或者商品名";
    UIButton *cannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cannelButton.frame = CGRectMake(self.view.frame.size.width-80, 20,80 , 40);
    [self.view addSubview:cannelButton];
    cannelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cannelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cannelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [[cannelButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:FindsearchBar];
    SearchtableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 20+40, self.view.size.width-20, self.view.frame.size.height-60) style:UITableViewStylePlain];
    SearchtableView.delegate = self;
    SearchtableView.dataSource = self;
    SearchtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:SearchtableView];
    /**
     *  去除背景色
     */
    for (UIView *view in FindsearchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            [FindsearchBar setBackgroundImage:[UIImage imageNamed:@"taste_search_board"]];
            [FindsearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"taste_search_searchbarBg"] forState:UIControlStateNormal];
            break;
        }
    }

}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self beginEditingWithItem];
    return YES;
}
#pragma mark开始编辑时leftAndright的设置

-(void)beginEditingWithItem{
//    for(id cc in [searchBar subviews]){
//        if([cc isKindOfClass:[UIButton class]]){
//            UIButton *btn = (UIButton *)cc;
//            [btn setTitle:@"取消"  forState:UIControlStateNormal];
//        }
//    }
}

#pragma mark searchBar Delegate Method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.tasteFindModel.searchText = searchBar.text;
    if (searchBar.text.length > 0) {
        
        [TasteSingleManager SearchText:searchBar.text];//缓存搜索记录
        [self readNSUserDefaults];
        
    }else{
        NSLog(@"请输入查找内容");
    }
    SearchtableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 20+40, self.view.size.width-20, self.view.frame.size.height-60) style:UITableViewStylePlain];
    SearchtableView.delegate = self;
    SearchtableView.dataSource = self;
    SearchtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:SearchtableView];
    [[self.tasteFindModel.filterCommand execute:nil]subscribeNext:^(id x) {
        [SearchtableView reloadData];
        [self searchBar:FindsearchBar textDidChange:nil];

    }];
    startFind = 1;
    [FindsearchBar resignFirstResponder];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
   
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [FindsearchBar resignFirstResponder];
    startFind = 0;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.tasteFindModel.searchText = searchBar.text;
    [[self.tasteFindModel.filterCommand execute:nil]subscribeNext:^(id x) {
        [SearchtableView reloadData];
        
    }];
}
#pragma mark -tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (startFind ==1) {
        return _tasteFindModel.list.count;

    }else{
        if (section==0) {
            if (_myArray.count>0) {
                return _myArray.count+1+1;
            }else{
                return 1;
            }
        }else{
            return 0;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (startFind == 1) {
    XPBaseTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"FindCell"];
        if (cell == nil) {
            cell=[[TasteFindResultCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FindCell"];
        }
    tasteModel = [[TasteFilterModel alloc]init];
    if (self.tasteFindModel.list.count !=0) {
        tasteModel = self.tasteFindModel.list[indexPath.row];
    }
        cell.textLabel.text = tasteModel.name;
        cell.detailTextLabel.text  =[NSString stringWithFormat:@"有%@个结果",tasteModel.count];
    return cell;
        }else{
    if (indexPath.section==0) {
        if(indexPath.row ==0){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"历史搜索";
            cell.textLabel.textColor = fontCOLOR;
            return cell;
        }else if (indexPath.row == _myArray.count+1){
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"清除历史记录";
            cell.textLabel.textColor = fontCOLOR;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }else{
            UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
            NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];
            cell.textLabel.text = reversedArray[indexPath.row-1];
            return cell;
        }
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
        return cell;
    }
        }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchtableView.estimatedRowHeight = 44.0f;
    //    self.searchTableView.estimatedRowHeight = 44.0f;
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (startFind == 1) {
        TasteResultViewController *tasteResultVC = [[TasteResultViewController alloc]init];
        tasteResultVC.storeName = FindsearchBar.text;
        [self presentViewController:tasteResultVC animated:YES completion:nil];

    }else{
        [SearchtableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == _myArray.count+1) {//清除所有历史记录
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除历史记录" message:@"" preferredStyle: UIAlertControllerStyleAlert];
            
            //@“ UIAlertControllerStyleAlert，改成这个就是中间弹出"
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [TasteSingleManager removeAllArray];
                _myArray = nil;
                [SearchtableView reloadData];
            }];
            //            UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            [alertController addAction:deleteAction];
            //            [alertController addAction:archiveAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            NSArray* reversedArray = [[_myArray reverseObjectEnumerator] allObjects];

            TasteResultViewController *tasteResultVC = [[TasteResultViewController alloc]init];
            tasteResultVC.storeName =  reversedArray[indexPath.row-1];
            [self presentViewController:tasteResultVC animated:YES completion:nil];

        }

    }
    
}


-(void)readNSUserDefaults{//取出缓存的数据
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray * myArray = [userDefaultes arrayForKey:@"myArray"];
    self.myArray = myArray;
    [SearchtableView reloadData];
    NSLog(@"myArray======%@",myArray);
}
-(TasteFindViewModel*)tasteFindModel{
    if(!_tasteFindModel){
        _tasteFindModel=[[TasteFindViewModel alloc]init];
    }
    return _tasteFindModel;
}
@end
