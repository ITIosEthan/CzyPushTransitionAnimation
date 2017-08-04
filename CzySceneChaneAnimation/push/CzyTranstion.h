//
//  CzyTranstion.h
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CZYTranstionType) {

     CZYTranstionTypeShow = 0, // 显示
     CZYTranstionTypeDismiss   // 影藏
};

@interface CzyTranstion : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

/**
 转场操作类型
 */
@property (nonatomic, assign) CZYTranstionType type;


/**
 + init

 @param type type
 @param fromController fronVc
 @param endController toVc
 @param startRect startRect
 @return instance object
 */
+ (instancetype)transtionAnimationWithType:(CZYTranstionType)type
                            fromController:(id)fromController
                             endController:(id)endController
                              andstartRect:(CGRect)startRect;


/**
 - init
 
 @param type type
 @param fromController fronVc
 @param endController toVc
 @param startRect startRect
 @return instance object
 */
- (instancetype)initWithTrasitionAnimationType:(CZYTranstionType)type
                                fromController:(UIViewController *)fromController
                                 endController:(UIViewController *)endController
                                  andstartRect:(CGRect)startRect;

@end
