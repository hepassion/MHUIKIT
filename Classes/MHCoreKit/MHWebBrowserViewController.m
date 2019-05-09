//
//  MHWebBrowserViewController.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHWebBrowserViewController.h"
#import "MHH5Comunicator.h"
#import "CommonDefine.h"
#import "UIView+Utils.h"
#import "MHAppSchemaObserver.h"
#import "UIImage+Category.h"
#import "MBProgressHUD.h"

#define NavBarProgressLineDefaultColor          HEX(0x3d9dff)

static NSString* JSHandler;

NSString* const kNotificationWebViewControllerWillClosed = @"kNotificationWebViewControllerWillClosed";

@implementation MHWebBrowserConfig


@end

@interface MHWebBrowserViewController ()
<WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate,
UIScrollViewDelegate
>


//@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) MBProgressHUD *hud ;
@end

@implementation MHWebBrowserViewController

- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
//    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    
    if (!self.config) {
        self.config = [[MHWebBrowserConfig alloc] init];
    }
    
    if (self.urlPath != nil ) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self doRequestWithUserAndToken];
    } else if (self.loadHTMLString != nil) {
        [self.wkWebView loadHTMLString:self.loadHTMLString baseURL:self.baseURL];
    }

    //进度条初始化
//    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
//    self.progressView.progressTintColor = NavBarProgressLineDefaultColor;
//    self.progressView.trackTintColor = self.wkWebView.backgroundColor;
//    [self.wkWebView addSubview:self.progressView];

//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"jsoc1"];//js调用oc注册

    [self.wkWebView addObserver:self
                     forKeyPath:@"title"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    //如果显示底部tabbar，wkWebView.height需要重写
    if ([self hidenNavigationBar]) { //导航栏隐藏
        self.wkWebView.top = 0;
        self.wkWebView.height = SCREEN_HEIGHT;
    } else {
        if ([self getCustomNavigationBar]) {
            self.wkWebView.top = NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height;
        } else {
            self.wkWebView.top =0;
        }
        self.wkWebView.height = SCREEN_HEIGHT - NAVIGATION_BAR_DEFAULT_HEIGHT - Status_Bar_Height;
    }
    
}

- (instancetype)initWithURLString:(NSString *) urlString
{
    self = [super init];
    if (self) {
        self.urlPath        = urlString;
    }
    return self;
}

- (void)doRequestWithUserAndToken {
   // self.urlPath = [[MHH5Comunicator sharedInstance] appendUserInfoWithURL:self.urlPath
//                                  /                                      userid:@"userid"
                             //                                            token:@"token"];
    NSURL *url = [NSURL URLWithString:self.urlPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"iPhone OS" forHTTPHeaderField:@"device"];
    
    [self.wkWebView loadRequest:request];

}

#pragma mark - 公开方法

- (void)reload {
    [self.wkWebView reload];
}

- (void) reloadUrl:(NSString*)url {
    if (url != nil) {
        self.urlPath = url;
        [self doRequestWithUserAndToken];
    }
}

- (void)backButtonAction:(id)sender {
//    NSLog(@"count: %ld",self.wkWebView.backForwardList.backList.count );
//或者调用h5的方法
    if ([self.wkWebView canGoBack]) {
       [self.wkWebView goBack];
    } else {
        [super backButtonAction:sender];
    }
}




#pragma mark - >=iOS8 标题改变

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSString *title = [change objectForKey:@"new"];
        if (self.defaultTitle && self.defaultTitle.length) {
              // nothing todo
        } else {
            if ([self getCustomNavigationBar]) {
                self.pageNavigationBar.titleLabel.text = title;
            } else {
                self.title = title;
            }
        }
    }
//    else  if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        self.progressView.progress = self.wkWebView.estimatedProgress;
  //  }
    
}

#pragma mark - >=iOS8 WKNavigationDelegate 页面加载过程跟踪
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    self.progressView.hidden = NO;
//    [self.wkWebView bringSubviewToFront:self.progressView];
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        self.hud.label.text = @"加载中";
    }
    [self.hud showAnimated:YES];

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   // self.progressView.hidden = YES;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
   // self.progressView.hidden = YES;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - >=iOS8 WKNavigationDelegate 决定页面是否跳转
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSURL* url = request.URL;
   // mhuikit://camera
    NSString* scheme        = url.scheme;
    //    NSString* host          = url.host;
    //    NSString* service       = url.path;
    //    NSString* paramStr      = url.query;
    if ([[MHAppSchemaObserver sharedInstance] hasAppSchema:scheme]) {
        [[MHAppSchemaObserver sharedInstance] openURLString:url.absoluteString controller:self];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// https证书验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSURLCredential * credential = [[NSURLCredential alloc] initWithTrust:[challenge protectionSpace].serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}


#pragma mark - >=iOS8 JS回调OC
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"jsoc1"]) {
        NSLog(@"js调oc:%@", message.body);
    }
   
}

#pragma mark - >=iOS8 新打开窗口
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // <a href="http://www.baidu.com/" target="_blank"> a链接新开窗口问题。
    [self.wkWebView loadRequest:navigationAction.request];
    //  return  [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    return nil;
}

#pragma mark NavigationBar ----------------------
- (BOOL)getCustomNavigationBar  {
    return  !self.config.useSystemNavigationBar;
}

- (BOOL) hidenNavigationBar {
    return self.config.navigationBarHidden;
}

- (BOOL)getNavigationBarEdgePanBack {
    return NO;
}

- (NSString *)getNavigationTitle {
    return self.defaultTitle;
}


- (UIColor *)getNavigationBarBackgroundColor {
    return self.config.navigationBarBackgroundColor ? self.config.navigationBarBackgroundColor : MHDefaultNavBackGroundColor;
}

- (UIColor *)getNavigationTitleColor {
    return self.config.navigationBarTitleColor ? self.config.navigationBarTitleColor : MHDefaultTitleColor;
}


#pragma mark lazy loading -------------

- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        
     WKWebViewConfiguration *  configuration  = [[WKWebViewConfiguration alloc] init];
     configuration.userContentController      = [WKUserContentController new];
     configuration.preferences              = [[WKPreferences alloc] init];
     configuration.preferences.minimumFontSize = 10;
     configuration.preferences.javaScriptEnabled = YES;              configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
     configuration.userContentController       = [[WKUserContentController alloc] init];
     configuration.processPool               = [[WKProcessPool alloc] init];
        
        //高度 默认 从导航栏下开始   到底部
        _wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_DEFAULT_HEIGHT - Status_Bar_Height) configuration:configuration];
        
        
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.UIDelegate = self;
       // _wkWebView.navigationDelegate = self;
        self.bridge =  [WebViewJavascriptBridge bridgeForWebView:_wkWebView];
        [self.bridge setWebViewDelegate:self];
    }return _wkWebView;
}


#pragma mark - >=iOS8 WKUIDelegate 定制Alert、Prompt、Confirm

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"message = %@", message);
    UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    prompt = [prompt stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSURL* url = [NSURL URLWithString:prompt];
    NSString* scheme        = url.scheme;
    //    NSString* host          = url.host;
    //    NSString* service       = url.path;
    //    NSString* paramStr      = url.query;
    if (url && [[MHAppSchemaObserver sharedInstance] hasAppSchema:scheme]) {
        id value = [[MHAppSchemaObserver sharedInstance] syncOpenURL:url];
        completionHandler(value);
    }else {
        UIAlertController* alertC = [UIAlertController alertControllerWithTitle:prompt
                                                                        message:@""
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.textColor = [UIColor redColor];
        }];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler([alertC.textFields.lastObject text]);
        }]];
        alertC.textFields.lastObject.text = defaultText;
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
