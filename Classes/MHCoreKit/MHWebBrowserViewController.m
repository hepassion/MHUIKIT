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

#define COLOR_HYH_RED                       [UIColor colorWithRed:227.0f/255.0f green:100.0f/255.0f blue:102.0f/255.0f alpha:1.0f]
#define COLOR_HYH_BLUE                      [UIColor colorWithRed:65.0f/255.0f green:155.0f/255.0f blue:240.0f/255.0f alpha:1.0f]
static NSString* JSHandler;

NSString* const kNotificationWebViewControllerWillClosed = @"kNotificationWebViewControllerWillClosed";

@implementation MHWebBrowserConfig


@end

@interface MHWebBrowserViewController ()
<UIWebViewDelegate,
WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate,
UIScrollViewDelegate
>



- (void) onClose:(id)sender;

/**
 第一次load页面的时候，增加MBProgressHUD来表示正在加载中，优化用户体验
 */

@property (nonatomic, assign) BOOL shouldShowingFirstLoadHtmlHUD;

@end

@implementation MHWebBrowserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    if (self.urlPath != nil ) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self doRequestWithUserAndToken];
    } else if (self.loadHTMLString != nil) {
        [self.wkWebView loadHTMLString:self.loadHTMLString baseURL:self.baseURL];
    }
    
    [self.wkWebView loadHTMLString:self.loadHTMLString baseURL:nil];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"jsoc1"];//js调用oc注册
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"jsoc2"];//js调用oc注册

    [self.wkWebView addObserver:self
                     forKeyPath:@"title"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:nil];
   
}

- (void)doRequestWithUserAndToken {
    self.urlPath = [[MHH5Comunicator sharedInstance] appendUserInfoWithURL:self.urlPath
                                                                        userid:@"userid"
                                                                         token:@"token"];
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
- (void)webviewNeedExecJavaScriptBussiness:(NSNotification *) notification {
    NSDictionary *userObject = notification.object;
    
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
#pragma mark - >=iOS8 标题改变

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSString *title = [change objectForKey:@"new"];
        if (!self.defaultTitle || !self.defaultTitle.length) {
            if (self.config && self.config.useSystemNavigationBar) {
                self.title = title;
            } else {
                self.pageNavigationBar.titleLabel.text = title;
            }
        }
    }
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

#pragma mark - >=iOS8 WKNavigationDelegate 页面加载过程跟踪
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
  //  [self closeFirstLoadingHUD];
   
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

#pragma mark - >=iOS8 WKNavigationDelegate 决定页面是否跳转
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSURL* url = request.URL;
    
    NSString* scheme        = url.scheme;
    //    NSString* host          = url.host;
    //    NSString* service       = url.path;
    //    NSString* paramStr      = url.query;
    if ([[MHAppSchemaObserver sharedInstance] hasAppSchema:scheme]) {
        [[MHAppSchemaObserver sharedInstance] openURL:url controller:self];
        //[[MHAppSchemaObserver sharedInstance] openURL:url];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    //小叉检查下是否要展示
    if (self.config && self.config.useSystemNavigationBar) {
        [self decorateLeftButtonNavigationBar:self.navigationController.navigationBar];
    } else {
        [self decorateCustomNavigationBar:self.pageNavigationBar];
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
    else if ([message.name isEqualToString:@"jsoc2"]) {
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
    return self.config ? self.config.useSystemNavigationBar : YES;
}

- (UIColor *)getCustomNavigationBarRightButtonTintColor {
    return self.config ? self.config.navigationRightItemColor : MHDefaultLeftRightItemTitleColor;
}

- (UIImage *)getCustomNavigationBarRightButtonImage {
    return self.config ? self.config.navigationRightItemImage : nil;
}

- (UIColor *)getNavigationBarBackgroundColor {
    return self.config ? self.config.navigationBarBackgroundColor : [UIColor orangeColor];
}

- (UIColor *)getNavigationTitleColor {
    return self.config ? self.config.navigationBarTitleColor : MHDefaultTitleColor;
}

- (NSString *)getCustomNavigationBarRightButtonTitle {
    return @"oc调用js";
}

- (void)customNavigationBarRightButtonAction:(id)sender {
//    [self.wkWebView evaluateJavaScript:@"ocCallJs('oc字段')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
//        NSLog(@"js返回字段 = %@", item);
//    }];
    [[MHAppSchemaObserver sharedInstance] openURLString:@"mhuikit://service/deviceInfo"];

    
}


#pragma mark 检查小叉是否显示
- (void) decorateCustomNavigationBar:(MHNavigationBar *)navigationBar {
    [super decorateCustomNavigationBar:navigationBar];
    
}

- (void) decorateLeftButtonNavigationBar:(UINavigationBar*)navigationBar {
    [super decorateLeftButtonNavigationBar:navigationBar];
    
    
}
- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    if (self.config) {
        if (self.config.navigationBarHidden) { //导航栏隐藏
            if (self.config.useSystemNavigationBar) {
                self.pageNavigationBar.hidden = YES;
                [self.navigationController setNavigationBarHidden:NO];
            } else {
                self.navigationController.navigationBar.hidden = YES;
                self.pageNavigationBar.hidden = NO;
            }
            self.wkWebView.top = 0;
            self.wkWebView.height = SCREEN_HEIGHT;
        } else {
            if (self.config.useSystemNavigationBar) {
                self.wkWebView.top = 0;
            } else {
                self.wkWebView.top = NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height;
            }
            self.wkWebView.height = SCREEN_HEIGHT - NAVIGATION_BAR_DEFAULT_HEIGHT - Status_Bar_Height;
        }
    } else {
        self.pageNavigationBar.hidden = NO;
        [self.navigationController setNavigationBarHidden:YES];
        self.wkWebView.top = NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height;
        self.wkWebView.height = SCREEN_HEIGHT - NAVIGATION_BAR_DEFAULT_HEIGHT - Status_Bar_Height;
    }
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
        
        
        _wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_DEFAULT_HEIGHT - Status_Bar_Height) configuration:configuration];
        _wkWebView.backgroundColor = COLOR_DEFAULT_WHITE;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;

    }return _wkWebView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
