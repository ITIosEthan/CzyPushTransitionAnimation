//
//  UINavigationController+CzyTranstion.h
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CzyTranstion.h"

@interface UINavigationController (CzyTranstion)<UINavigationControllerDelegate>

/**
 转场操作类型
 */
@property (nonatomic, assign) CZYTranstionType type;



/**
 起始点
 */
@property (nonatomic, assign) CGRect startRect;



/**
 是否使用自定义转场动画
 */
@property (nonatomic, assign) BOOL customTransitionAnimation;


@end
