//
//  CXAnimatedTransitionsViewController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/8/30.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXAnimatedTransitionsViewController.h"
#import "CXAnimatedTransitionsNavigationController.h"
#import "CXTestViewController.h"
@interface CXAnimatedTransitionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXAnimatedTransitionsViewController{
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"AnimatedTransitions";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"Normal",@"FromTop",@"3DTransition"];
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
    
    CXAnimatedTransitionsNavigationController *nvc = (CXAnimatedTransitionsNavigationController *)self.navigationController;
    nvc.animationType = (CX_AnimationType)indexPath.row;
    //
    CXTestViewController *vc = [CXTestViewController new];
    
    
    [nvc pushViewController:vc animated:YES];
}

@end
