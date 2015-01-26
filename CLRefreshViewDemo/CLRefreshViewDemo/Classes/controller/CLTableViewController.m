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
#define kLoadOptionHeader 1
#define kLoadOptionFooter 2
NSString *const CLTableViewCellId = @"CellId";

@interface CLTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;

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
//    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
//    self.tableView.tableFooterView = footerView;
    [self setupTabelCell];
    [self setupRefresh];
//    [self.tableView cl_refreshHeaderStartAction];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
//    [self.tableView cl_refreshHeaderStartAction];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView cl_refreshHeaderStartAction];
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
    
}

-(void)setupSimpleHeader{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addRefreshHeaderViewWithAction:^{
        [weakSelf loadHeaderData:kLoadOptionHeader];
    }];
}

-(void)setupFloatHeader{
    __weak typeof(self) weakSelf = self;
    CLAbstractRefreshHeader *header = [CLSimpleFloatRefreshHeader refreshView];
    header.refreshAction = ^(){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loadHeaderData:kLoadOptionHeader];
    };
    [self.tableView cl_addRefreshHeaderView:header];
}

-(void)setupSimpleFooter{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addRefreshFooterViewWithAction:^{
        [weakSelf loadHeaderData:kLoadOptionFooter];
    }];
    
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
        NSLog(@" refresh over!!");
        NSMutableArray *newDatas = [NSMutableArray array];
        
        for (int i=0; i<10; i++) {
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
            [self.tableView cl_refreshFooterFinishAction];
        }
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
    NSLog(@"click");
    [self.tableView cl_refreshHeaderStartAction];
}
-(void)dealloc{
    NSLog(@"<%@,%p> is dealloc",self.class,self);
}



@end
