//
//  CzyTranstion.m
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "CzyTranstion.h"

@interface CzyTranstion ()
//转场上下文
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
//起点
@property (nonatomic, assign) CGRect startRect;

@end

@implementation CzyTranstion

#pragma mark - init
+ (instancetype)transtionAnimationWithType:(CZYTranstionType)type fromController:(id)fromController endController:(id)endController andstartRect:(CGRect)startRect
{
    return [[self alloc] initWithTrasitionAnimationType:type fromController:fromController endController:endController andstartRect:startRect];
}

- (instancetype)initWithTrasitionAnimationType:(CZYTranstionType)type fromController:(UIViewController *)fromController endController:(UIViewController *)endController andstartRect:(CGRect)startRect
{
    if (self = [super init]) {
        
        self.type = type;
        self.startRect = startRect;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    switch (self.type) {
        case CZYTranstionTypeShow:
            
            //show
            [self showAnimationWithTransitionContext:transitionContext];
            
            break;
        case CZYTranstionTypeDismiss:
            
            //dismiss
            [self dismissAnimationWithTransitionContext:transitionContext];
            
            break;
        default:
            break;
    }
}

#pragma mark - show
- (void)showAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    //注意添加顺序 从动画开始到结束的方向
//    [containerView addSubview:fromVc.view];
//    [containerView addSubview:toVc.view];
    [containerView insertSubview:toVc.view aboveSubview:fromVc.view];
    
    //画圆
    UIBezierPath *startCirclePath = [UIBezierPath bezierPathWithOvalInRect:self.startRect];
    
    //区域大于屏幕宽高即可 1000
    UIBezierPath *endCirclrPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.startRect, -800, -800)];
    
    //覆盖层
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCirclrPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    //动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(startCirclePath.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endCirclrPath.CGPath);
    pathAnimation.duration = [self transitionDuration:transitionContext];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //动画的代理
    pathAnimation.delegate = self;
    
    [maskLayer addAnimation:pathAnimation forKey:@"show"];
}

#pragma mark - dismiss
- (void)dismissAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transionView = [transitionContext containerView];
    
    //添加顺序按照动画的方向
    [transionView insertSubview:toVc.view aboveSubview:fromVc.view];

    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.startRect, -800, -800)];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:self.startRect];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [maskLayer addAnimation:animation forKey:@"dismiss"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //完成transition 才能继续下次
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    //移除蒙层
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}

@end
