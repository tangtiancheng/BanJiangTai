//
//  TastorderMenuViewController.m
//  XPApp
//
//  Created by 唐天成 on 16/7/12.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "TastorderMenuViewController.h"
#import "MXNavigationBarManager.h"
#import "TCorderMenuCell.h"
#define chipOrderGreenViewHeight 40
static NSString* TCorderMenuCellIdentifier = @"TCorderMenuCellIdentifier";

@interface TastorderMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView* tableView;

//绿色下单视图
@property (nonatomic, strong)UIView* chipOrderGreenView;

@end

@implementation TastorderMenuViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tableView.delegate = self;
//    self.collectionView.delegate=self;
//    [MXNavigationBarManager changeAlphaWithCurrentOffset:];
    
    //     [self initBarManager];
//    [MXNavigationBarManager reStore];
}

//- (void)initBarManager {
//    [MXNavigationBarManager managerWithController:self];
//    [MXNavigationBarManager setBarColor:[UIColor whiteColor]];
//    [MXNavigationBarManager setTintColor:[UIColor whiteColor]];
//    [MXNavigationBarManager setStatusBarStyle:UIStatusBarStyleDefault];
//    [MXNavigationBarManager setZeroAlphaOffset:0];
//    [MXNavigationBarManager setFullAlphaOffset:84];
//    [MXNavigationBarManager setFullAlphaTintColor:[UIColor blackColor]];
//    [MXNavigationBarManager setFullAlphaBarStyle:UIStatusBarStyleLightContent];
//}
//-(void)setTastOrderingModelArray:(NSArray<XPTastOrderingModel *> *)tastOrderingModelArray{
//    _tastOrderingModelArray=tastOrderingModelArray;
//    self.
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupchipOrderGreenView];
    self.title=@"点菜单";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searh_Result_Back"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarLeftClick)];
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.tableView.rowHeight=90;
    [self.tableView registerNib:[UINib nibWithNibName:@"TCorderMenuCell" bundle:nil] forCellReuseIdentifier:TCorderMenuCellIdentifier];
    
//    [MXNavigationBarManager changeAlphaWithCurrentOffset:84];
//    [self initBarManager];
    self.tableView.backgroundColor=RGBA(241, 241, 241, 1);
    self.tableView.tableFooterView=[UIView new];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setupTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-chipOrderGreenViewHeight) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
}
-(void)setupchipOrderGreenView{
    self.chipOrderGreenView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-chipOrderGreenViewHeight, ScreenW, chipOrderGreenViewHeight)];
    self.chipOrderGreenView.backgroundColor=RGBA(105, 199, 69, 1);
    UIButton* chipOrder = [[UIButton alloc]initWithFrame:self.chipOrderGreenView.bounds];
    [chipOrder setTitle:@"下单" forState:UIControlStateNormal];
    [self.chipOrderGreenView addSubview:chipOrder];
    
   
    [self.view addSubview:self.chipOrderGreenView];
    
    
}
-(void)navigationBarLeftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.tastOrderingModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCorderMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:TCorderMenuCellIdentifier forIndexPath:indexPath];
    XPTastOrderingModel *tastOrderingModel = self.tastOrderingModelArray[indexPath.row];
    [cell bindModel:tastOrderingModel];
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
