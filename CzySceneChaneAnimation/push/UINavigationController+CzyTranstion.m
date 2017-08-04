//
//  UINavigationController+CzyTranstion.m
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "UINavigationController+CzyTranstion.h"
#import <objc/message.h>

static NSString * typeKey = @"typeKey";
static NSString * customTransitionAnimationKey = @"customTransitionAnimationKey";
static NSString * startRectKey = @"startRectKey";


@implementation UINavigationController (CzyTranstion)

#pragma mark - load
+ (void)load
{
    //push
    Method oldPush = class_getInstanceMethod(self.class, @selector(pushViewController:animated:));
    Method newPush = class_getInstanceMethod(self.class, @selector(czyPushViewController:animated:));
    method_exchangeImplementations(oldPush, newPush);
    
    //pop 有push之后可在UINavigationDelegate里判断分别设置
//    Method oldPop = class_getInstanceMethod(self.class, @selector(popViewControllerAnimated:));
//    Method newPop = class_getInstanceMethod(self.class, @selector(czyPopViewControllerAnimated:));
//    method_exchangeImplementations(oldPop, newPop);
}

#pragma mark - Setter and Getter
- (void)setType:(CZYTranstionType)type
{
    objc_setAssociatedObject(self, &typeKey, @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CZYTranstionType)type
{
    return (CZYTranstionType)objc_getAssociatedObject(self, &typeKey);
}

- (void)setStartRect:(CGRect)startRect
{
    objc_setAssociatedObject(self, &startRectKey, NSStringFromCGRect(startRect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)startRect
{
    return CGRectFromString(objc_getAssociatedObject(self, &startRectKey));
}

- (void)setCustomTransitionAnimation:(BOOL)customTransitionAnimation
{
    objc_setAssociatedObject(self, &customTransitionAnimationKey, @(customTransitionAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)customTransitionAnimation
{
    //注意需要转换为bool
    return [objc_getAssociatedObject(self, &customTransitionAnimationKey) boolValue];
}

#pragma mark - hook
- (void)czyPushViewController:(UIViewController *)controller animated:(BOOL)animated
{
    self.delegate = self;
    
    [self czyPushViewController:controller animated:animated];
}


//- (UIViewController *)czyPopViewControllerAnimated:(BOOL)animated
//{
//    return [self.navigationController czyPopViewControllerAnimated:animated];
//}

#pragma mark - <UINavgationControllerDelegate>
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //NSLog(@"self.customTransitionAnimation = %d", self.customTransitionAnimation);
    
    //system
    if (!self.customTransitionAnimation) {
        return nil;
    }
    
    //rect 默认终点 100
    if (CGRectEqualToRect(self.startRect, CGRectZero)) {
        self.startRect = CGRectMake(fromVC.view.center.x, fromVC.view.center.y, 100, 100);
    }
    
    //custom
    if (operation == UINavigationControllerOperationPush) {
        return [CzyTranstion transtionAnimationWithType:CZYTranstionTypeShow
                                         fromController:fromVC
                                          endController:toVC
                                           andstartRect:self.startRect];
    }else if (operation == UINavigationControllerOperationPop){
        return [CzyTranstion transtionAnimationWithType:CZYTranstionTypeDismiss
                                         fromController:fromVC
                                          endController:toVC
                                           andstartRect:self.startRect];
    }else{
        return nil;
    }
}


@end
