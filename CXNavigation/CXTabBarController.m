//
//  CXTabBarController.m
//  Navigation(导航)
//
//  Created by 陈晓辉 on 2018/8/30.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXBaseUsingViewController.h"
#import "CXCustomUsingViewController.h"
#import "CXAnimatedTransitionsViewController.h"
//
#import "CXBaseNavigationController.h"//基本导航
#import "CXAnimatedTransitionsNavigationController.h"//导航动画
@interface CXTabBarController ()

@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
}

#pragma mark ---------- 常规写法 ----------
- (void)setUpTabBar {
    
    UIColor *titleColor = [UIColor redColor];
    
    //第一个页面
    CXBaseUsingViewController *oneVC = [[CXBaseUsingViewController alloc] init];
    CXBaseNavigationController *oneNav = [[CXBaseNavigationController alloc] initWithRootViewController:oneVC];
    oneNav.tabBarItem = [self setTabBarItemWithTitle:@"BaseNavigatione" titleColor:titleColor image:@"home" selectedImage:@"home_Click"];
    
    //第二个页面
    CXCustomUsingViewController *twoVC = [[CXCustomUsingViewController alloc] init];
    CXBaseNavigationController *twoNav = [[CXBaseNavigationController alloc] initWithRootViewController:twoVC];
    twoNav.tabBarItem = [self setTabBarItemWithTitle:@"CustomNavigation" titleColor:titleColor image:@"tab_new" selectedImage:@"tab_new_Click"];
    
    //第三个页面
    CXAnimatedTransitionsViewController *threeVC = [[CXAnimatedTransitionsViewController alloc] init];
    CXAnimatedTransitionsNavigationController *threeNav = [[CXAnimatedTransitionsNavigationController alloc] initWithRootViewController:threeVC];
    threeNav.tabBarItem = [self setTabBarItemWithTitle:@"AnimatedTransitions" titleColor:titleColor image:@"tab_my" selectedImage:@"tab_my_Click"];
    
    //添加 VC 数组, 设置 tabBar
    NSArray *navArr = @[oneNav,twoNav,threeNav];
    self.viewControllers = navArr;
    
    //设置背景图片
    //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    //去除 TabBar 自带的顶部阴影  去掉顶部黑线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // Bar 的color，设置图片无效
    // [UITabBar appearance].barTintColor = [UIColor yellowColor];
    
    //设置默认选中
    self.selectedIndex = 0;
}
#pragma mark ---------- 设置 item 属性 ----------
- (UITabBarItem *)setTabBarItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image selectedImage:(NSString *)selctedImage  {
    
    static NSInteger index = 0;
    UITabBarItem *item = [[UITabBarItem alloc] init];
    item.tag = index;
    index++;
    if (title) { //设置 item 标题
        [item setTitle:title];
    }
    if (titleColor) { //设置 item 点击颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: titleColor}
                            forState:UIControlStateSelected];
    }
    if (image) { //设置 item 常态图片
        [item setImage:[UIImage imageNamed:image]];
    }
    if (selctedImage) { //设置 item 点击图片
        [item setSelectedImage:[[UIImage imageNamed:selctedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    //item.badgeValue = @"123";// 提示数字
    //item.titlePositionAdjustment = UIOffsetMake(-2, -2);// 文字偏移
    return item;
}


@end
