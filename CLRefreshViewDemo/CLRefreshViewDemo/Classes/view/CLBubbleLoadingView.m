//
//  CLBubbleLoadingView.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/30.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLBubbleLoadingView.h"
#import "UIView+CLCommon.h"
@interface CLBubbleLoadingView()
@property (nonatomic,strong) CAAnimationGroup *animationGroup;
@property (nonatomic,assign) CGFloat fromAlpha;
@property (nonatomic,assign) CGFloat offsetAlpha;
@property (nonatomic,assign) BOOL animation;
@end
@implementation CLBubbleLoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [ super initWithFrame:frame]) {
        self.fromAlpha = 1.0f;
        self.offsetAlpha = 0.5f;
    }
    return self;
}
-(CAAnimationGroup *)animationGroup{
    if (!_animationGroup) {
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.repeatCount = INFINITY;
        _animationGroup.duration = 1.25;
        CAMediaTimingFunction *timingFunc = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGroup.timingFunction = timingFunc;
        
        CABasicAnimation *scaleA = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        scaleA.fromValue = @0.1;
        scaleA.toValue = @1.05;
        
        CABasicAnimation *opacityA = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityA.fromValue = @(self.fromAlpha);
        opacityA.toValue = @(self.fromAlpha - self.offsetAlpha);
        
        NSArray *animations = @[opacityA,scaleA];
        _animationGroup.animations = animations;
    }
    return _animationGroup;
}
-(void)setShowProgress:(CGFloat)showProgress{
    [super setShowProgress:showProgress];
}
-(void)startAnimation{
    [super startAnimation];
    self.animation = YES;
    [self setNeedsDisplay];
    [self.layer addAnimation:self.animationGroup forKey:@"bubble"];
}
-(void)stopAnimation{
    [super stopAnimation];
    self.animation = NO;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat maxRadius = rect.size.width / 2;
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *newC =[self.bubbleColor colorWithAlphaComponent:self.animation ? 1.0f : self.fromAlpha - self.offsetAlpha * self.showProgress];
    [newC set];
    CGContextAddArc(context,centerX,centerY, maxRadius * self.showProgress, 0, M_PI * 2, 1);
    CGContextFillPath(context);
}

@end
