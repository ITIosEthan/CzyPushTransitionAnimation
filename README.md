### Usage：
##### To select system or custom animation in some viewController when you need to jump or pop. Is a freedom choose as you want.

### How to use：
```
#import "UINavigationController+CzyTranstion.h"
```
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //set the start rect
    self.navigationController.startRect = CGRectMake(point.x, point.y, 100, 100);
    
    //systen or custom animation as you want
    self.navigationController.customTransitionAnimation = YES;
    
    [self.navigationController pushViewController:[SeconddViewController new] animated:YES];
}

```

### sketch map
1.jump-custom pop-custom

![jump-custom pop-custom](https://github.com/ITIosEthan/CzyPushTransitionAnimation/blob/master/custom-custom.gif)

2.jump-custom pop-system

![jump-custom pop-system](https://github.com/ITIosEthan/CzyPushTransitionAnimation/blob/master/custom-system.gif)

3.jump-ststem pop-custom

![jump-ststem pop-custom](https://github.com/ITIosEthan/CzyPushTransitionAnimation/blob/master/system-custom.gif)
