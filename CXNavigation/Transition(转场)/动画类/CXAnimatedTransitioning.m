//
//  CXAnimatedTransitioning.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/20.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXAnimatedTransitioning.h"

@interface CXAnimatedTransitioning ()<UIViewControllerAnimatedTransitioning>

@end

@implementation CXAnimatedTransitioning

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operation = UINavigationControllerOperationNone;
    }
    return self;
}

#pragma mark ---------- UIViewControllerAnimatedTransitioning ----------
//动画执行时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}
//动画内容
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //起始页
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //容器视图
    UIView *containerView = transitionContext.containerView;
    
    //根据动画类型, 执行不同的动画效果
    if (self.animationType == CX_AnimationTypeNormal) {
        
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
        
        CATransform3D t = CATransform3DIdentity;
        t = CATransform3DRotate(t, M_PI / 2.0, 0.0, 1.0, 0.0);
        t.m34 = 1.0 / -2000;
        
        if (self.operation == UINavigationControllerOperationPush) {
            [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:toVC.view];
            [self setAnchorPoint:CGPointMake(0.0, 0.5) forView:fromVC.view];
        } else if (self.operation == UINavigationControllerOperationPop) {
            [self setAnchorPoint:CGPointMake(0.0, 0.5) forView:toVC.view];
            [self setAnchorPoint:CGPointMake(1.0, 0.5) forView:fromVC.view];
        }
        
        fromVC.view.layer.zPosition = 2.0;
        toVC.view.layer.zPosition = 1.0;
        toVC.view.layer.transform = t;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.layer.transform = t;
            toVC.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            fromVC.view.layer.zPosition = 0.0;
            toVC.view.layer.zPosition = 0.0;
            [transitionContext completeTransition:YES];
        }];
    }else if (self.animationType == CX_AnimationTypeFromTop) {
        
        [containerView addSubview:toVC.view];
        
        //起始页 和 目标页 的坐标大小
        CGRect fromViewStartFrame = [transitionContext initialFrameForViewController:fromVC];
        CGRect toViewEndFrame = [transitionContext finalFrameForViewController:toVC];
        //
        CGRect fromViewEndFrome = fromViewStartFrame;
        CGRect toViewStartFrame = toViewEndFrame;
        
        if (self.operation == UINavigationControllerOperationPush) {
            toViewStartFrame.origin.y -= toViewEndFrame.size.height;
        }else if (self.operation == UINavigationControllerOperationPop) {
            fromViewEndFrome.origin.y -= fromViewStartFrame.size.height;
            [containerView sendSubviewToBack:toVC.view];
        }
        //这里可以自定义动画
        fromVC.view.frame = fromViewStartFrame;
        toVC.view.frame = toViewStartFrame;
        
        //动画
        CGFloat duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            
            fromVC.view.frame = fromViewEndFrome;
            toVC.view.frame = toViewEndFrame;
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
        }];
    }else if (self.animationType == CX_AnimationType3DTransition) {
        
        UIView *fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        fromSnapshot.frame = fromVC.view.frame;
        [containerView insertSubview:fromSnapshot aboveSubview:fromVC.view];
        [fromVC.view removeFromSuperview];
        
        toVC.view.frame = fromSnapshot.frame;
        [containerView insertSubview:toVC.view belowSubview:fromSnapshot];
        
        CGFloat width = floorf(fromSnapshot.frame.size.width/2.0)+5.0;
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.20 animations:^{
                CATransform3D fromT = CATransform3DIdentity;
                fromT.m34 = 1.0 / -2000;
                fromT = CATransform3DTranslate(fromT, 0.0, 0.0, -590.0);
                fromSnapshot.layer.transform = fromT;
                
                CATransform3D toT = CATransform3DIdentity;
                toT.m34 = 1.0 / -2000;
                toT = CATransform3DTranslate(fromT, 0.0, 0.0, -600.0);
                toVC.view.layer.transform = toT;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.20 relativeDuration:0.20 animations:^{
                if (self.operation == UINavigationControllerOperationPush) {
                    fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, -width, 0.0, 0.0);
                    toVC.view.layer.transform = CATransform3DTranslate(toVC.view.layer.transform, width, 0.0, 0.0);
                } else if (self.operation == UINavigationControllerOperationPop) {
                    fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, width, 0.0, 0.0);
                    toVC.view.layer.transform = CATransform3DTranslate(toVC.view.layer.transform, -width, 0.0, 0.0);
                }
            }];
            [UIView addKeyframeWithRelativeStartTime:0.40 relativeDuration:0.20 animations:^{
                fromSnapshot.layer.transform = CATransform3DTranslate(fromSnapshot.layer.transform, 0.0, 0.0, -200);
                toVC.view.layer.transform = CATransform3DTranslate(toVC.view.layer.transform, 0.0, 0.0, 500);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.60 relativeDuration:0.20 animations:^{
                CATransform3D fromT = fromSnapshot.layer.transform;
                CATransform3D toT = toVC.view.layer.transform;
                if (self.operation == UINavigationControllerOperationPush) {
                    fromT = CATransform3DTranslate(fromT, floorf(width), 0.0, 200.0);
                    toT = CATransform3DTranslate(fromT, floorf(-(width*0.03)), 0.0, 0.0);
                } else if (self.operation == UINavigationControllerOperationPop) {
                    fromT = CATransform3DTranslate(fromT, floorf(-width), 0.0, 200.0);
                    toT = CATransform3DTranslate(fromT, floorf(width*0.03), 0.0, 0.0);
                }
                fromSnapshot.layer.transform = fromT;
                toVC.view.layer.transform = toT;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.80 relativeDuration:0.20 animations:^{
                toVC.view.layer.transform = CATransform3DIdentity;
            }];
        } completion:^(BOOL finished) {
            [fromSnapshot removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = oldOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

@end
