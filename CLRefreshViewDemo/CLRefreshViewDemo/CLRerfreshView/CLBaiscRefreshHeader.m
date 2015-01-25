//
//  CLBaiscRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/25.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLBaiscRefreshHeader.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
@implementation CLBaiscRefreshHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    };
    return self;
}
-(void)setup{
    CLAbstractLoadingView *loadingView = [CLCircleLoadingView loadingView];
    [self addSubview:loadingView];
    self.loadingView = loadingView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGPoint center = [self.superview convertPoint:self.center toView:nil];
    CGFloat paddingX = 10.0f;
    CGFloat paddingY = 15.0f;
    CGFloat loadingViewWH = self.cl_height - 2 * paddingY;
    CGRect loadingViewFrame = CGRectMake(paddingX, paddingY, loadingViewWH, loadingViewWH);

    self.loadingView.frame = loadingViewFrame;
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.loadingView.center = center;
}


@end
