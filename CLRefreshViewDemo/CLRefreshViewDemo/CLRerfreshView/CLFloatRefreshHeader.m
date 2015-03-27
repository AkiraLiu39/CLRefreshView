//
//  CLAbstractRefreshFloatHeaderView.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 15/1/25.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLFloatRefreshHeader.h"
#import "CLRefreshViewConstant.h"
#import "UIView+CLExtension.h"
@implementation CLFloatRefreshHeader

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([CLScrollViewContentOffsetKeyPath isEqualToString:keyPath]){
        self.cl_y = self.scrollView.contentOffset.y + self.scrollViewOriginalInsets.top;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}
@end
