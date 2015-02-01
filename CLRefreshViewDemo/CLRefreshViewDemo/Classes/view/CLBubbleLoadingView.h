//
//  CLBubbleLoadingView.h
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/30.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLAbstractLoadingView.h"

@interface CLBubbleLoadingView : CLAbstractLoadingView
@property (nonatomic,strong) UIColor *bubbleColor;
@property (nonatomic,assign) CGFloat minAlpha;
@property (nonatomic,assign) CGFloat maxAlpha;

@end
