//
//  CLLoadingView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "CLAbstractLoadingView.h"
#import "UIView+CLCommon.h"

@implementation CLAbstractLoadingView
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
    _showProgress = showProgess;
    [self setNeedsDisplay];
}



-(void)startAnimation{}
-(void)stopAnimation{
    [self.layer removeAllAnimations];
}
-(void)dealloc{
    NSLog(@"<%@,%p> dealloc",self.class,self);
}
@end
