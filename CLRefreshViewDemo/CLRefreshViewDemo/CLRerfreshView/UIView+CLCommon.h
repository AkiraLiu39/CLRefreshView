//
//  UIView+CLCommon.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/12/8.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CLCommon)
-(CGSize)cl_size;

-(void)setCl_size:(CGSize)size;

-(CGPoint)cl_origin;

-(void)setCl_origin:(CGPoint)origin;

-(CGFloat)cl_x;

-(CGFloat)cl_y;

-(void)setCl_x:(CGFloat)x;

-(void)setCl_y:(CGFloat)y;

-(CGFloat)cl_width;

-(CGFloat)cl_height;

-(void)setCl_width:(CGFloat)width;

-(void)setCl_height:(CGFloat)height;

@end
