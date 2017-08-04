//
//  SeconddViewController.m
//  CzySceneChaneAnimation
//
//  Created by macOfEthan on 17/8/3.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import "SeconddViewController.h"
#import "UINavigationController+CzyTranstion.h"

@interface SeconddViewController ()

@end

@implementation SeconddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
 
    self.navigationController.customTransitionAnimation = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
