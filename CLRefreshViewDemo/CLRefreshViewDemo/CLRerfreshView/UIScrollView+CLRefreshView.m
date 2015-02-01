//
//  UIScrollView+CLRefreshView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "UIScrollView+CLRefreshView.h"
#import "CLSimpleRefreshHeader.h"
#import "CLSimpleRefreshFooter.h"
#import "CLAutoRefreshFooter.h"
#import <objc/runtime.h>



@implementation UIScrollView (CLRefreshView)
#pragma mark - 运行时相关
static char CLRefreshHeaderViewKey;
static char CLRefreshFooterViewKey;

-(void)setCl_refreshHeader:(CLRefreshHeader *)header{
    [self willChangeValueForKey:@"CLRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &CLRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"CLRefreshHeaderViewKey"];
}

-(CLRefreshHeader *)cl_refreshHeader{
    return objc_getAssociatedObject(self, &CLRefreshHeaderViewKey);
}

-(void)setCl_refreshFooter:(CLRefreshFooter *)footer{
    [self willChangeValueForKey:@"CLRefreshFooterViewKey"];
    objc_setAssociatedObject(self,
                             &CLRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"CLRefreshFooterViewKey"];
}

-(CLRefreshFooter *)cl_refreshFooter{
    return objc_getAssociatedObject(self, &CLRefreshFooterViewKey);
}

-(void)cl_addRefreshHeaderView:(CLRefreshHeader *)header{
    [self cl_removeRefreshHeader];
    [self insertSubview:header atIndex:0];
    self.cl_refreshHeader = header;
}
-(void)cl_addRefreshFooterView:(CLRefreshFooter *)footer{
    [self cl_removeRefreshFooter];
    [self addSubview:footer];
    self.cl_refreshFooter = footer;
}

-(void)cl_addRefreshHeaderViewWithAction:(void(^)())action{

    CLRefreshHeader *header = [CLSimpleRefreshHeader refreshView];
    header.refreshAction = action;
    [self cl_addRefreshHeaderView:header];
}
-(void)cl_addRefreshFooterViewWithAction:(void(^)())action{
    CLRefreshFooter *footer = [CLSimpleRefreshFooter refreshView];
    footer.refreshAction = action;
    [self cl_addRefreshFooterView:footer];
}
-(void)cl_refreshHeaderStartAction{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cl_refreshHeader startRefresh];
    });
    
}
-(void)cl_refreshHeaderFinishAction{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cl_refreshHeader endRefresh];
    });
    
}
-(void)cl_refreshFooterStartAction{
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.cl_refreshFooter startRefresh];
    });
    
}
-(void)cl_refreshFooterFinishAction{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cl_refreshFooter endRefresh];
    });
    
}

-(void)cl_removeRefreshHeader{
    [self.cl_refreshHeader removeFromSuperview];
    self.cl_refreshHeader = nil;
}

-(void)cl_removeRefreshFooter{
    [self.cl_refreshFooter removeFromSuperview];
    self.cl_refreshFooter = nil;
}

-(void)setCl_refreshFooterAutoLoad:(BOOL)autoLoad{
    if ([self.cl_refreshFooter isKindOfClass:[CLAutoRefreshFooter class]]) {
        ((CLAutoRefreshFooter *)self.cl_refreshFooter).autoLoad = autoLoad;
    }
}

-(BOOL)cl_refreshFooterAutoLoad{
    if ([self.cl_refreshFooter isKindOfClass:[CLAutoRefreshFooter class]]) {
        return ((CLAutoRefreshFooter *)self.cl_refreshFooter).autoLoad;
    }else{
        return false;
    }
}
@end
