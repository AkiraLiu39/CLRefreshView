//
//  CLRefreshViewConstant.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/12/11.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

//KVO ScrollView.contentOffset  KeyPath
UIKIT_EXTERN NSString *const CLScrollViewContentOffsetKeyPath;
//KVO ScrollView.contentSize  KeyPath
UIKIT_EXTERN NSString *const CLScrollViewContentSizeKeyPath;
//CLSimpleRefreshHeader 普通状态下TextLabel显示的文字.
UIKIT_EXTERN NSString *const CLRefreshViewTextLabelnormalText;
//CLSimpleRefreshHeader 将要刷新状态下TextLabel显示的文字.
UIKIT_EXTERN NSString *const CLRefreshViewTextLabelWillLoadText;
//CLSimpleRefreshHeader 正在刷新状态下TextLabel显示的文字.
UIKIT_EXTERN NSString *const CLRefreshViewTextLabelLoadingText;
//CLSimpleRefreshHeader 刷新完成状态下TextLabel显示的文字.
UIKIT_EXTERN NSString *const CLRefreshViewTextLabelFinishLoadingText;
//当ScrollView 内容没有超过自身高度时 RefreshFooter 显示的默认文字
UIKIT_EXTERN NSString *const CLRefreshFooterLoadButtonTitle;
//header默认高度
UIKIT_EXTERN const CGFloat CLRefreshHeaderVeiwHeight;
//footer默认高度
UIKIT_EXTERN const CGFloat CLRefreshFooterVeiwHeight;
//动画时间
UIKIT_EXTERN const CGFloat CLRefreshAnimationDurationNormal;

UIKIT_EXTERN const CGFloat CLRefreshAnimationDurationFast;

UIKIT_EXTERN const CGFloat CLRefreshAnimationDurationZero;
//默认的footer 按钮文字大小
#define kCLRefreshFooterLoadButtonFont [UIFont systemFontOfSize:14]