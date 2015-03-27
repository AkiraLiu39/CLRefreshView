//
//  ClClockRefreshHeader.m
//  CLRefreshViewDemo
//
//  Created by 刘昶 on 15/2/1.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "ClClockRefreshHeader.h"
#import "CLClockLoadingView.h"
#import "UIView+CLExtension.h"
#import "CLRefreshViewConstant.h"
@interface ClClockRefreshHeader()
@property (nonatomic,weak) UILabel *textLabel;
@property (nonatomic,strong) NSDate *finishLoadDate;
@end
@implementation ClClockRefreshHeader


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CLClockLoadingView *loadingView = [CLClockLoadingView loadingView];
        self.loadingView = loadingView;
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.textLabel = label;
    }
    return self;
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
    CGFloat loadingViewWH = 30.0f;
    CGFloat loadingViewX = (self.cl_width - loadingViewWH) / 2;
    CGRect loadingViewFrame = CGRectMake(loadingViewX, 0, loadingViewWH, loadingViewWH);
    self.loadingView.frame = loadingViewFrame;
    
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(loadingViewFrame);
    CGFloat labelW = self.cl_width;
    CGFloat labelH = self.cl_height - labelY;
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}



@end
