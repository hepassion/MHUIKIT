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
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GRMustache.h"
#import "PDHttpClient+Test.h"
#import "SortViewController.h"
#import "UsrModel+Category.h"
#import <SSKeychain/SSKeychain.h>

@interface HomeViewController ()
@property (nonatomic, strong) HomeDataConstructor *dataConstructor;
@property (nonatomic, strong) NSDictionary *headDict;

@end

@implementation HomeViewController

static inline UIEdgeInsets sgm_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX(0xfffff1);
    WEAK_SELF;
    self.config.navigationTitle = @"首页";
    self.config.navigationTitleColor = [UIColor redColor];
    self.config.navigationBarBackgroundColor = COLOR_DEFAULT_WHITE;

    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
   

    self.uiTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.dataConstructor loadData];
    }];
  
   
   
    
    
    //  http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4
    
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



- (void) stopMJRefreshing {
    [self.uiTableView.mj_header endRefreshing];
    [self.uiTableView.mj_footer endRefreshing];
}
//给template.html中对应的标签格式化内容
-(NSString *)demoFormatWithName:(NSString *)name value:(NSString *)value{
    NSString *fileName = @"hyh.html";
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSString *template = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *renderObject = @{
                                   @"name":name,
                                   @"content":value,
                                   @"contentImage":@"http://d.hiphotos.baidu.com/image/h%3D300/sign=fa89f3be5c66d01661199828a72ad498/8601a18b87d6277f5d7d424b26381f30e924fc52.jpg"
                                   
                                   };
    NSString *content = [GRMustacheTemplate renderObject:renderObject fromString:template error:nil];
    return content;
}
#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    UsrModel *model = [[UsrModel alloc] init];
    model.categoryTest = @"赵";
    
    if ([cellType isEqualToString:@"cell.type.block"]) {
        BlockViewController *blockVC  = [[BlockViewController alloc] init];
        
        
        [self.navigationController pushViewController:blockVC animated:YES];
    } else if ([cellType isEqualToString:@"cell.type.lock"]) {
       
        LockViewController *lockVC = [LockViewController new];
        [self.navigationController pushViewController:lockVC animated:YES];
    
    }  else if ([cellType isEqualToString:@"cell.type.html"]) {
        
        
        
      BaseMHHtmlViewController *webBrowserController = [[BaseMHHtmlViewController alloc] init];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"hyh" ofType:@"html"];
        NSString* htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        webBrowserController.loadHTMLString = htmlStr;
//        webBrowserController.defaultTitle = @"默认标题";
//        MHWebBrowserConfig *config = [MHWebBrowserConfig new];
//        webBrowserController.config = config;
//        NSString *rendering = [self demoFormatWithName:@"minghe" value:@"zhao"];
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        NSURL *baseUrl = [NSURL fileURLWithPath:path];
//        webBrowserController.loadHTMLString = rendering;
//        webBrowserController.baseURL = baseUrl;
//        webBrowserController.defaultTitle = @"默认标题";
        [self.navigationController pushViewController:webBrowserController animated:YES];
    } else if ([cellType isEqualToString:@"cell.type.failure"]) {
        MHWebBrowserView* webBrowser    = [[MHWebBrowserView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                             0.0f,
                                                                                             MH_SCREEN_WIDTH,
                                                                                              MH_SCREEN_HEIGHT)];
        [self.view addSubview:webBrowser];
        
        webBrowser.linkClickedBlock = ^(NSURL* url) {
            if ([url.absoluteString isEqualToString:@"mhuikit://back"]) {
                [webBrowser removeFromSuperview];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        
        NSURL* baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"failure" ofType:@"html"];
        NSString* htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [webBrowser.wkWebView loadHTMLString:htmlStr baseURL:baseURL];
    } else if ([cellType isEqualToString:@"cell.type.baidu"]) {
       // NSString *urlStr = @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
//        NSString *urlStr = @"https://test.95590.cn/OLI/H5/#/lhb/replayLhb";
//        NSString *urlStr = @"https://test.95590.cn/nloan_test/test/index1.html";
            NSString *urlStr = @"https://www.baidu.com?哈哈哈=啦啦啦啦啦";

//        NSString *appstrore = @"https://itunes.apple.com/cn/app/id1439399498";
    [[MHAppSchemaObserver sharedInstance] openURLString:urlStr];
    } else if ([cellType isEqualToString:@"cell.type.task"]) {
        NSString* string = @"mhuikit://Service/webSetting?nlogin=y&nauth=y&TitleIcon=标题" ;
//        NSURL *url = [NSURL URLWithString:@"mhuikit://Service/webSetting?nlogin=y" ];
//        [[MHAppSchemaObserver sharedInstance] openURLString:string];
        
        BaseMHHtmlViewController *web = [[BaseMHHtmlViewController alloc] init];
//        web.urlPath = @"https://test.95590.cn/OLI/yjb/#/insurApplyAndAuthor";
//        web.urlPath = @"https://www.baidu.com";
        web.urlPath = @"https://test.95590.cn/OLI_ver/H5/#/lhb/mineNoLogin";
        [self.navigationController pushViewController:web animated:YES];
        

    } else if ([cellType isEqualToString:@"cell.type.fish"]) {
      
    
        
        
        
        
    } else if ([cellType isEqualToString:@"cell.type.sort"]) {
//        SortViewController *sortVC  = [SortViewController new];
//        [self.navigationController pushViewController:sortVC animated:YES];
        NSString *getDeviceUUID =  [self getDeviceUUID];
        NSLog(@"getDeviceUUID: %@", getDeviceUUID);

    }
}

- (NSString *) getBundleIdentifier{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return [dic valueForKey: @"CFBundleIdentifier"];
}

#define ACCOUNT_DEVICE_UUID     @"CCIC2C.device.uuid"

- (NSString *) getDeviceUUID{
    UIDevice *device = [UIDevice currentDevice];
    
    NSError *err = nil;
    NSString *uuid = [SSKeychain passwordForService: [self getBundleIdentifier]
                                            account: ACCOUNT_DEVICE_UUID
                                              error: &err];
    if (!uuid && err && [err code] == errSecItemNotFound) {
        uuid = [[device identifierForVendor] UUIDString];
        NSString *mhuuid = [MHUtility uuid];
        NSLog(@"uuid:%@", uuid);
        NSLog(@"mhuuid: %@", mhuuid);

        
        [SSKeychain setPassword: uuid
                     forService: [self getBundleIdentifier]
                        account: ACCOUNT_DEVICE_UUID];
    }
    
    return uuid;
    
}



- (void)goToMessageCenter:(UIButton *)button {

    NSLog(@"messsss");
    
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
    self.adaptor.arrayKeys = self.dataConstructor.arrayKeys;
    self.adaptor.headerModels = self.dataConstructor.headerModels;
    self.adaptor.footerModels = self.dataConstructor.footerModels;
    

    
    [self.uiTableView reloadData];
}



- (void) networkDataContructor:(MHNetworkDataConstructor*)dataConstructor didErrorWithData:(id)data {
    // [self.view nv_hideLoading];
    [self stopMJRefreshing];
    MHErrorModel *model = (MHErrorModel *)data;
    NSLog(@"%ld", model.code);
    
    
    // [self nv_showOffNetworkView];
}


- (BOOL) tableView:(UITableView *)tableView canEditObject:(id<MHTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void) tableView:(UITableView *)tableView commitDeletingObject:(id<MHTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.adaptor.items removeObjectAtIndex:indexPath.row inSection:indexPath.section];
    self.dataConstructor.items = self.adaptor.items;
    [self.uiTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
   // [self reloadTableViewData];
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
