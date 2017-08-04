//
//  ViewController.m
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "ViewController.h"
#import "SeconddViewController.h"
#import "UINavigationController+CzyTranstion.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //设置圆圈起点
    self.navigationController.startRect = CGRectMake(point.x, point.y, 100, 100);
    
    //是否用自定义转场动画
    self.navigationController.customTransitionAnimation = YES;
    
    [self.navigationController pushViewController:[SeconddViewController new] animated:YES];
}



@end
