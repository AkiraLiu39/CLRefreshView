//
//  CLRefrefhHeaderView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/4.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLRefreshHeader.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
#import "UIScrollView+CLExtension.h"
#import "CLRefreshViewConstant.h"
@implementation CLRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = CLRefreshHeaderVeiwHeight;
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

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
-(void)refreshViewChangeUIWhenNormal{
    [super refreshViewChangeUIWhenNormal];
}
-(void)refreshViewChangeUIWhenFinishLoading{
    [super refreshViewChangeUIWhenFinishLoading];
    if (self.scrollViewOriginalInsets.top == 0) {
        self.scrollView.cl_contentInsetTop = 0;
    }else if (self.scrollViewOriginalInsets.top == self.scrollView.cl_contentInsetTop){
        self.scrollView.cl_contentInsetTop -= self.cl_height;
    }else{
        self.scrollView.cl_contentInsetTop = self.scrollViewOriginalInsets.top;
    }
}
-(void)refreshViewChangeUIWhenWillLoading{
    [super refreshViewChangeUIWhenWillLoading];
}
-(void)refreshViewChangeUIWhenLoading{
    [super refreshViewChangeUIWhenLoading];
    CGFloat top = self.scrollViewOriginalInsets.top + self.cl_height;
    
    [UIView animateWithDuration:CLRefreshAnimationDurationNormal animations:^{
        self.scrollView.cl_contentInsetTop = top;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:CLRefreshAnimationDurationNormal animations:^{
            self.scrollView.contentOffset = CGPointMake(0, -top);
        }completion:^(BOOL finished) {
            if (self.refreshAction) {
                self.refreshAction();
            }
        }];
    }];
}

@end
