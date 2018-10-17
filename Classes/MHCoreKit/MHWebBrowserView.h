//
//  MHWebBrowserView.h
//  MHUIKIT
//
//  Created by minghe on 2018/10/16.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
@interface MHWebBrowserView : UIView

@property (nonatomic, copy) void(^linkClickedBlock)(NSURL* _Nullable url);
@property (nonatomic, strong, readonly) NSURL* url;
@property (nonatomic, strong) WKWebView* wkWebView;

@end

