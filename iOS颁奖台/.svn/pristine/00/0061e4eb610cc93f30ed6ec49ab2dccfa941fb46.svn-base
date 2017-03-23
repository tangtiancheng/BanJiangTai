//
//  DishDetailViewController.m
//  XPApp
//
//  Created by Pua on 16/7/11.
//  Copyright © 2016年 ShareMerge. All rights reserved.
//

#import "DishDetailViewController.h"
#import "XPTastStoreModel.h"
#import "TastorderMenuViewController.h"

#define ImageHight 300.0f

@interface DishDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *dishTableView;
    UIImageView *_zoomImageView;
}
@end

@implementation DishDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _dishModel = [[XPDashInfoModel alloc]init];
    dishTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    dishTableView.delegate = self;
    dishTableView.dataSource = self;
    dishTableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    dishTableView.tableFooterView = [[UIView alloc]init];
    
    
    _zoomImageView = [[UIImageView alloc]init];
    
    [_zoomImageView setImageWithURL:[NSURL URLWithString:_dishModel.dashImg]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    _zoomImageView.autoresizesSubviews = YES;
//    [dishTableView addSubview:_zoomImageView];
    [dishTableView insertSubview:_zoomImageView atIndex:0];
    [self.view addSubview:dishTableView];
    _zoomImageView.userInteractionEnabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"navBar_left_white"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 30, 40, 40);
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_zoomImageView addSubview:button];
}
-(void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
    
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"这个自己命名"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"这个自己命名"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"创新特色菜"];
        cell.textLabel.text = self.dishModel.dashName;
        if([_dishModel.cutPrize isEqualToString:@""]){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",_dishModel.oldPrize];
        }else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",_dishModel.cutPrize];
        }
        
        cell.detailTextLabel.textColor=[UIColor redColor];
        
        
    }else{
        
        cell.textLabel.text = [NSString stringWithFormat:@"商品描述"];
        if(_dishModel.dashDescribe!=nil){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dishModel.dashDescribe];
        }else{
            cell.detailTextLabel.text = @"温馨提示:图片仅供参考,请以实物为准";
        }
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
