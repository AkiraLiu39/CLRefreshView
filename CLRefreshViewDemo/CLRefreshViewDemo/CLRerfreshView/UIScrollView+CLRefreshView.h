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
/**
 *  为scrollView 添加下拉刷新Header
 *
 *  @param header CLRefreshHeader 的子类
 */
-(void)cl_addRefreshHeaderView:(CLRefreshHeader *)header;
/**
 *  为scrollView 添加上拉刷新Footer
 *
 *  @param header CLRefreshFooter 的子类
 */
-(void)cl_addRefreshFooterView:(CLRefreshFooter *)header;
/**
 *  快速添加一个简单的下拉刷新Header
 *  事例意义上的方法，可以随意删除或自定义
 *  @param action 刷新时的逻辑操作，完成后需要手动调用 cl_refreshHeaderFinishAction
 */
-(void)cl_addRefreshHeaderViewWithAction:(void (^)())action;
/**
 *  快速添加一个简单的上拉刷新Footer
 *  事例意义上的方法，可以随意删除或自定义
 *  @param action 刷新时的逻辑操作，完成后需要手动调用 cl_refreshFooterFinishAction
 */
-(void)cl_addRefreshFooterViewWithAction:(void(^)())action;
/**
 * 快速添加一个简单的带有自动加载功能的刷新Footer(当该Footer刚在屏幕上显示就会自动进入加载)
 * 通过以下方法设置:
 *   -(void)setCl_refreshFooterAutoLoad:(BOOL)autoLoad;
 * 可根据需要在加载完毕后判断是否下一次仍然开启自动加载.
 *  事例意义上的方法，可以随意删除或自定义
 *
 *  @param action 刷新时的逻辑操作，完成后需要手动调用 cl_refreshFooterFinishAction
 */
-(void)cl_addAutoRefreshFooterViewWithAction:(void(^)())action;
/**
 *  快读添加一个简单的浮动(不随ScrollView 移动的)下拉刷新Header
 *  事例意义上的方法，可以随意删除或自定义
 *  @param action 刷新时的逻辑操作，完成后需要手动调用 cl_refreshHeaderFinishAction
 */
-(void)cl_addFloatRefreshHeaderViewWithAction:(void(^)())action;
/**
 *  手动调用，使下拉刷新Header进入加载状态
 */
-(void)cl_refreshHeaderStartAction;
/**
 *  在Header执行完加载数据操作后需手动调用
 */
-(void)cl_refreshHeaderFinishAction;
/**
 *  手动调用，使上拉刷新Footer进入加载状态
 */
-(void)cl_refreshFooterStartAction;
/**
 *  在Footer执行完加载数据操作后需手动调用
 */
-(void)cl_refreshFooterFinishAction;
/**
 *  移除当前ScrollView上的下拉刷新Header
 */
-(void)cl_removeRefreshHeader;
/**
 *  移除当前ScrollView上的上拉刷新Footer
 */
-(void)cl_removeRefreshFooter;
/**
 *  为Footer设置是否自动加载,仅当fooer为CLAutoRefreshFooter子类时有效
 *
 *  @param autoLoad 是否自动加载
 */
-(void)setCl_refreshFooterAutoLoad:(BOOL)autoLoad;
/**
 *  获取当前Footer是否是自动加载
 *
 *  @return 是否自动加载.非CLAutoRefreshFooter子类永远返回False
 */
-(BOOL)cl_refreshFooterAutoLoad;


@end
