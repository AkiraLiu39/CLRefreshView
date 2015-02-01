//
//  CLAutoRefreshFooter.h
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/27.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLRefreshFooter.h"

@interface CLAutoRefreshFooter : CLRefreshFooter
@property (nonatomic,assign,getter=isAutoLoad) BOOL autoLoad;
@property (nonatomic,copy) NSString *unAutoLoadButtonTitle;
@end
