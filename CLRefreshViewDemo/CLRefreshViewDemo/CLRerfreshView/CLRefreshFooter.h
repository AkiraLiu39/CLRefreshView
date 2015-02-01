//
//  CLRefreshFooterView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshView.h"

@interface CLRefreshFooter : CLAbstractRefreshView

@property (nonatomic,weak) UIButton *loadButton;
@property (nonatomic,copy) NSString *normalLoadButtonTitle;
/**
 *  当前显示位置是否超出了scrollView的高度(scrollView.contentSize.height > scrollView.frame.height)
 *
 *  @return <#return value description#>
 */
-(BOOL)isOverScrollView;
/**
 *  当ScrollView.contentSize 发生变化时，调整自身位置
 */
-(void)adjustFrame;

@end
