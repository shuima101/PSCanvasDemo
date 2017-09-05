//
//  UIView+HYBAnimation.m
//  HYBmerchant
//
//  Created by Passing on 2017/7/18.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "UIView+HYBAnimation.h"
#import <objc/runtime.h>

@interface UIView ()

@property(nonatomic, strong)UIView *alertMaskView;

@end

@implementation UIView (HYBAnimation)

static const char MaskViewKey = '\0';
-(void)setAlertMaskView:(UIView *)alertMaskView
{
    objc_setAssociatedObject(self, &MaskViewKey, alertMaskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)alertMaskView
{
    return objc_getAssociatedObject(self, &MaskViewKey);
}

- (void)scaleAnimationWithDuration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.95, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03, 1.05, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.98, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [self.layer addAnimation:animation forKey:nil];
}

-(void)scaleShowAnimationWithDuration:(CFTimeInterval)duration
{
    if (!self.alertMaskView) {
        self.alertMaskView = [UIView new];
        self.alertMaskView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.alertMaskView.backgroundColor = [UIColor blackColor];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *win in [windows reverseObjectEnumerator]) {
        if (win.windowLevel == UIWindowLevelNormal) {
            [win addSubview:self.alertMaskView];
            [win addSubview:self];
            self.alertMaskView.alpha = 0;
            [UIView animateWithDuration:0.15 animations:^{
                self.alertMaskView.alpha = 0.5;
            }];
            [self scaleAnimationWithDuration:duration];
            break;
        }
    }
}


-(void)rotateAnimationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration
{
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
}
-(void)rotateShowAnimationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration
{
    if (!self.alertMaskView) {
        self.alertMaskView = [UIView new];
        self.alertMaskView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.alertMaskView.backgroundColor = [UIColor blackColor];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *win in [windows reverseObjectEnumerator]) {
        if (win.windowLevel == UIWindowLevelNormal) {
            [win addSubview:self.alertMaskView];
            [win addSubview:self];
            self.alertMaskView.alpha = 0;
            [UIView animateWithDuration:0.15 animations:^{
                self.alertMaskView.alpha = 0.5;
            }];
            [self rotateAnimationWithAngle:duration duration:duration];
            break;
        }
    }
}

-(void)endShow
{
    [self.alertMaskView removeFromSuperview];
    [self removeFromSuperview];
}

@end
