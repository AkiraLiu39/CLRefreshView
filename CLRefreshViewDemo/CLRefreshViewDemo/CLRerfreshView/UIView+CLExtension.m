//
//  UIView+CLCommon.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/12/8.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "UIView+CLExtension.h"

@implementation UIView (CLExtension)

#pragma mark -getter and setter

-(CGSize)cl_size{
    return self.frame.size;
}
-(void)setCl_size:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGPoint)cl_origin{
    return self.frame.origin;
}
-(void)setCl_origin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGFloat)cl_x{
    return self.frame.origin.x;
}
-(CGFloat)cl_y{
    return self.frame.origin.y;
}
-(void)setCl_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setCl_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)cl_width{
    return self.frame.size.width;
}
-(CGFloat)cl_height{
    return self.frame.size.height;
}
-(void)setCl_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setCl_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
