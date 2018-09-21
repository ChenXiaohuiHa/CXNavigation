//
//  CXAnimatedTransitioning.h
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/20.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CX_AnimationType) {
    CX_AnimationTypeNormal,
    CX_AnimationTypeFromTop,
    CX_AnimationType3DTransition
};

@interface CXAnimatedTransitioning : NSObject

/** 动画类型 */
@property (nonatomic, assign) CX_AnimationType animationType;
/** push / pop 操作 */
@property (nonatomic,assign) UINavigationControllerOperation operation;

@end
