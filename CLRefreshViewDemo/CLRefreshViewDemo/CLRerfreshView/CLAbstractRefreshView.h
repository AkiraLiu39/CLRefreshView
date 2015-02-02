//
//  CLBaseRefershView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
CLRefreshViewStateNormal = 1,
CLRefreshViewStateWillLoading,
CLRefreshViewStateLoading
} CLRefreshViewState;
@class CLAbstractLoadingView;

@protocol CLRefreshControl <NSObject>

@optional
-(void)refreshViewChangeUIWhenNormal;
-(void)refreshViewChangeUIWhenWillLoading;
-(void)refreshViewChangeUIWhenLoading;
-(void)refreshViewChangeUIWhenFinishLoading;
@end

@interface CLAbstractRefreshView : UIView<CLRefreshControl>
@property (nonatomic,weak,readonly) UIScrollView *scrollView;
@property (nonatomic,assign,readonly) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic,copy) void (^refreshAction)();
@property (nonatomic,assign) CLRefreshViewState state;
@property (nonatomic,assign,readonly) CLRefreshViewState previousState;
@property (nonatomic,weak) CLAbstractLoadingView *loadingView;
@property (nonatomic,assign,readonly) CGFloat showProgress;
+(instancetype)refreshView;

-(void)endRefresh;

-(void)startRefresh;

#pragma mark -子类实现
/**
 *  根据scrollView的属性计算出空间将要显示的位置
 *
 *  @param scrollViewInsets scrollView 原始的 contentInsets
 *  @param offset           scrollView 当前(滚动时)的 contentOffset
 *
 *  @return 控件显示的百分比进度，如果控件直接处于屏幕外，返回-1,父类默认返回-1
 */
-(CGFloat)showProgress:(UIEdgeInsets)scrollViewInsets scrollViewOffset:(CGPoint)offset;
/**
 *  控件将要显示的位置，由Header子类实现,Footer子类此方法无意义
 *
 *  @return 控件刚加入 scrollView 时将要显示的位置，默认返回(0,0)
 */
-(CGPoint)willShowPoint;
@end


