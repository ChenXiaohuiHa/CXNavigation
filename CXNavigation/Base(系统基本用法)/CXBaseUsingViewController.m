//
//  CXBaseUsingViewController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/8/30.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBaseUsingViewController.h"

@interface CXBaseUsingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXBaseUsingViewController {
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"BaseUsing";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"是否使用半透明导航栏",@"导航栏风格",@"设置导航栏内容颜色",@"设置导航栏背景颜色",@"设置导航栏背景图片"];
    [self loadNav];
    [self loadTableView];
}
- (void)loadNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemTrash) target:self action:@selector(rightItemAction:)];
}
- (void)rightItemAction:(UIBarButtonItem *)sender {
    
    NSLog(@"%s",__func__);
}
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [self.view addSubview:tableView];
}
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
    UISwitch *sw = [[UISwitch alloc] init];
    sw.tag = indexPath.row;
    sw.center = CGPointMake(CGRectGetWidth(self.view.frame)-40, 30);
    [sw addTarget:self action:@selector(swChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:sw];

    //
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)swChanged:(UISwitch *)sw {
    
    switch (sw.tag) {
        case 0:
        {
            //是否使用半透明导航栏, 默认 YES
            self.navigationController.navigationBar.translucent = sw.on;
        }
            break;
        case 1:
        {
            //风格为 black (状态栏为白色)
            if (sw.on) {
                self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            }else{
                self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            }
        }
            break;
        case 2:
        {
            //设置导航栏内容颜色
            if (sw.on) {
                self.navigationController.navigationBar.tintColor = [UIColor redColor];
            }else{
                self.navigationController.navigationBar.tintColor = [UIColor blueColor];
            }
        }
            break;
        case 3:
        {
            //设置NavBar的颜色, 默认 nil
            if (sw.on) {
                self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
            }else{
                self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            }
        }
            break;
        case 4:
        {
            //设置NavBar背景图片
            if (sw.on) {
                
                UIImage *img = [UIImage imageNamed:@"nav_img_1.jpg"];
                [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
            }else{
                
                [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
