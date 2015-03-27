//
//  CLCycleLoadingView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/4.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLCircleLoadingView.h"
#import "UIView+CLExtension.h"
#import "CLRefreshViewConstant.h"
@implementation CLCircleLoadingView



-(void)startAnimation{
    [super startAnimation];
    CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnim.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    rotationAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnim.repeatCount = INFINITY;
    rotationAnim.duration = 1.0f;
    [self.layer addAnimation:rotationAnim forKey:@"rotation"];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat beginProgress = 0.2f;
    if (self.showProgress < beginProgress) {
        return;
    }
    CGFloat offsetProgress = 1.0f - beginProgress;
    CGFloat displayProgress = (self.showProgress - beginProgress) / offsetProgress;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor lightGrayColor] set];
    
    CGFloat bigCycleLineWidth = 2.0f;
    CGContextSetLineWidth(context, bigCycleLineWidth);
    CGFloat bigCycleRadius = self.cl_width * 0.5 - 2 * bigCycleLineWidth;
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    CGContextAddArc(context, centerX, centerY, bigCycleRadius, - M_PI / 180 * 90, -M_PI / 180 * (360  * displayProgress +90), 1);
    
    CGContextSetLineWidth(context, bigCycleLineWidth);
    CGContextStrokePath(context);
    
    
    CGFloat smallCycleMaxRadius = bigCycleRadius - 6.0f;
    CGFloat cycleRadius = self.showProgress * smallCycleMaxRadius;
    
    CGContextAddArc(context, centerX, centerY, cycleRadius, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
    
    CGFloat willShowMidCycleProgress = 0.5f;
    if (self.showProgress >= willShowMidCycleProgress) {
        CGFloat midProgress =(self.showProgress - willShowMidCycleProgress) / (CLRefreshLoadingViewMaxProgress - willShowMidCycleProgress);
        CGFloat midCycleRadius = smallCycleMaxRadius + 2.5f;
        [[UIColor redColor] set];
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineWidth(context, 3.0f);
        CGContextAddArc(context, centerX, centerY, midCycleRadius, -M_PI / 180 * 90, M_PI / 180 * (270 * midProgress - 90), 0);
        CGContextStrokePath(context);
    }
}
@end
