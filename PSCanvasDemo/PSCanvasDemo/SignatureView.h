//
//  SignatureView.h
//
//  Created by Passing on 2017/7/20.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureView : UIView

+(void)showWithTitle:(NSString *)title completion:(void(^)(UIImage *img))completion;

@end
