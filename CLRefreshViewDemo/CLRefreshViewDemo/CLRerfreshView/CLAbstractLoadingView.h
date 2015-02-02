//
//  CLLoadingView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CLAbstractLoadingView : UIView
/**
 *  最大的显示进度 1.0f
 */
UIKIT_EXTERN const CGFloat CLRefreshLoadingViewMaxProgress;
/**
 *  最小的显示进度 0.0f
 */
UIKIT_EXTERN const CGFloat CLRefreshLoadingViewMinProgress;

@property (nonatomic,assign) CGFloat showProgress;
+(instancetype)loadingView;
/**
 *  加载时执行的动画，子类实现
 */
-(void)startAnimation;
/**
 *  结束动画，子类实现
 */
-(void)stopAnimation;
@end
