//
//  CLRefreshFooterView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshView.h"

@interface CLRefreshFooter : CLAbstractRefreshView
/**
 *  当显示内容并没有超出ScrollView高度时显示的加载按钮
 */
@property (nonatomic,weak) UIButton *loadButton;
/**
 *  按钮文字
 */
@property (nonatomic,copy) NSString *normalLoadButtonTitle;
/**
 *  按钮字体
 */
@property (nonatomic,strong) UIFont *loadButtonFont;
/**
 *  当前ScrollView显示的内容是否超出了scrollView的高度(scrollView.contentSize.height > scrollView.frame.height)
 *
 *  @return ContentSize.height是否大于 ScrollView的高度
 */
-(BOOL)isOverScrollView;
/**
 *  当ScrollView.contentSize 发生变化时，调整自身Frame
 */
-(void)adjustFrame;

@end
