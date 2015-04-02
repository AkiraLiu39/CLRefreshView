//
//  CLAutoRefreshFooter.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/27.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAutoRefreshFooter.h"
#import "UIView+CLExtension.h"
#import "UIScrollView+CLExtension.h"
#import "CLCircleLoadingView.h"
#import "CLRefreshViewConstant.h"
@implementation CLAutoRefreshFooter


#pragma mark -overwrite
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
            [self adjustState];
        }
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
    self.loadingView.showProgress = showProgress;
    if (showProgress >= CLRefreshLoadingViewMaxProgress) {
        self.state = CLRefreshViewStateLoading;
    }
}

-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{
    CGFloat willShowOffsetY = self.cl_y - self.scrollView.cl_height +scrollViewInsets.bottom - self.cl_height;
    if (offset.y >= willShowOffsetY && self.cl_height != 0 && self.isOverScrollView && self.isAutoLoad) {
        return CLRefreshLoadingViewMaxProgress;
    }else{
        return -1;
    }
}
-(void)refreshViewChangeUIWhenNormal{
    [super refreshViewChangeUIWhenNormal];
    self.loadingView.hidden = YES;
    if(!self.isAutoLoad){
        self.loadButton.hidden = NO;
        [self.loadButton setTitle:self.unAutoLoadButtonTitle forState:UIControlStateNormal];
    }
}

-(void)refreshViewChangeUIWhenFinishLoading{
    
}
-(void)refreshViewChangeUIWhenLoading{
    self.loadButton.hidden = YES;
    if (self.refreshAction) {
        self.refreshAction();
    }
}
-(void)refreshViewChangeUIWhenWillLoading{

}
-(void)drawRect:(CGRect)rect{
    CGFloat originalBottom = self.scrollViewOriginalInsets.bottom;
    self.scrollView.cl_contentInsetBottom = originalBottom + self.cl_height;
    [super drawRect:rect];
}
@end
