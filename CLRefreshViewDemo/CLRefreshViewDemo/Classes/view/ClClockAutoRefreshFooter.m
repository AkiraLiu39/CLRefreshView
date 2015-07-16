//
//  ClClockAutoRefreshFooter.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/7/16.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "ClClockAutoRefreshFooter.h"
#import "CLClockLoadingView.h"
#import "UIView+CLExtension.h"
#import "CLRefreshViewConstant.h"

@interface ClClockAutoRefreshFooter ()
@property (nonatomic,weak) UILabel *textLabel;

@end
@implementation ClClockAutoRefreshFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLClockLoadingView *loadingView = [CLClockLoadingView loadingView];
        self.loadingView = loadingView;
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.textLabel = label;
        self.unAutoLoadButtonTitle = @"没有更多数据了，点我重新加载";
        self.autoLoad = YES;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat loadingViewWH = 30.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, 0, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
    
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(loadingViewFrame);
    CGFloat labelW = self.cl_width;
    CGFloat labelH = self.cl_height - labelY;
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}



@end
