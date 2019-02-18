//
//  MHWebBrowserViewController.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHGlassMainViewController.h"
#import <WebKit/WebKit.h>
#import <WebKit/WKFoundation.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

UIKIT_EXTERN  NSString* _Nonnull  const kNotificationWebViewControllerWillClosed;

@class MHWebBrowserViewController;

@protocol MHWebBrowserViewControllerDelegate <NSObject>

- (void)respondUrlSchemeWithWebBrowserViewController:(MHWebBrowserViewController * _Nonnull)webBroserViewController;

@end

@interface MHWebBrowserConfig: NSObject

/**
 导航栏透明；YES 则WebView Y轴起始点为 0.0f； NO 则 Y起始点为64.0f
 */
@property (nonatomic, assign) BOOL useSystemNavigationBar;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, strong) UIColor* _Nullable navigationRightItemColor;
@property (nonatomic, strong) UIImage* _Nullable navigationRightItemImage;
@property (nonatomic, strong) UIColor* _Nullable navigationBarBackgroundColor;
@property (nonatomic, strong) UIColor* _Nullable navigationBarTitleColor;

@end

@interface MHWebBrowserViewController : MHGlassMainViewController

@property (nonatomic, strong) MHWebBrowserConfig* _Nullable config;
@property (nonatomic ,strong) WebViewJavascriptBridge* bridge;
@property (nonatomic, strong) WKWebView* _Nullable  wkWebView;
@property (nonatomic, assign) id<MHWebBrowserViewControllerDelegate> _Nullable delegate;

/**
 需要访问的URL路径
 */
@property (nonatomic, strong) NSString* _Nullable   urlPath;

/**
 直接读取HTML文本
 */
@property (nonatomic, strong) NSString* _Nullable   loadHTMLString;     //html字符串
@property (nonatomic, strong) NSURL* _Nullable      baseURL;            //html字符串的基础URL



/**
 默认标题，有默认标题，将不能使用webview中Html的标题
 */
@property (nonatomic, strong) NSString* _Nullable   defaultTitle;


/**
 通过一个URL初始化WebView
 
 @param urlString 访问的URL地址
 @return 实例
 */
- (instancetype _Nullable)initWithURLString:(NSString *_Nullable) urlString;


- (void) reload;
- (void) reloadUrl:(NSString* _Nullable)url;
- (void)injectMethod ; //注册oc method
/**
 返回按钮事件，可重写
 
 @param sender button
 */
- (void) backButtonAction:(id)sender;

@end
