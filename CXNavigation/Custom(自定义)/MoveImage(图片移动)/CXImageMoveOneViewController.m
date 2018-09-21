//
//  CXImageMoveOneViewController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXImageMoveOneViewController.h"

@interface CXImageMoveOneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,assign) CGFloat offset;

@end

@implementation CXImageMoveOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"导航图片变换(一)";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    [self loadBgImageView];
    [self loadTableView];
}
- (void)configNav {
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去除导航栏下方的横线(通过将shadowImage属性设为一个空的UIImage来实现隐藏分割线的效果。前提是导航栏的背景是用图片来设置的。)
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}
- (void)loadBgImageView {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3)];
    imgView.image = [UIImage imageNamed:@"nav_img_4.jpg"];
    [self.view addSubview:imgView];
    self.imgView = imgView;
}
#pragma mark ---------- TableView ----------
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.view.frame)/3 - 64, 0, 0, 0);
    [self.view addSubview:tableView];
    
    self.offset = tableView.contentOffset.y;
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
    cell.textLabel.text = @"悠哉大王日常 - 喵帕斯壮汉";
    
    return cell;
}

#pragma mark ~~~~~~~~~~ ScrollViewDelegate ~~~~~~~~~~
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    
    NSLog(@"%f---%f",y,self.offset);
    CGRect frame = self.imgView.frame;
    if (y > self.offset) {
        NSLog(@"向上");
        self.title = @"";
        frame.origin.y = self.offset-y;
        if (y>=0) {
            frame.origin.y = self.offset;
            self.title = @"标题";
        }
        self.imgView.frame = frame;
    }
    // tableView设置偏移时不能立马获取他的偏移量，所以一开始获取的offset值为0
    else if (self.offset == 0) return;
    else {
        NSLog(@"向下");
        CGFloat x = self.offset - y;
        frame = CGRectMake(-x/2, -x/2, self.view.frame.size.width + x, self.view.frame.size.height/3+x);
        self.imgView.frame = frame;
    }
}

@end
