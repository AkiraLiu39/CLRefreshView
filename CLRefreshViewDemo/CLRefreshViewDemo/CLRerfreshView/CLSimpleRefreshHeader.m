//
//  CLBaiscRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/25.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLSimpleRefreshHeader.h"
#import "CLCircleLoadingView.h"
#import "CLRefreshViewConstant.h"
#import "UIView+CLExtension.h"

@implementation CLSimpleRefreshHeader
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    };
    return self;
}
-(void)setup{
    CLAbstractLoadingView *loadingView = [CLCircleLoadingView loadingView];
    self.loadingView = loadingView;
    UILabel *label = [[UILabel alloc]init];
    label.text = CLRefreshViewTextLabelnormalText;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.textLabel = label;
}
-(void)refreshViewChangeUIWhenNormal{
    [super refreshViewChangeUIWhenNormal];
    self.textLabel.text = CLRefreshViewTextLabelnormalText;
}
-(void)refreshViewChangeUIWhenWillLoading{
    [super refreshViewChangeUIWhenWillLoading];
    self.textLabel.text = CLRefreshViewTextLabelWillLoadText;
}
-(void)refreshViewChangeUIWhenLoading{
    [super refreshViewChangeUIWhenLoading];
    self.textLabel.text = CLRefreshViewTextLabelLoadingText;
}
-(void)refreshViewChangeUIWhenFinishLoading{
    [super refreshViewChangeUIWhenFinishLoading];
    self.textLabel.text = CLRefreshViewTextLabelFinishLoadingText;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat paddingY = 5.0f;
    CGFloat loadingViewWH = 30.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGFloat loadingViewY = paddingY;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, loadingViewY, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
    
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(loadingViewFrame) + paddingY;
    CGFloat labelW = self.cl_width;
    CGFloat labelH = self.cl_height - labelY;
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}


@end
