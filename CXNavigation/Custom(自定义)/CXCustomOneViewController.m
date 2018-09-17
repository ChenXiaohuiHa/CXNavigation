//
//  CXCustomOneViewController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/9/16.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCustomOneViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HeaderView_Height 150.f //表头高度

@interface CXCustomOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXCustomOneViewController {
    UIView *_navView;//导航 view
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"透明度渐变";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTableView];
    [self createNavView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark ---------- 导航位置创建 view ----------
- (void)createNavView {
    
    //覆盖导航栏位置
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    //标题
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.center = self.navigationController.navigationBar.center;
    titleLab.bounds = CGRectMake(0, 0, 100, 44);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"半夏";
//    [titleLab sizeToFit];
    [_navView addSubview:titleLab];
}
#pragma mark ---------- tableView ----------
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.tableHeaderView = [self headerView];
    [self.view addSubview:tableView];
    
#pragma mark - 适配 iOS11
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
//MARK: 表头
- (UIView *)headerView {
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), HeaderView_Height)];
    
    headerView.image = [UIImage imageNamed:@"nav_img_3.jpg"];
    return headerView;
}

#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_identify];
    }
    
    //
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 个 cell",indexPath.row];
    
    return cell;
}


#pragma mark ---------- ScrollViewDelegate ----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%.2f",offsetY);
    
    if (offsetY < (HeaderView_Height-64)) {
        
        //
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:offsetY/(HeaderView_Height-64)];
    }else{
        
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    }
}

@end
