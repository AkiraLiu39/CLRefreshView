//
//  UIScrollView+CLCommon.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/4.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "UIScrollView+CLCommon.h"

@implementation UIScrollView (CLCommon)
-(CGFloat)cl_contentInsetTop{
    return self.contentInset.top;
}
-(CGFloat)cl_contentInsetRight{
    return self.contentInset.right;
}
-(CGFloat)cl_contentInsetLeft{
    return self.contentInset.left;
}
-(CGFloat)cl_contentInsetBottom{
    return self.contentInset.bottom;
}
-(void)setCl_contentInsetTop:(CGFloat)top{
    UIEdgeInsets insets = self.contentInset;
    insets.top = top;
    self.contentInset = insets;
}
-(void)setCl_contentInsetRight:(CGFloat)right{
    UIEdgeInsets insets = self.contentInset;
    insets.right = right;
    self.contentInset = insets;
}
-(void)setCl_contentInsetLeft:(CGFloat)left{
    UIEdgeInsets insets = self.contentInset;
    insets.left = left;
    self.contentInset = insets;
}
-(void)setCl_contentInsetBottom:(CGFloat)bottom{
    UIEdgeInsets insets = self.contentInset;
    insets.bottom = bottom;
    self.contentInset = insets;
}

-(CGFloat)cl_contentOffsetY{
    return self.contentOffset.y;
}
-(CGFloat)cl_contentOffsetX{
    return self.contentOffset.x;
}

-(void)setCl_contentOffsetY:(CGFloat)y{
    CGPoint offset = self.contentOffset;
    offset.y = y;
    self.contentOffset = offset;
}

-(void)setCl_contentOffsetX:(CGFloat)x{
    CGPoint offset = self.contentOffset;
    offset.x = x;
    self.contentOffset = offset;
}

-(void)setCl_contentSizeHeight:(CGFloat)height{
    CGSize size = self.contentSize;
    size.height = height;
    self.contentSize = size;
}

-(void)setCl_contentSizeWidth:(CGFloat)width{
    CGSize size = self.contentSize;
    size.width = width;
    self.contentSize = size;
}

-(CGFloat)cl_contentSizeHeight{
    return self.contentSize.height;
}

-(CGFloat)cl_contentSizeWidth{
    return self.contentSize.width;
}
@end
