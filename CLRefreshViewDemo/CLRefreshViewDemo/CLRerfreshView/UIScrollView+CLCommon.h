//
//  UIScrollView+CLCommon.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/4.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CLCommon)
-(CGFloat)cl_contentInsetTop;

-(CGFloat)cl_contentInsetRight;

-(CGFloat)cl_contentInsetLeft;

-(CGFloat)cl_contentInsetBottom;

-(void)setCl_contentInsetTop:(CGFloat)top;

-(void)setCl_contentInsetRight:(CGFloat)right;

-(void)setCl_contentInsetLeft:(CGFloat)left;

-(void)setCl_contentInsetBottom:(CGFloat)bottom;

-(CGFloat)cl_contentOffsetY;

-(CGFloat)cl_contentOffsetX;

-(void)setCl_contentOffsetY:(CGFloat)y;

-(void)setCl_contentOffsetX:(CGFloat)x;

-(void)setCl_contentSizeHeight:(CGFloat)height;

-(void)setCl_contentSizeWidth:(CGFloat)width;

-(CGFloat)cl_contentSizeHeight;

-(CGFloat)cl_contentSizeWidth;

@end
