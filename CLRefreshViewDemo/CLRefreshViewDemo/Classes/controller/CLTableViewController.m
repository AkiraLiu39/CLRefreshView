//
//  CLTableViewController.m
//  RefreshViewDemo
//
//  Created by 刘昶 on 14/11/26.
//  Copyright (c) 2014年 unknown. All rights reserved.
//

#import "CLTableViewController.h"
#import "UIScrollView+CLRefreshView.h"
#import "UIScrollView+CLCommon.h"
#import "UIView+CLCommon.h"
#import "CLSimpleFloatRefreshHeader.h"
#import "CLSimpleAutoRefreshFooter.h"
#import "CLBubbleRefreshHeader.h"
#import "ClClockRefreshHeader.h"
#define kLoadOptionHeader 1
#define kLoadOptionFooter 2
NSString *const CLTableViewCellId = @"CellId";

@interface CLTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) int loadCount;
@end

@implementation CLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i=0; i<2; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"base data %i",i]];
        }
    }
    return _dataSource;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor redColor];
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    [self setupTabelCell];
    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView cl_refreshHeaderStartAction];
//    [self.tableView cl_refreshFooterStartAction];
}
-(void)setupTabelCell{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CLTableViewCellId];
    
}
-(void)setupRefresh{
   
    if ((self.refreshType & CLRefreshTypeSimpleHeader) == CLRefreshTypeSimpleHeader) {
        [self setupSimpleHeader];
    }
    if ((self.refreshType & CLRefreshTypeFloatHeader) == CLRefreshTypeFloatHeader) {
        [self setupFloatHeader];
    }
    if ((self.refreshType & CLRefreshTypeSimpleFooter) == CLRefreshTypeSimpleFooter) {
        [self setupSimpleFooter];
    }
    if ((self.refreshType & CLRefreshTypeAutoRefreshFooter) == CLRefreshTypeAutoRefreshFooter) {
        [self setupAutoRefreshFooter];
    }
    if ((self.refreshType & CLRefreshTypeCustomLoadingView1) == CLRefreshTypeCustomLoadingView1) {
        [self setupBubbleLoadingViewHeader];
    }
    if ((self.refreshType & CLRefreshTypeCustomLoadingView2) == CLRefreshTypeCustomLoadingView2)  {
        [self setupClockLoadingViewHeader];
    }
    
}

-(void)setupSimpleHeader{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addRefreshHeaderViewWithAction:^{
        [weakSelf loadHeaderData:kLoadOptionHeader];
    }];
}

-(void)setupFloatHeader{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addFloatRefreshHeaderViewWithAction:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loadHeaderData:kLoadOptionHeader];
    }];
}

-(void)setupSimpleFooter{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addRefreshFooterViewWithAction:^{
        [weakSelf loadHeaderData:kLoadOptionFooter];
    }];
    
}
-(void)setupAutoRefreshFooter{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addAutoRefreshFooterViewWithAction:^{
        [weakSelf loadHeaderData:kLoadOptionFooter];
    }];
}

-(void)setupBubbleLoadingViewHeader{
    __weak typeof(self) weakSelf = self;
    CLRefreshHeader *header = [CLBubbleRefreshHeader refreshView];
    header.cl_height = 40.0f;
    header.refreshAction = ^(){
        [weakSelf loadHeaderData:kLoadOptionHeader];
    };
    [self.tableView cl_addRefreshHeaderView:header];
}

-(void)setupClockLoadingViewHeader{
    __weak typeof(self) weakSelf = self;
    CLRefreshHeader *header = [ClClockRefreshHeader refreshView];
    header.refreshAction = ^(){
        [weakSelf loadHeaderData:kLoadOptionHeader];
    };
    [self.tableView cl_addRefreshHeaderView:header];
}

-(void)loadHeaderData:(int)option{
    dispatch_queue_t queue= dispatch_queue_create("com.unknown.refresh.demo", DISPATCH_QUEUE_SERIAL);
    NSString *format;
    if (option == kLoadOptionHeader) {
        format = @"header added %i";
    }else if (option == kLoadOptionFooter){
        format = @"footer added %i";
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
        NSMutableArray *newDatas = [NSMutableArray array];
        int recoderCount;
        if (self.loadCount > 1) {
            recoderCount = 5;
        }else{
            recoderCount = 10;
        }
        for (int i=0; i<recoderCount; i++) {
            [newDatas addObject:[NSString stringWithFormat:format,arc4random() % 10]];
        }
        if (option == kLoadOptionFooter) {
            [self.dataSource addObjectsFromArray:newDatas];
        }else if(option == kLoadOptionHeader){
            [newDatas addObjectsFromArray:self.dataSource];
            self.dataSource = newDatas;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        if (option == kLoadOptionHeader) {
            [self.tableView cl_refreshHeaderFinishAction];
        }else{
            if ((self.refreshType & CLRefreshTypeAutoRefreshFooter) == CLRefreshTypeAutoRefreshFooter) {
                self.tableView.cl_refreshFooterAutoLoad = newDatas.count > 9;
            }
            [self.tableView cl_refreshFooterFinishAction];
        }
        self.loadCount++;
    });
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CLTableViewCellId forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView cl_refreshHeaderStartAction];
//    [self.tableView cl_removeRefreshFooter];
}
-(void)dealloc{
    NSLog(@"<%@,%p> is dealloc",self.class,self);
}



@end
