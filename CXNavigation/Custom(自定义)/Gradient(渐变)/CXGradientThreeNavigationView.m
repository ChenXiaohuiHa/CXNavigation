//
//  CXGradientThreeNavigationView.m
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXGradientThreeNavigationView.h"

@interface CXGradientThreeNavigationView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIButton *rightBt;

@end

@implementation CXGradientThreeNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //清除 self 的背景颜色
        self.backgroundColor = [UIColor clearColor];
        //添加 imgView, 并设置透明度为 0
        self.headBackImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBackImgView.backgroundColor = [UIColor whiteColor];
        self.headBackImgView.alpha = 0;
        [self addSubview:self.headBackImgView];
        //左按钮
        self.leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.backgroundColor = [UIColor clearColor];
        self.leftBt.frame = CGRectMake(5, 20, 44, 44);
        [self.leftBt addTarget:self action:@selector(leftBtAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftBt];
        
        //设置标题
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleLab];
        //右按钮
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.backgroundColor = [UIColor clearColor];
        self.rightBt.frame = CGRectMake(self.frame.size.width-46, 30, 30, 30);
        [self.rightBt addTarget:self action:@selector(rightBtAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBt];
        
    }
    return self;
}
#pragma mark 设置左边按钮图片
- (void)setLeft_bt_Img:(NSString *)left_bt_Img {
    _left_bt_Img = left_bt_Img;
    [self.leftBt setImage:[UIImage imageNamed:_left_bt_Img] forState:UIControlStateNormal];
}
#pragma mark 设置右边按钮图片
- (void)setRight_bt_Img:(NSString *)right_bt_Img {
    _right_bt_Img = right_bt_Img;
    [self.rightBt setImage:[UIImage imageNamed:_right_bt_Img] forState:UIControlStateNormal];
}
#pragma mark 设置标题内容
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}
#pragma mark 设置标题颜色
- (void)setColor:(UIColor *)color {
    _color = color;
    self.titleLab.textColor = color;
}
#pragma mark 左边按钮点击事件
- (void)leftBtAction {
    if ([self.delegate respondsToSelector:@selector(NaViewLeft)]) {
        [self.delegate NaViewLeft];
    }
}
#pragma mark 右边按钮点击事件
- (void)rightBtAction {
    if ([self.delegate respondsToSelector:@selector(NaViewRight)]) {
        [self.delegate NaViewRight];
    }
}

@end
