//
//  SignatureView.m
//
//  Created by Passing on 2017/7/20.
//  Copyright © 2017年 HYBiOS. All rights reserved.
//

#import "SignatureView.h"
#import "PSCanvasView.h"
#import "UIView+HYBAnimation.h"
#import "Alert.h"

@interface SignatureView ()

@property(nonatomic, strong) PSCanvasView *canvas;

@property(nonatomic, strong) UILabel *titleLb;

@property(nonatomic, copy) void(^didCompleteSignBlock)(UIImage *signImg);

@end

@implementation SignatureView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview
{
    self.layer.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    
    CGFloat factor = kIsPad ? 1 : kWidthScale;
    CGFloat titleHeigh = 60*factor;
    
    _canvas = [PSCanvasView new];
    _canvas.frame = CGRectMake(0, titleHeigh, self.bounds.size.width, self.bounds.size.height-titleHeigh);
    _canvas.backgroundColor = [UIColor whiteColor];
    [self addSubview:_canvas];
    
    _titleLb = [UILabel new];
    _titleLb.frame = CGRectMake((self.bounds.size.width-150)/2.0, 10, 150, titleHeigh-20);
    _titleLb.font = [UIFont systemFontOfSize:17];
    [self addSubview:_titleLb];
    
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(10, 10, 80, titleHeigh-20);
    [cancelBtn addTarget:self action:@selector(cancelSignature) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIButton *completeBtn = [UIButton buttonWithType:0];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [completeBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
    completeBtn.frame = CGRectMake(self.bounds.size.width-90, 10, 80, titleHeigh-20);
    [completeBtn addTarget:self action:@selector(completeSignature:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:completeBtn];
    
    CGFloat clearBtnHeight = (self.height-titleHeigh)/2.0;
    CGFloat clearBtnWidth = 60;

    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"xpay_icon_back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"撤销" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(self.width - clearBtnWidth, titleHeigh, clearBtnWidth, clearBtnHeight-0.5);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 10, 10);
    [backBtn addTarget:self action:@selector(signatureBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];

    UIButton *clearBtn = [UIButton buttonWithType:0];
    clearBtn.backgroundColor = [UIColor whiteColor];
    [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

//    [clearBtn setImage:[UIImage imageNamed:@"xpay_icon_back"] forState:UIControlStateNormal];
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    clearBtn.frame = CGRectMake(self.width - clearBtnWidth, backBtn.bottom+1.0, clearBtnWidth, clearBtnHeight);
    [clearBtn addTarget:self action:@selector(clearAllPaths) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:clearBtn];
}

+(void)showWithTitle:(NSString *)title completion:(void(^)(UIImage *img))completion
{
    SignatureView *signView = [[self alloc] initWithFrame:CGRectMake(30, 15, screenHeight-60, screenWidth-30)];
    signView.center = CGPointMake(screenWidth/2.0, screenHeight/2.0);
    signView.titleLb.text = title;
    signView.didCompleteSignBlock = completion;
    [signView rotateShowAnimationWithAngle:M_PI_2 duration:0.3];
}

-(void)cancelSignature
{
    [self.canvas clearAllPaths];
    [self endShow];
}

-(void)signatureBack
{
    [self.canvas back];
}

-(void)clearAllPaths
{
    [self.canvas clearAllPaths];
}

-(void)completeSignature:(UIButton *)btn
{
    if (self.canvas.pathCount < 1) {
        [Alert showAlert:@"您还没有签名" toView:self];
        return;
    }
    UIImage *signImg = self.canvas.snapImage;
    
    [self endShow];
    
    if (_didCompleteSignBlock) {
        _didCompleteSignBlock(signImg);
    }
    [self saveSignatureWithImage:signImg];
}

-(void)saveSignatureWithImage:(UIImage *)img
{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil)
    {
        [Alert showAlert:@"已保存"];
    }
    else
    {
        [Alert showAlert:@"未能保存到相册"];
    }
}

@end
