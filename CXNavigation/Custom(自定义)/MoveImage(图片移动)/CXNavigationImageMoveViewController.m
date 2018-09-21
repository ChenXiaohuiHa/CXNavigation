//
//  CXNavigationImageMoveViewController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXNavigationImageMoveViewController.h"
#import "UIView+Extension.h"

#define headImgWidth 55

@interface CXNavigationImageMoveViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CXNavigationImageMoveViewController {
    
    UIImageView *_headerImgView;//表头
    UIImageView *_bigImgView;//大图片
    UIImageView *_smallImgView;//小图片
    UIImageView *_navImageView;//导航图片
    CGFloat _needMoveY;//Y 需移动的范围
    CGFloat _moveMultiple;//图片大小缩放的倍数
    CGFloat _widthMultiple;//随着 Y 移动, 图片 X 需要减的值
    UILabel *_titleLabel;//需要显示的信息标签
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"表头+导航 view 的头像动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTableView];
    [self createNavView];
    [self dealPosition];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark ---------- UI ----------
//MARK: 创建一个 导航栏大小的 view
- (void)createNavView {
    
    _navImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    [self.view addSubview:_navImageView];
    
    //title
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 60, 34)];
    titleLable.centerX = _navImageView.centerX;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"我的";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:16];
    [titleLable sizeToFit];
    [_navImageView addSubview:titleLable];
    
    //小头像
    _smallImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    _smallImgView.centerY = titleLable.centerY;
    _smallImgView.x = titleLable.x -10 -30;
    [_navImageView addSubview:_smallImgView];
}
//MARK: 创建 tableView
- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.tableHeaderView = [self headerImgView];
    [self.view addSubview:tableView];
    
#pragma mark - 适配 iOS11
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
//MARK: tableView 表头视图
- (UIImageView *)headerImgView {
    
    _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 145)];
    _headerImgView.image = [UIImage imageNamed:@"headBg"];
    
    //头像
    _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _headerImgView.height-13-headImgWidth, headImgWidth, headImgWidth)];
    _bigImgView.image = [UIImage imageNamed:@"gestureHead"];
    [_headerImgView addSubview:_bigImgView];
    
    //名称
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bigImgView.max_X+30, _bigImgView.y, _bigImgView.width, _bigImgView.height)];
    _titleLabel.text = @"幻化成风";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_titleLabel sizeToFit];
    _titleLabel.centerY = _bigImgView.centerY;
    [_headerImgView addSubview:_titleLabel];
    
    return _headerImgView;
}

#pragma mark ---------- UITableView 协议方法 ----------
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
    
    cell.detailTextLabel.text = @"末日时在做什么?有没有空?可以来拯救吗?";
    //cell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(255))/255.0 green:(arc4random_uniform(255))/255.0 blue:(arc4random_uniform(255))/255.0 alpha:1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---------- 计算 ----------
//MARK: 计算大小图片移动的距离, 移动倍数(y 没移动1像素, 图片宽度变化多少)
- (void)dealPosition {
    
    /*
     1. 首先确定初始大小和结束大小
     2. 根据 Y 移动的距离, 确定图片的大小
     */
    
    //1 计算出 X 需要移动多少
    CGFloat needMoveX = _smallImgView.x - _bigImgView.x;//80
    
    //2 计算出 Y 需要移动多少(表头需要移动多少才能和导航重合)
    _needMoveY = _headerImgView.height - _navImageView.height;//81
    
    //3 根据需要移动的 X Y 两个参数, 计算出移动时图片大小缩放的倍数, 然后重新定义leftPadding(图片左边距的大小)
    _moveMultiple = _needMoveY/needMoveX;//1.0125
    
    //4. 计算出大小图宽的差
    CGFloat subWidth = _bigImgView.width - _smallImgView.width;//30
    
    //5. 根据差值, 以及移动的差值, 计算出移动时图片大小的缩放比
    _widthMultiple = subWidth/_needMoveY;//0.37037
}
#pragma mark ---------- UIScrollViewDelegate ----------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //获取移动的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    _navImageView.alpha = 1;
    
    //图片距左端有 25像素(最小距离); needMoveX = needMoveY / 倍数; 将 x 设置给大图
    CGFloat bigImgX = 25 + offsetY / _moveMultiple;
    //根据倍数, 计算图片移动过程中的宽度
    CGFloat imgWidth = headImgWidth - offsetY * _widthMultiple;
    
    //根据 Y 的偏移量来处理图片大小
    if (offsetY > _needMoveY) { //上拉到 与 导航重合,
        
        //直接显示导航图片 和 小图
        _navImageView.image = [UIImage imageNamed:@"mineNavBar"];
        _smallImgView.image = [UIImage imageNamed:@"gestureHead"];
    }else if (offsetY <= 0) { //下拉, 隐藏导航图片
        
        //下拉 40像素, 完全隐藏
        CGFloat imgAlpha = 1 + offsetY/40;
        _navImageView.alpha = imgAlpha;
        _bigImgView.frame = CGRectMake(25, _headerImgView.height-13-headImgWidth, headImgWidth, headImgWidth);
        _titleLabel.alpha = 1;
    }else{ //这里是 0 ~ _needMoveY 之间, 图片大小变换的移动中的范围
        
        _navImageView.image = nil;// [UIImage imageNamed:@""];
        _smallImgView.image = nil; //[UIImage imageNamed:@""];
        _bigImgView.frame = CGRectMake(bigImgX, _headerImgView.height-13-imgWidth, imgWidth, imgWidth);
        _titleLabel.x = _bigImgView.max_X + 30;
        _titleLabel.alpha = 1 - offsetY/_needMoveY;
    }
}

@end
