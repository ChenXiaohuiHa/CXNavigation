//
//  CXAnimatedTransitionsNavigationController.h
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/18.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXAnimatedTransitioning.h"
@interface CXAnimatedTransitionsNavigationController : UINavigationController

/** 动画类型 */
@property (nonatomic, assign) CX_AnimationType animationType;

@end
