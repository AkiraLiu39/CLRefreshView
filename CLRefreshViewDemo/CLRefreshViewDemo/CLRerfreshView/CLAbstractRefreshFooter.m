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

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = CLRefreshFooterVeiwHeight;
    self = [super initWithFrame:frame];
    if (self) {
        self.overScrollView = NO;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = kCLRefreshFooterLoadButtonFont;
        [btn setTitle:CLRefreshFooterLoadButtonTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startRefresh) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.loadButton = btn;
    }
    return self;
}
-(void)startRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadButton.hidden = YES;
        self.loadingView.hidden = NO;
    });
    
    [super startRefresh];

}
-(void)setOverScrollView:(BOOL)overScrollView{
    _overScrollView = overScrollView;
    self.loadButton.hidden = overScrollView;
    self.loadingView.hidden = !overScrollView;
}
-(void)adjustFrame{
    CGFloat scrollContentHeight = self.scrollView.cl_contentSizeHeight;
    CGFloat scrollViewHeight = self.scrollView.cl_height - self.scrollViewOriginalInsets.top - self.scrollViewOriginalInsets.bottom;
//    self.cl_y = MAX(scrollContentHeight, scrollViewHeight);
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
        if (self.state == CLRefreshViewStateLoading) {
            return;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{

    CGFloat willShowOffsetY = self.cl_y - self.scrollView.cl_height;
    if (offset.y >= willShowOffsetY && self.cl_height != 0 && self.isOverScrollView) {
        CGFloat progress = (offset.y-willShowOffsetY) / self.cl_height;
        return progress;
    }else{
        return -1;
    }
}
-(void)refreshViewChangeUIWhenNormal{
    [self adjustFrame];
}
-(void)refreshViewChangeUIWhenFinishLoading{
    self.scrollView.cl_contentInsetBottom = self.scrollViewOriginalInsets.bottom;
}
-(void)refreshViewChangeUIWhenWillLoading{
    
}
-(void)refreshViewChangeUIWhenLoading{
    [UIView animateWithDuration:CLRefreshAnimationDurationFast animations:^{
        CGFloat bottom = self.cl_height + self.scrollViewOriginalInsets.bottom;
        self.scrollView.cl_contentInsetBottom = bottom;
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.loadButton.frame = self.bounds;
}




@end
