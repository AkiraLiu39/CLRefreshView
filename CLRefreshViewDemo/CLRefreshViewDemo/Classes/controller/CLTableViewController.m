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
NSString *const CLTableViewCellId = @"CellId";
@interface CLTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation CLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i=0; i<2; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"%i",i]];
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
//    [self.tableView cl_refreshHeaderStartAction];
}
-(void)setupTabelCell{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CLTableViewCellId];
    
}
-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.tableView cl_addRefreshHeaderViewWithAction:^{
        dispatch_queue_t queue= dispatch_queue_create("com.unknown.refresh.demo", DISPATCH_QUEUE_SERIAL);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
            NSLog(@" refresh over!! %f",weakSelf.tableView.cl_contentInsetTop);
            NSLog(@"thread %i",[NSThread currentThread].isMainThread);
            for (int i=0; i<10; i++) {
                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%i",arc4random() % 10]];
                
            }
            NSArray *arr = weakSelf.tableView.subviews;
            [weakSelf.tableView reloadData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"thread %i",[NSThread currentThread].isMainThread);
                [weakSelf.tableView cl_refreshHeaderFinishAction];
            });
            
        });
    }];
    
    //    [self.tableView cl_refreshHeaderStartAction];
    
    [self.tableView cl_addRefreshFooterViewWithAction:^{
        NSLog(@"footer refresh");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i<5; i++) {
                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%i",arc4random() % 10]];
            }
            [weakSelf.tableView reloadData];
            NSLog(@"footer refresh over");
            [weakSelf.tableView cl_refreshFooterFinishAction];
        });

    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
