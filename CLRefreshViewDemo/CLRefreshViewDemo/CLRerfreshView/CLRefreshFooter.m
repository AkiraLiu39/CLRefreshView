//
//  CLRefreshFooterView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLRefreshFooter.h"
#import "UIView+CLExtension.h"
#import "UIScrollView+CLExtension.h"
#import "CLCircleLoadingView.h"
#import "CLRefreshViewConstant.h"

@interface CLRefreshFooter(){
    @protected
    BOOL _overScrollView;
}

@end
@implementation CLRefreshFooter
@synthesize overScrollView = _overScrollView;
- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = CLRefreshFooterVeiwHeight;
    self = [super initWithFrame:frame];
    if (self) {
        self.overScrollView = NO;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(startRefresh) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.loadButton = btn;
        self.loadButtonFont = kCLRefreshFooterLoadButtonFont;
        self.normalLoadButtonTitle = CLRefreshFooterLoadButtonTitle;
    }
    return self;
}
-(void)setLoadButtonFont:(UIFont *)loadButtonFont{
    _loadButtonFont = loadButtonFont;
    self.loadButton.titleLabel.font = loadButtonFont;
}
-(void)setLoadButton:(UIButton *)loadButton{
    if (self.loadButton) {
        [self.loadButton removeFromSuperview];
    }
    [self addSubview:loadButton];
    _loadButton = loadButton;
}
-(void)setNormalLoadButtonTitle:(NSString *)normalLoadButtonTitle{
    _normalLoadButtonTitle = normalLoadButtonTitle.copy;
    [self.loadButton setTitle:normalLoadButtonTitle forState:UIControlStateNormal];
}
-(void)setOverScrollView:(BOOL)overScrollView{
    _overScrollView = overScrollView;
    if (self.state != CLRefreshViewStateLoading) {
        self.loadButton.hidden = overScrollView;
        self.loadingView.hidden = !overScrollView;
    }
}
-(void)adjustFrame{
    CGFloat scrollContentHeight = self.scrollView.cl_contentSizeHeight;
    CGFloat scrollViewHeight = self.scrollView.cl_height - self.scrollViewOriginalInsets.top - self.scrollViewOriginalInsets.bottom;
    self.cl_y = scrollContentHeight;
    self.overScrollView = scrollContentHeight > scrollViewHeight;
}

#pragma mark -overwrite
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:CLScrollViewContentSizeKeyPath];
    }
    if (newSuperview) {
        if ([newSuperview isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)newSuperview;
            if (tableView.tableFooterView.cl_height < 0.01) {
                UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
                tableView.tableFooterView = emptyView;
            }
        }
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
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{
    CGFloat willShowOffsetY = self.cl_y - self.scrollView.cl_height + scrollViewInsets.bottom;
    if (offset.y >= willShowOffsetY && self.cl_height != 0 && self.isOverScrollView) {
        CGFloat progress = (offset.y-willShowOffsetY) / self.cl_height;
        return progress;
    }else{
        return -1;
    }
}
-(void)refreshViewChangeUIWhenNormal{
    [super refreshViewChangeUIWhenNormal];
    [self adjustFrame];
    
}
-(void)refreshViewChangeUIWhenFinishLoading{
    [super refreshViewChangeUIWhenFinishLoading];
    self.scrollView.cl_contentInsetBottom = self.scrollViewOriginalInsets.bottom;
}
-(void)refreshViewChangeUIWhenWillLoading{
    [super refreshViewChangeUIWhenWillLoading];
}
-(void)refreshViewChangeUIWhenLoading{
    [super refreshViewChangeUIWhenLoading];
    self.loadButton.hidden = YES;
    [UIView animateWithDuration:CLRefreshAnimationDurationFast animations:^{
        CGFloat bottom = self.cl_height + self.scrollViewOriginalInsets.bottom;
        self.scrollView.cl_contentInsetBottom = bottom;
    }completion:^(BOOL finished) {
        if (self.refreshAction) {
            self.refreshAction();
        }
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.loadButton.frame = self.bounds;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}




@end
