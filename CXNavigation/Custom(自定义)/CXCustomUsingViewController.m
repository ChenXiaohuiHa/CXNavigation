//
//  CXCustomUsingViewController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/8/30.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXCustomUsingViewController.h"
#import "CXNavigationGradientViewController.h"
#import "CXNavigationImageMoveViewController.h"
@interface CXCustomUsingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXCustomUsingViewController {
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"CustomNUsing";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"透明度渐变",@"表头+导航 view 的头像动画"];
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
    
    switch (indexPath.row) {
        case 0:
            vc = [CXNavigationGradientViewController new];
            break;
        case 1:
            vc = [CXNavigationImageMoveViewController new];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
