//
//  ClClockRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/2/1.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "ClClockRefreshHeader.h"
#import "CLClockLoadingView.h"
#import "UIView+CLCommon.h"
@implementation ClClockRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLClockLoadingView *loadingView = [CLClockLoadingView loadingView];
        self.loadingView = loadingView;
        [self addSubview:self.loadingView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat loadingViewWH = 30.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, 0, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
}



@end
