//
//  CXTestViewController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTestViewController.h"

@interface CXTestViewController ()

@end

@implementation CXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

@end
