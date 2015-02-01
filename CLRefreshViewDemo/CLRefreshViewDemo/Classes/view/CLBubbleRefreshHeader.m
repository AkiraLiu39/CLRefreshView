//
//  CLBubbleRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/30.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLBubbleRefreshHeader.h"
#import "CLBubbleLoadingView.h"
#import "UIView+CLCommon.h"
@implementation CLBubbleRefreshHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLBubbleLoadingView *loadingView = [CLBubbleLoadingView loadingView];
        loadingView.bubbleColor = [[UIColor alloc]initWithRed:18.0f/255.0f green:132/255.0f blue:140/255.0f alpha:1];
        [self addSubview:loadingView];
        self.loadingView = loadingView;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat loadingViewWH = 20.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGFloat loadingViewY = (self.cl_height - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, loadingViewY, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
}
@end
