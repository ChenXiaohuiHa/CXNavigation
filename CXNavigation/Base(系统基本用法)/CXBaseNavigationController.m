//
//  CXBaseNavigationController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/8/30.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXBaseNavigationController.h"

//当前系统版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
@interface CXBaseNavigationController ()

@end

@implementation CXBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
}
//设置导航栏
- (void)setNav {
    
    //设置导航标题颜色,大小
//    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blueColor]}];
    
    //是否使用半透明导航栏, 默认 YES
    //self.navigationBar.translucent = NO;
    
    //风格为 black (状态栏为白色)
//    self.navigationBar.barStyle = UIBarStyleDefault;
    
    //设置导航栏内容颜色
//    self.navigationBar.tintColor = [UIColor redColor];
    
    //设置NavBar的颜色, 默认 nil
//    self.navigationBar.barTintColor = [UIColor cyanColor];
    
    //设置NavBar背景图片
    //[self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //去除导航栏下方的横线(通过将shadowImage属性设为一个空的UIImage来实现隐藏分割线的效果。前提是导航栏的背景是用图片来设置的。)
    //[self.navigationBar setShadowImage:[[UIImage alloc]init]];
    //
    
    //设置全局返回按钮图片(好像不管用)
    //[[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"nav_back"]];
    //[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_back"]];
}

#pragma mark ---------- 修改系统返回按钮标题 ----------
//重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];

    //设置返回按钮标题, 去除返回按钮文字
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
}




@end
