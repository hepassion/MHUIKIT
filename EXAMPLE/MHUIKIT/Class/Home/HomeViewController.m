//
//  HomeViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2017/12/8.
//  Copyright © 2017年 赵明鹤. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductViewController.h"
#import "HomeDataConstructor.h"
#import "AccountViewController.h"
#import "BlockViewController.h"
#import "LockViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "MHWebBrowserView.h"
@interface HomeViewController ()
@property (nonatomic, strong) HomeDataConstructor *dataConstructor;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX(0xfffff1);
    WEAK_SELF;
     self.uiTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    

    self.uiTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.dataConstructor loadData];
    }];
  
    
    
   
    
    //
    
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[HomeDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
    [self.dataConstructor loadData];
    
}
//
//- (NSString *)getNavigationTitle {
//    return @"首页";
//}
//

- (void)decorateNavigationBar:(UINavigationBar *)navigationBar {
    [super decorateNavigationBar:navigationBar];
}


- (void) stopMJRefreshing {
    [self.uiTableView.mj_header endRefreshing];
    [self.uiTableView.mj_footer endRefreshing];
}

#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
   
    
    if ([cellType isEqualToString:@"cell.type.block"]) {
        BlockViewController *blockVC  = [BlockViewController new];
        [self.navigationController pushViewController:blockVC animated:YES];
    } else if ([cellType isEqualToString:@"cell.type.lock"]) {
        LockViewController *lockVC = [LockViewController new];
        [self.navigationController pushViewController:lockVC animated:YES];
    }  else if ([cellType isEqualToString:@"cell.type.html"]) {
        MHWebBrowserViewController *webBrowserController = [[MHWebBrowserViewController alloc] init];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"hyh" ofType:@"html"];
        NSString* htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        webBrowserController.loadHTMLString = htmlStr;
        webBrowserController.defaultTitle = @"defaultTitle";
        
       
        
        [self.navigationController pushViewController:webBrowserController animated:YES];
    } else if ([cellType isEqualToString:@"cell.type.failure"]) {
        MHWebBrowserView* webBrowser    = [[MHWebBrowserView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                             0.0f,
                                                                                             SCREEN_WIDTH,
                                                                                             SCREEN_HEIGHT)];
        [self.view addSubview:webBrowser];
        
        webBrowser.linkClickedBlock = ^(NSURL* url) {
            if ([url.absoluteString isEqualToString:@"http://back/"]) {
                [webBrowser removeFromSuperview];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        
        NSURL* baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"html"];
        NSString* htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webBrowser.wkWebView loadHTMLString:htmlStr baseURL:baseURL];
    } else if ([cellType isEqualToString:@"cell.type.baidu"]) {
        MHWebBrowserViewController *web = [[MHWebBrowserViewController alloc] initWithURLString:@"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"];
        [self.navigationController pushViewController:web animated:YES];
    } else if ([cellType isEqualToString:@"cell.type.task"]) {
        NSURL *url = [NSURL URLWithString:@"mhuikit://Service/webSetting?nlogin=y&nauth=y" ];
        [[MHAppSchemaObserver sharedInstance] handleOpenURL:url];
    }
    
    
    
    
    
}


#pragma mark NVNetworkDataConstructorDelegate
- (void) networkDataContructorStartLoading:(MHNetworkDataConstructor*)dataConstructor {
   // [self.view nv_showLoading];
}

- (void) networkDataContructor:(MHNetworkDataConstructor *)dataConstructor didFinishWithData:(id)data {
  //  [self.view nv_hideLoading];
    
    [self stopMJRefreshing];
    
    //刷新数据
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
    [self.uiTableView reloadData];
}

- (void) networkDataContructor:(MHNetworkDataConstructor*)dataConstructor didErrorWithData:(id)data {
   // [self.view nv_hideLoading];
    [self stopMJRefreshing];
    // [self nv_showOffNetworkView];

  
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
