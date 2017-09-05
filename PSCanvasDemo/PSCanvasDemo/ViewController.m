//
//  ViewController.m
//  PSCanvasDemo
//
//  Created by Passing on 2017/8/6.
//  Copyright © 2017年 passing. All rights reserved.
//

#import "ViewController.h"
#import "SignatureView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *tipLb = [UILabel new];
    tipLb.font = [UIFont systemFontOfSize:16.];
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.text = @"点击任意位置开始签名";
    tipLb.frame = self.view.bounds;
    [self.view addSubview:tipLb];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self showSignatureView];
}

-(void)showSignatureView
{
    [SignatureView showWithTitle:@"退款操作人员签名" completion:^(UIImage *img){
//        [self uploadSignatureWithImage:img];
    }];
}

@end
