//
//  CXGradientThreeNavigationView.h
//  CXNavigation
//
//  Created by 陈晓辉 on 2018/9/21.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXGradientThreeNavigationViewDelegate <NSObject>

@optional
- (void)NaViewLeft;
- (void)NaViewRight;

@end

@interface CXGradientThreeNavigationView : UIView

@property (nonatomic, assign) id<CXGradientThreeNavigationViewDelegate>delegate;

@property(nonatomic, strong)UIImageView *headBackImgView;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)UIColor *color;
@property(nonatomic, strong)NSString *left_bt_Img;
@property(nonatomic, strong)NSString *right_bt_Img;

@end
