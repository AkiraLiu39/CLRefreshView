//
//  CLSimpleFloatRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/1/26.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "CLSimpleFloatRefreshHeader.h"
#import "CLCircleLoadingView.h"
#import "UIView+CLCommon.h"
#import "CLRefreshViewConstant.h"
#import "UIScrollView+CLCommon.h"
@interface CLSimpleFloatRefreshHeader()
@property (nonatomic,strong) NSDate *finishLoadDate;
@end
@implementation CLSimpleFloatRefreshHeader


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    };
    return self;
}
-(void)setup{
    CLAbstractLoadingView *loadingView = [CLCircleLoadingView loadingView];
    [self addSubview:loadingView];
    self.loadingView = loadingView;
    UILabel *label = [[UILabel alloc]init];
    label.text = CLRefreshViewTextLabelnormalText;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.textLabel = label;
}
-(NSString *)labelText{
    if (self.finishLoadDate) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.locale = [NSLocale currentLocale];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        int unit = NSCalendarUnitYear |
            NSCalendarUnitMonth |
            NSCalendarUnitDay |
            NSCalendarUnitHour |
            NSCalendarUnitMinute |
            NSCalendarUnitSecond;
        NSDateComponents *components = [calendar components:unit fromDate:self.finishLoadDate toDate:[NSDate date] options:0];
        if (components.year > 0) {
            return @"呵呵";
        }else if (components.month > 0){
            dateFormater.dateFormat = @"yyyy-MM 刷新";
            return [dateFormater stringFromDate:self.finishLoadDate];
        }else if (components.day > 0){
            dateFormater.dateFormat = @"yyyy-MM-dd 刷新";
            return [dateFormater stringFromDate:self.finishLoadDate];
        }else if (components.hour > 0){
            return [NSString stringWithFormat:@"%li小时前刷新",(long)components.hour];
        }else if (components.minute > 0){
            return [NSString stringWithFormat:@"%li分钟前刷新",(long)components.minute];
        }else{
            return @"刚刚刷新";
        }
    }
    return @"";
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if ([keyPath isEqualToString:CLScrollViewContentOffsetKeyPath] && self.showProgress > 0.5) {
        self.textLabel.text = [self labelText];
    }
}
-(void)refreshViewChangeUIWhenFinishLoading{
    [super refreshViewChangeUIWhenFinishLoading];
    self.finishLoadDate = [NSDate date];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat paddingY = 5.0f;
    CGFloat loadingViewWH = 30.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGFloat loadingViewY = paddingY;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, loadingViewY, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
    
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(loadingViewFrame) + paddingY;
    CGFloat labelW = self.cl_width;
    CGFloat labelH = self.cl_height - labelY;
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}

@end
