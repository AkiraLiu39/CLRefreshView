//
//  CLRefreshFooterView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/5.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractRefreshView.h"

@interface CLAbstractRefreshFooter : CLAbstractRefreshView
//是否只要在页面上刚好显示出来就加载 默认为NO
@property (nonatomic,assign,getter=isLoadingWhenShow) BOOL loadingWhenShow;
@end
