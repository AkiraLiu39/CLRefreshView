//
//  CLSimpleRefreshFooter.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/26.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLSimpleRefreshFooter.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
@implementation CLSimpleRefreshFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLCircleLoadingView *loadingView = [CLCircleLoadingView loadingView];
        [self addSubview:loadingView];
        self.loadingView = loadingView;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 5.0f;
    CGFloat loadingViewWH = self.cl_height - 2 * padding;
    CGFloat centerX = (self.cl_width - loadingViewWH) /2 ;
    CGFloat centerY = (self.cl_height - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(centerX, centerY, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
}
@end
