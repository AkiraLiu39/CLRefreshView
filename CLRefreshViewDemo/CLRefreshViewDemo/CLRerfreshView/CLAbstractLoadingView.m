//
//  CLLoadingView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "CLAbstractLoadingView.h"
#import "UIView+CLExtension.h"
#import "CLRefreshViewConstant.h"
@implementation CLAbstractLoadingView

const CGFloat CLRefreshLoadingViewMaxProgress = 1.0f;

const CGFloat CLRefreshLoadingViewMinProgress = 0.0f;
+(instancetype)loadingView{
    return [[self alloc]init];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setShowProgress:(CGFloat)showProgess{
    if (showProgess < CLRefreshLoadingViewMinProgress) {
        showProgess = CLRefreshLoadingViewMinProgress;
    }else if (showProgess > CLRefreshLoadingViewMaxProgress){
        showProgess = CLRefreshLoadingViewMaxProgress;
    }
    _showProgress = showProgess;
    if (!self.isHidden && self.alpha > 0.01) {
        [self setNeedsDisplay];
    }
}

-(void)startAnimation{
    if (self.isHidden || self.alpha < 0.01) {
        return;
    }
}
-(void)stopAnimation{
    [self.layer removeAllAnimations];
}
@end
