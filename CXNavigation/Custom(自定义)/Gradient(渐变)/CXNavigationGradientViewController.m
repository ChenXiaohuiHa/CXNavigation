//
//  CXNavigationGradientViewController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXNavigationGradientViewController.h"
#import "CXGradientOneViewController.h"
#import "CXGradientTwoViewController.h"
#import "CXGradientThreeViewController.h"
@interface CXNavigationGradientViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXNavigationGradientViewController{
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"透明度渐变";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"透明度渐变(一)",@"透明度渐变(二)",@"透明度渐变(三)"];
    [self loadTableView];
}

- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [self.view addSubview:tableView];
}

#pragma mark ---------- UITableViewDelegate,UITableViewDataSource ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_identify];
    }
    
    //
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    vc.hidesBottomBarWhenPushed = YES;
    switch (indexPath.row) {
        case 0:
            vc.hidesBottomBarWhenPushed = NO;
            vc = [CXGradientOneViewController new];
            break;
        case 1:
            vc = [CXGradientTwoViewController new];
            break;
        case 2:
            vc = [CXGradientThreeViewController new];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
