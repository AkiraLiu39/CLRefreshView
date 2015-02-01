//
//  CLBaseRefershView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "CLAbstractRefreshView.h"
#import "CLAbstractLoadingView.h"
#import "UIView+CLCommon.h"
#import "CLRefreshViewConstant.h"
#import "UIScrollView+CLCommon.h"
#import "CLRefreshViewConstant.h"
@interface CLAbstractRefreshView ()
@end
@implementation CLAbstractRefreshView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


+(instancetype)refreshView{
    return [[self alloc]init];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:CLScrollViewContentOffsetKeyPath];
    }
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:CLScrollViewContentOffsetKeyPath options:NSKeyValueObservingOptionNew context:nil];
        self.cl_width = newSuperview.cl_width;
        self.cl_origin = [self willShowPoint];
        _scrollView  = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _scrollViewOriginalInsets = _scrollView.contentInset;
    }
}
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{
    return -1;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{    
    if (self.state == CLRefreshViewStateLoading) {
        return;
    }
    if ([keyPath isEqualToString:CLScrollViewContentOffsetKeyPath]) {
        if (!self.userInteractionEnabled || self.isHidden || self.alpha <=0.01) {return;}
        
        [self adjustState];
    }
}

-(void)adjustState{
    if (!self.window) {
        //未在window上画出，直接返回
        return;
    }
    CGFloat showProgress = [self showProgress:self.scrollViewOriginalInsets scrollViewOffset:self.scrollView.contentOffset];
    if (showProgress == -1) {
        return;
    }
    if (self.scrollView.isDragging) {
        //未松手
        self.loadingView.showProgress = showProgress;
        if (showProgress >= CLRefreshLoadingViewMaxProgress && self.state == CLRefreshViewStateNormal) {
            self.state = CLRefreshViewStateWillLoading;
        }else if (showProgress < CLRefreshLoadingViewMaxProgress && self.state == CLRefreshViewStateWillLoading){
            self.state = CLRefreshViewStateNormal;
        }
    }else{
        //松手
        if(self.state == CLRefreshViewStateWillLoading){
            self.state = CLRefreshViewStateLoading;
        }else if (self.state == CLRefreshViewStateNormal){
            self.loadingView.showProgress = showProgress;
        }
    }
}
-(void)setState:(CLRefreshViewState)state{
    if (state == self.state) {
        return;
    }
    _oldState = self.state;
    if (self.state != CLRefreshViewStateLoading) {
        _scrollViewOriginalInsets = self.scrollView.contentInset;
    }
    _state = state;
    
    if (self.state == CLRefreshViewStateNormal) {
        if (self.oldState == CLRefreshViewStateLoading) {
            [self.loadingView stopAnimation];
            self.loadingView.showProgress = CLRefreshLoadingViewMinProgress;
            self.loadingView.hidden = YES;
            [UIView animateWithDuration:CLRefreshAnimationDurationNormal animations:^{
                [self refreshViewChangeUIWhenFinishLoading];
            } completion:^(BOOL finished) {
                self.loadingView.hidden = NO;
                [self refreshViewChangeUIWhenNormal];
            }];
        }else{
            [self refreshViewChangeUIWhenNormal];
        }
    }else if(self.state == CLRefreshViewStateWillLoading){
        [self refreshViewChangeUIWhenWillLoading];
    }else if (self.state == CLRefreshViewStateLoading){
        self.loadingView.hidden = NO;
        self.loadingView.showProgress = CLRefreshLoadingViewMaxProgress;
        [self.loadingView startAnimation];
        [self refreshViewChangeUIWhenLoading];
        if (self.refreshAction) {
            self.refreshAction();
        }
        
    }
}

-(void)endRefresh{
    self.state = CLRefreshViewStateNormal;
}
-(void)startRefresh{
    if (self.window) {
        self.state = CLRefreshViewStateLoading;
    }else{
        //drwaRect:中处理
        self.state = CLRefreshViewStateWillLoading;
    }
}

-(CGPoint)willShowPoint{
    return CGPointZero;
}
-(CGFloat)showProgress{
   return self.loadingView.showProgress;
}
-(void)refreshViewChangeUIWhenNormal{}
-(void)refreshViewChangeUIWhenWillLoading{}
-(void)refreshViewChangeUIWhenLoading{}
-(void)refreshViewChangeUIWhenFinishLoading{}

-(void)drawRect:(CGRect)rect{
    if (self.state == CLRefreshViewStateWillLoading) {
        [self startRefresh];
    }else{
        self.state = CLRefreshViewStateNormal;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.state != CLRefreshViewStateLoading) {
        _scrollViewOriginalInsets = self.scrollView.contentInset;
    }
}

@end
