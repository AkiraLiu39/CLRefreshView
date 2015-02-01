//
//  CLClockLoadingView.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/2/1.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLClockLoadingView.h"
@interface CLClockLoadingView()
@property (nonatomic,weak) CAShapeLayer *minuteHand;
@property (nonatomic,weak) CAShapeLayer *hourHand;
@property (nonatomic,weak) CAShapeLayer *clockBackground;
@property (nonatomic,weak) CAShapeLayer *clockFace;
@property (nonatomic,weak) CAShapeLayer *outCircle;
@property (nonatomic,assign) CGPoint clockCenter;
@property (nonatomic,assign) CGFloat minuteHandLength;
@property (nonatomic,assign) CGFloat hourHandLength;
@property (nonatomic,assign) CGFloat clockFaceRadius;
@property (nonatomic,assign) CGFloat outCircleRadiusOffset;
@end
@implementation CLClockLoadingView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.clockHandWidth = 0.3;
    [self setupOutCircle];
    [self setupClockBlackground];
    [self setupClockFace];
    [self setupMinuteHand];
    [self setupHourHand];
    
}

-(void)setupClockBlackground{
    CAShapeLayer *clockBackground = [CAShapeLayer layer];
    clockBackground.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:clockBackground];
    self.clockBackground = clockBackground;
}
-(void)setupClockFace{
    CAShapeLayer *clockFace = [CAShapeLayer layer];
    
    clockFace.fillColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:clockFace];
    self.clockFace = clockFace;
}
-(void)setupMinuteHand{
    CAShapeLayer *minuteHand = [CAShapeLayer layer];
    
    minuteHand.strokeColor = [[UIColor whiteColor]CGColor];
    minuteHand.lineJoin = kCALineJoinRound;
    minuteHand.fillColor = [[UIColor whiteColor]CGColor];
    minuteHand.position = CGPointMake(15, 15);
    [self.layer addSublayer:minuteHand];
    self.minuteHand = minuteHand;
}

-(void)setupHourHand{
    CAShapeLayer *hourHand = [CAShapeLayer layer];
    hourHand.strokeColor = [UIColor whiteColor].CGColor;
    hourHand.lineJoin = kCALineCapRound;
    hourHand.position = CGPointMake(15, 15);
    
    [self.layer addSublayer:hourHand];
    self.hourHand = hourHand;
}
-(void)setupOutCircle{
    CAShapeLayer *outCircle = [CAShapeLayer layer];
    outCircle.lineWidth = 1.0f;
    outCircle.fillColor = [UIColor redColor].CGColor;
    outCircle.strokeColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:outCircle];
    self.outCircle = outCircle;
}
-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    CGFloat clockCenterX = CGRectGetMidX(self.bounds);
    CGFloat clockCenterY = CGRectGetMidY(self.bounds);
    CGPoint clockCenter = CGPointMake(clockCenterX, clockCenterY);
    CGFloat clockBackgroundRadius = clockCenterX - 5;
    CGFloat clockFaceRadius = clockBackgroundRadius - 1;
    CGFloat maxOutCircleRadius = clockCenterX - 3;
    self.minuteHandLength = clockFaceRadius * 0.8;
    self.hourHandLength = clockFaceRadius * 0.6;
    self.clockCenter = clockCenter;
    self.clockFaceRadius = clockFaceRadius;
    self.outCircleRadiusOffset = maxOutCircleRadius - clockFaceRadius;
    
    self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.clockHandWidth, -self.minuteHandLength)].CGPath;
    self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.clockHandWidth, -self.hourHandLength)].CGPath;

    self.clockBackground.path = [UIBezierPath bezierPathWithArcCenter:clockCenter radius:clockBackgroundRadius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;

    self.clockFace.path = [UIBezierPath bezierPathWithArcCenter:clockCenter radius:clockFaceRadius startAngle:0 endAngle:2 *M_PI clockwise:YES].CGPath;
    self.outCircle.path = [UIBezierPath bezierPathWithArcCenter:self.clockCenter radius:clockFaceRadius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;
}

-(void)startAnimation{
    [super startAnimation];
    CABasicAnimation *minuteHandA = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    minuteHandA.toValue = @(2 * M_PI);
    minuteHandA.repeatCount = INFINITY;
    minuteHandA.duration = 1;
    [self.minuteHand addAnimation:minuteHandA forKey:@"minuteHandAnimation"];
    
    CABasicAnimation *hourHandA = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    hourHandA.toValue = @(2 * M_PI);
    hourHandA.repeatCount = INFINITY;
    hourHandA.duration = 8;
    [self.hourHand addAnimation:hourHandA forKey:@"hourHandAnimation"];
    
    self.outCircle.frame = self.layer.bounds;
    CABasicAnimation *outCircleA = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    outCircleA.toValue = @(0.8);
    outCircleA.repeatCount = 1;
    outCircleA.duration = 3;
    outCircleA.removedOnCompletion = NO;
    outCircleA.fillMode = kCAFillModeForwards;
    [self.outCircle addAnimation:outCircleA forKey:@"outCircleAnimation"];
    
}

-(void)stopAnimation{
    [super stopAnimation];
    [self.minuteHand removeAllAnimations];
    [self.hourHand removeAllAnimations];
    [self.outCircle removeAllAnimations];
}
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
    CGFloat willShowProgess = 0.2;
    CGMutablePathRef outCirclePath = CGPathCreateMutable();
    
    if (self.showProgress < willShowProgess){
        CGPathAddArc(outCirclePath, NULL, self.clockCenter.x, self.clockCenter.y,self.clockFaceRadius, 0, 2 * M_PI, YES);
        self.outCircle.path = outCirclePath;
        return;
    }
    CGPathAddArc(outCirclePath, NULL, self.clockCenter.x, self.clockCenter.y,self.clockFaceRadius + (self.outCircleRadiusOffset * self.showProgress) , 0, 2 * M_PI, YES);
    self.outCircle.path = outCirclePath;
    
    CGFloat progress = (self.showProgress - willShowProgess) / (CLRefreshLoadingViewMaxProgress - willShowProgess);
    CGMutablePathRef minuteHandPath = CGPathCreateMutable();
    CGPathMoveToPoint(minuteHandPath, NULL,0, 0);
    CGFloat x = self.minuteHandLength * cos(M_PI * 2 * progress);
    CGFloat y = self.minuteHandLength * sin(M_PI * 2 * progress);
    CGAffineTransform trans =  CGAffineTransformMakeRotation(-M_PI /2);
    CGPathAddLineToPoint(minuteHandPath,&trans, x, y);
    self.minuteHand.path = minuteHandPath;
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

@end
