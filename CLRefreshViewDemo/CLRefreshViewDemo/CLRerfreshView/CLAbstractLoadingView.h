//
//  CLLoadingView.h
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAbstractLoadingView : UIView
@property (nonatomic,assign) CGFloat loadProgress;
@property (nonatomic,assign) CGFloat showProgress;
+(instancetype)loadingView;

-(void)startAnimation;
-(void)stopAnimation;
@end
