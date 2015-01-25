//
//  UIScrollView+CLRefreshView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLAbstractRefreshHeader;
@class CLAbstractRefreshFooter;
@interface UIScrollView()
@property (nonatomic,weak) CLAbstractRefreshHeader *cl_refreshHeader;
@property (nonatomic,weak) CLAbstractRefreshFooter *cl_refreshFooter;
@end;

@interface UIScrollView (CLRefreshView)

-(void)cl_addRefreshHeaderViewWithAction:(void (^)())action;

-(void)cl_addRefreshFooterViewWithAction:(void(^)())action;

-(void)cl_refreshHeaderStartAction;

-(void)cl_refreshHeaderFinishAction;

-(void)cl_addRefreshHeaderView:(CLAbstractRefreshHeader *)header;

-(void)cl_addRefreshFooterView:(CLAbstractRefreshFooter *)header;

-(void)cl_refreshFooterStartAction;

-(void)cl_refreshFooterFinishAction;

-(void)cl_removeRefreshHeaderView;

-(void)cl_removeRefreshFooterView;

@end
