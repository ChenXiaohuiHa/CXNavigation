//
//  CXAnimatedTransitionsNavigationController.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/18.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXAnimatedTransitionsNavigationController.h"

@interface CXAnimatedTransitionsNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CXAnimatedTransitionsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    CXAnimatedTransitioning *animation = [CXAnimatedTransitioning new];
    animation.animationType = _animationType;
    animation.operation = operation;
    return (id)animation;
}

@end
