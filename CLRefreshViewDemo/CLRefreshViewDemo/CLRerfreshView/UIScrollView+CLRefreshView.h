//
//  UIScrollView+CLRefreshView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLRefreshHeader;
@class CLRefreshFooter;
@interface UIScrollView()
@property (nonatomic,weak) CLRefreshHeader *cl_refreshHeader;
@property (nonatomic,weak) CLRefreshFooter *cl_refreshFooter;
@end;

@interface UIScrollView (CLRefreshView)

-(void)cl_addRefreshHeaderViewWithAction:(void (^)())action;

-(void)cl_addRefreshFooterViewWithAction:(void(^)())action;

-(void)cl_refreshHeaderStartAction;

-(void)cl_refreshHeaderFinishAction;

-(void)cl_addRefreshHeaderView:(CLRefreshHeader *)header;

-(void)cl_addRefreshFooterView:(CLRefreshFooter *)header;

-(void)cl_refreshFooterStartAction;

-(void)cl_refreshFooterFinishAction;

-(void)cl_removeRefreshHeader;

-(void)cl_removeRefreshFooter;

-(void)setCl_refreshFooterAutoLoad:(BOOL)autoLoad;

-(BOOL)cl_refreshFooterAutoLoad;
@end
