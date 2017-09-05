//
//  UIView+HYBAnimation.h
//  HYBmerchant
//
//  Created by Passing on 2017/7/18.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYBAnimation)

- (void)scaleShowAnimationWithDuration:(CFTimeInterval)duration;

- (void)rotateShowAnimationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration;

- (void)endShow;



@end
