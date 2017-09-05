//
//  UIView+Frame.h
//  PSCanvasDemo
//
//  Created by Passing on 2017/8/6.
//  Copyright © 2017年 passing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)top;

- (void)setTop:(CGFloat)y;

- (CGFloat)right;

- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;

- (void)setBottom:(CGFloat)bottom;

- (CGFloat)left;

- (void)setLeft:(CGFloat)x;

-(void)setCenterY:(CGFloat)centerY;
- (CGFloat)centerY;


- (CGFloat)width;

- (CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (CGFloat)height;

- (void)setHeight:(CGFloat)height;





- (void)setBorderWidth:(CGFloat)with;

- (CGFloat)borderWidth;

- (void)setBorderColor:(UIColor *)color;

- (UIColor *)borderColor;

- (CGFloat)x;


- (CGPoint)origin;

- (CGSize)size;

- (void)setX:(CGFloat)x;

- (void)setY:(CGFloat)y;


- (void)setOrigin:(CGPoint)origin;

- (void)setSize:(CGSize)size;


-(void)setCenterX:(CGFloat)centerX;

-(CGFloat)centerX;

@end
