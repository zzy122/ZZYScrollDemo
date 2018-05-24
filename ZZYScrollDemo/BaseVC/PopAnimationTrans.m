//
//  PopAnimationTrans.m
//  test
//
//  Created by zzy on 16/12/27.
//  Copyright © 2016年 zzy. All rights reserved.
//

#import "PopAnimationTrans.h"

@implementation PopAnimationTrans
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;//转场时间
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //转场动作
//    UIView* container = [transitionContext containerView];
//    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewControllerKey];
//    UIView* toView = [transitionContext viewForKey:UITransitionContextToViewControllerKey];
//    fromView.frame = CGRectMake(0, 0, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame));
//    toView.frame = CGRectMake(-CGRectGetWidth(container.frame), 0, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame));
//    //动画
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromView.frame = CGRectMake(CGRectGetWidth(container.frame), 0, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame));
//        toView.frame = CGRectMake(0, 0, CGRectGetWidth(container.frame), CGRectGetHeight(container.frame));
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:[transitionContext transitionWasCancelled]];
//    }];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = CGRectMake(-CGRectGetWidth(containerView.bounds), 0, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds));
    
    fromView.frame = CGRectMake(0, 0, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds));
    
    [containerView addSubview:toView];
    [containerView insertSubview:fromView aboveSubview:toView];
    if ([transitionContext transitionWasCancelled]) {
        NSLog(@"取消");
    }
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds));
        fromView.frame = CGRectMake(CGRectGetWidth(containerView.bounds), 0, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds));
    } completion:^(BOOL finished) {
//        [fromView removeFromSuperview];
//        fromViewVC = nil;
        if (finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }
    }];

}

@end
