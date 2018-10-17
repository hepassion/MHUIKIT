//
//  MHWebBrowserView.m
//  MHUIKIT
//
//  Created by minghe on 2018/10/16.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHWebBrowserView.h"


@interface MHWebBrowserView ()
<WKNavigationDelegate,
WKUIDelegate>

@end

@implementation MHWebBrowserView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor                        = [UIColor whiteColor];
        
        
        
        self.wkWebView                                = [[WKWebView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                                    0.0f,
                                                                                                    frame.size.width,
                                                                                                    frame.size.height)];
        
        [self addSubview:self.wkWebView];
        self.wkWebView.backgroundColor                = [UIColor whiteColor];
        self.wkWebView.UIDelegate                    = self;
        self.wkWebView.navigationDelegate              =self;
        self.wkWebView.autoresizingMask               = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.wkWebView.scrollView.decelerationRate       = 0.998;
        
    }
    
    return self;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSURL* url = request.URL;
    
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && self.linkClickedBlock) {
        NSURL* url      = request.URL;
        self.linkClickedBlock(url);
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}

@end

