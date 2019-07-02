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


@interface MHWebBrowserViewController : MHGlassMainViewController

@property (nonatomic, strong) WKWebView* _Nullable  wkWebView;
@property (nonatomic ,strong) WebViewJavascriptBridge* bridge;
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


@end
