//
//  FreeDrawView.h
//
//  Created by Passing on 2017/7/18.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface PSCanvasView : UIView

/** 擦除模式 */
@property(nonatomic, assign) BOOL eraserMode;
/**
 擦除的笔刷半径
 默认 10
*/
@property(nonatomic, assign) CGFloat eraserRadius;
/** 路径条数 */
@property(nonatomic, assign, readonly) NSUInteger pathCount;
/** 获取截图 */
@property(nonatomic, strong, readonly) UIImage *snapImage;

/** 清除所有路径 */
-(void)clearAllPaths;

/** 回退到上一条路径 */
-(void)back;

/**
 *  恢复一条已回退的路径
 *  注意: 绘制操作会清空已回退的路径
 */
-(void)forward;

@end
