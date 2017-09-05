//
//  FreeDrawView.m
//  HYBmerchant
//
//  Created by Passing on 2017/7/18.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "PSCanvasView.h"

@interface PSCanvasView ()

@property(nonatomic, copy) UIBezierPath *bPath;

@property(nonatomic, strong) NSMutableArray *paths;

@property(nonatomic, strong) NSMutableArray *backPaths;

@end

@implementation PSCanvasView

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}

-(void)clearAllPaths
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)back
{
    if (self.paths.count) {
        [self.backPaths addObject:self.paths.lastObject];
        [self.paths removeLastObject];
        [self setNeedsDisplay];
    }
}

-(void)forward
{
    if (self.backPaths.count) {
        [self.paths addObject:self.backPaths.firstObject];
        [self.backPaths removeObjectAtIndex:0];
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //绘制背景色
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    // Drawing code
    for (UIBezierPath *path in self.paths) {
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1];
        [color setStroke];
        [path stroke];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects].lastObject;
    CGPoint startPoint = [touch locationInView:self];
    [self.bPath moveToPoint:startPoint];
    [self.paths addObject:self.bPath];
    
    [self.backPaths removeAllObjects];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches allObjects].lastObject;
    CGPoint newPoint = [touch locationInView:self];
    [self.bPath addLineToPoint:newPoint];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.bPath = nil;
}

-(UIBezierPath *)bPath
{
    if (!_bPath) {
        _bPath = [UIBezierPath bezierPath];
        _bPath.lineJoinStyle = kCGLineJoinRound;
        _bPath.lineCapStyle = kCGLineCapRound;
        _bPath.lineWidth = 2.f;
    }
    return _bPath;
}

-(NSMutableArray *)paths
{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

-(NSMutableArray *)backPaths
{
    if (!_backPaths) {
        _backPaths = [NSMutableArray array];
    }
    return _backPaths;
}

-(NSUInteger)pathCount
{
    return self.paths.count;
}

-(UIImage *)snapImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,YES,[UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapImage;
}

@end
