//
//  CLRefreshFooterView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshView.h"

@interface CLAbstractRefreshFooter : CLAbstractRefreshView
@property (nonatomic,assign,getter=isOverScrollView) BOOL overScrollView;
@property (nonatomic,weak) UIButton *loadButton;
@end
