//
//  CLSimpleAutoRefreshFooter.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/30.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLSimpleAutoRefreshFooter.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
#import "UIScrollView+CLExtension.h"
@implementation CLSimpleAutoRefreshFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    CLAbstractLoadingView *loadView = [CLCircleLoadingView loadingView];
    self.autoLoad = YES;
    self.loadingView = loadView;
    self.unAutoLoadButtonTitle = @"没有更多数据了，点我重新加载";
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat loadingViewWH= 30;
    CGFloat centerX = (self.cl_width - loadingViewWH) /2 ;
    CGFloat centerY = (self.cl_height - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(centerX, centerY, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
}
@end
