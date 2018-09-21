//
//  CXGradientThreeViewController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXGradientThreeViewController.h"
#import "CXGradientThreeNavigationView.h"

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface CXGradientThreeViewController ()<UITableViewDataSource,UITableViewDelegate,CXGradientThreeNavigationViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, assign) float backImgHeight;
@property (nonatomic, assign) float backImgWidth;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) CXGradientThreeNavigationView *navView; //导航栏视图

@end

@implementation CXGradientThreeViewController {
    UIImageView *_headerImg;
    UILabel *_nameLabel;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self backImageView];
    [self initNavView];
    [self loadTableView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置状态栏默认色
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark 导航(在导航的位置盖一层 View)
- (void)initNavView {
    self.navView = [[CXGradientThreeNavigationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    self.navView.title = @"我的";
    self.navView.color = [UIColor whiteColor];
    self.navView.left_bt_Img = @"tab_home";
    self.navView.right_bt_Img = @"tab_mine";
    self.navView.delegate = self;
    [self.view addSubview:self.navView];
}
#pragma mark 设置表头背景图片
- (void)backImageView{
    UIImage *image = [UIImage imageNamed:@"headerBg"];
    
    _backgroundImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), image.size.height*0.8)];
    _backgroundImgV.image = image;
    _backgroundImgV.userInteractionEnabled = YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight = _backgroundImgV.frame.size.height;
    _backImgWidth = _backgroundImgV.frame.size.width;
}
#pragma mark 加载 tableView
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    [tableView setTableHeaderView:[self headImageView]];
}
#pragma mark 在表头中添加头像 img 和 昵称 label, 并添加相应的手势
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 170);
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.userInteractionEnabled = YES;
        
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-35, 50, 70, 70)];
        _headerImg.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 70);
        [_headerImg setImage:[UIImage imageNamed:@"headerImg.jpg"]];
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor = [UIColor whiteColor];
        _headerImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *header_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(header_tap_Click:)];
        [_headerImg addGestureRecognizer:header_tap];
        [_headImageView addSubview:_headerImg];
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 105, 20)];
        _nameLabel.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 125);
        _nameLabel.text = @"南笙";
        _nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *nick_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nick_tap_Click:)];
        [_nameLabel addGestureRecognizer:nick_tap];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_headImageView addSubview:_nameLabel];
    }
    return _headImageView;
}
#pragma mark 自定义导航左右点击协议
//左按钮
-(void)NaViewLeft {
    NSLog(@"左按钮");
}
//右按钮
-(void)NNaViewRight {
    NSLog(@"右按钮");
}
#pragma mark 表头手势事件
//头像
-(void)header_tap_Click:(UITapGestureRecognizer *)tap {
    NSLog(@"头像");
}
//昵称
-(void)nick_tap_Click:(UIButton *)item {
    NSLog(@"昵称");
}
#pragma mark tableView 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cell_identifier = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据-%ld", (long)indexPath.row];
    return cell;
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= 170) {
        self.navView.headBackImgView.alpha = offsetY/170;
        self.navView.left_bt_Img = @"tab_home";
        self.navView.right_bt_Img = @"tab_mine";
        self.navView.color = kColor(0, 0, 0, offsetY/170);
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }else{
        self.navView.headBackImgView.alpha = 1;
        
        self.navView.left_bt_Img = @"tab_home_active";
        self.navView.right_bt_Img = @"tab_mine_active";
        self.navView.color = kColor(255, 81, 81, 1);
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    if (offsetY < 0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-offsetY;
        rect.size.width = _backImgWidth* (_backImgHeight-offsetY)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -offsetY;
        _backgroundImgV.frame = rect;
        
    }
    
    //    if (scrollView.contentOffset.y <= 0) {
    //        self.NavView.headBackView.alpha = ((240+scrollView.contentOffset.y)/140);
    //        _NavView.left_bt_Image = kMenuBTimg;
    //        _NavView.right_bt_Image = kSearchBTimg;
    //        _NavView.lab_alpha = _NavView.headBackView.alpha;
    //
    //        if (self.NavView.headBackView.alpha >= 1) {
    //
    //            _NavView.lab_alpha = 1;
    //            _NavView.headBackView.alpha = 1;
    //            _NavView.left_bt_Image = kMenuBTimg;
    //            _NavView.right_bt_Image = kSearchBTimg;
    //        }
    //    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.navView.headBackImgView.alpha != 1) {
        
        return UIStatusBarStyleLightContent;
    }
    
    return UIStatusBarStyleDefault;
}

@end
