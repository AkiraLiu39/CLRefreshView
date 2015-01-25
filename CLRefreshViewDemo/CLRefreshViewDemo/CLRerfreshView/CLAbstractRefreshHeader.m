//
//  CLRefrefhHeaderView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/4.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshHeader.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
#import "UIScrollView+CLCommon.h"
#import "CLRefreshViewConstant.h"
@implementation CLAbstractRefreshHeader


#pragma mark -overwrite
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset{
    CGFloat willShowOffsetY = -self.scrollViewOriginalInsets.top;
    CGFloat currentOffsetY = offset.y;
    if (currentOffsetY >= willShowOffsetY) {
        return - 1;
    }else{
        CGFloat progress = (currentOffsetY - willShowOffsetY) /  -self.cl_height;
        return progress;
    }
}
-(CGPoint)willShowPoint{
    return CGPointMake(0, -self.scrollViewOriginalInsets.top - self.cl_height);
}

-(void)refreshViewChangeUIWhenFinishLoading{
    
    if (self.scrollViewOriginalInsets.top == 0) {
        self.scrollView.cl_contentInsetTop = 0;
    }else if (self.scrollViewOriginalInsets.top == self.scrollView.cl_contentInsetTop){
        self.scrollView.cl_contentInsetTop -= self.cl_height;
    }else{
        self.scrollView.cl_contentInsetTop = self.scrollViewOriginalInsets.top;
    }
}
-(void)refreshViewChangeUIWhenWillLoading{
    
}
-(void)refreshViewChangeUIWhenLoading{
    CGFloat top = self.scrollViewOriginalInsets.top + self.cl_height;
    [UIView animateWithDuration:CLRefreshAnimationDurationNormal animations:^{
        self.scrollView.cl_contentInsetTop = top;
    } completion:^(BOOL finished) {
//        [self.scrollView setContentOffset:CGPointMake(0, -top) animated:YES];
    }];
}

@end
