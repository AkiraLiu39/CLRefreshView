//
//  CLRefreshFooterView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshFooter.h"
#import "UIView+CLCommon.h"
#import "UIScrollView+CLCommon.h"
#import "CLCircleLoadingView.h"
#import "CLRefreshViewConstant.h"
@implementation CLAbstractRefreshFooter
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLCircleLoadingView *loadingView = [CLCircleLoadingView loadingView];
        [self addSubview:loadingView];
        self.loadingView = loadingView;
        self.loadingWhenShow = NO;
    }
    return self;
}


-(void)adjustFrame{
    CGFloat scrollContentHeight = self.scrollView.cl_contentSizeHeight;
    CGFloat scrollViewHeight = self.scrollView.cl_height - self.scrollViewOriginalInsets.top - self.scrollViewOriginalInsets.bottom;
    self.cl_y = MAX(scrollContentHeight, scrollViewHeight);
//    self.cl_y = scrollContentHeight;
}

#pragma mark -overwrite
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:CLScrollViewContentSizeKeyPath];
    }
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:CLScrollViewContentSizeKeyPath options:NSKeyValueObservingOptionNew context:nil];
        [self adjustFrame];
    }
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (!self.userInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return;
    }
    if ([CLScrollViewContentSizeKeyPath isEqualToString:keyPath]) {
        [self adjustFrame];
    }else if ([CLScrollViewContentOffsetKeyPath isEqualToString:keyPath]){
        if (self.state == CLRefreshViewStateLoading) {
            return;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{

    CGFloat willShowOffsetY = self.cl_y - self.scrollView.cl_height;
    if (offset.y >= willShowOffsetY && self.cl_height != 0) {
        if (self.isLoadingWhenShow) {
            return 1.0f;
        }else{
            CGFloat progress = (offset.y-willShowOffsetY) / self.cl_height;
            return progress;
        }
    }else{
        return -1;
    }
}

-(void)refreshViewChangeUIWhenFinishLoading{
    self.scrollView.cl_contentInsetBottom = self.scrollViewOriginalInsets.bottom;
}
-(void)refreshViewChangeUIWhenWillLoading{
    
}
-(void)refreshViewChangeUIWhenLoading{
    [UIView animateWithDuration:self.isLoadingWhenShow ? CLRefreshAnimationDurationZero : CLRefreshAnimationDurationFast animations:^{
        CGFloat bottom = self.cl_height + self.scrollViewOriginalInsets.bottom;
        self.scrollView.cl_contentInsetBottom = bottom;
    }];
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
