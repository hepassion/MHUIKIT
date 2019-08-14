//
//  MHTableViewController.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewController.h"
#import "CommonDefine.h"
#import <UIApplication+Helper.h>
#import "UIView+Utils.h"

@interface MHTableViewController ()<MHTableViewAdaptorDelegate>
- (void) initialize;
- (void) createTableView;
- (void) createTableAdaptor;


@end

@implementation MHTableViewController


#pragma mark - Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    
    if (@available(iOS 11.0, *)) {
        self.uiTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)relodNavigationBar {
    [super relodNavigationBar];
    if (self.config.navigationBarHidden) { //导航栏隐藏
        self.uiTableView.top = 0;
        self.uiTableView.height = MH_SCREEN_HEIGHT;
    } else {
        if (self.config.useSystemNavigationBar) {
            self.uiTableView.top =0;
        } else {
            self.uiTableView.top =  MH_NAVIGATION_TOP_ALL_HEIGHT;
        }
        self.uiTableView.height = MH_SCREEN_HEIGHT -  MH_NAVIGATION_TOP_ALL_HEIGHT;
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count < 2) {
        self.uiTableView.height = self.uiTableView.height -  MH_TAB_BAR_BOTTOM_ALL_HEIGHT;
    }
}

- (void) dealloc {
    _adaptor.delegate = nil;
}


#pragma mark - 初始化构建
- (void) initialize {
    [self createTableAdaptor];
    [self constructData];   //子类实现具体
    [self createTableView];
}

- (void) constructData {
    NSAssert(NO, @"You must override %@ in a subclass", NSStringFromSelector(_cmd));
}

- (void) createTableAdaptor {
    _adaptor = [[MHTableViewAdaptor alloc] init];
    _adaptor.delegate = self;
}


- (void) createTableView {
    
    //NSString* tableViewClassName = [self.adaptor tableViewClassName];
    //Class tableViewClass = NSClassFromString(tableViewClassName);
    CGRect fram = CGRectMake(0, 0 , MH_SCREEN_WIDTH, MH_SCREEN_HEIGHT);
   // _uiTableView = [[MHTableView alloc] initWithFrame:fram];
    _uiTableView = [[MHTableView alloc] initWithFrame:fram style:[self getTableViewStyle]];
    [_uiTableView setBackgroundColor:[UIColor clearColor]];
    [_uiTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _uiTableView.showsHorizontalScrollIndicator     = NO;
    _uiTableView.showsVerticalScrollIndicator       = NO;
    _uiTableView.dataSource                         = _adaptor;
    _uiTableView.delegate                           = _adaptor;
    
    _uiTableView.sectionIndexBackgroundColor        = [UIColor clearColor];
    _uiTableView.sectionIndexTrackingBackgroundColor= [UIColor clearColor];
    
    _adaptor.uiTableView = _uiTableView;
    [self.view addSubview:_uiTableView];
    [_uiTableView reloadData];
    
}

- (void) reloadTableViewData {
    [self.uiTableView reloadData];
}

- (UITableViewStyle )getTableViewStyle {
    return UITableViewStylePlain;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
