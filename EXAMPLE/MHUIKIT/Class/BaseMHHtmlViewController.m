
//
//  BaseMHHtmlViewController.m
//  MHUIKIT
//
//  Created by minghe on 2019/5/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "BaseMHHtmlViewController.h"
#import <MHUIKIT/UIColor+Category.h>
@interface BaseMHHtmlViewController ()

@end

@implementation BaseMHHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.config.navigationBarRightTitle = @"oc调js";
    
    [self.bridge registerHandler:@"jsoc2" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *dic = (NSDictionary *)data;
        
        NSString *type = dic[@"OPERATION_TYPE"];
        if ([type isEqualToString:@"CHANGE_NAV"]) {
            NSDictionary *parmars = [dic valueForKey:@"params"];
            if (parmars) {
                
                self.config.navigationBarBackgroundColor = [UIColor hexColorFromStr:[parmars valueForKey:@"navBackColor"]];
                self.config.navigationTitleColor = [UIColor hexColorFromStr:[parmars valueForKey:@"titleColor"]];
                self.config.navigationLeftRightTitleColor = [UIColor hexColorFromStr:[parmars valueForKey:@"titleColor"]];
                self.config.navigationBarBackButtonColor = [UIColor hexColorFromStr:[parmars valueForKey:@"backBtnColor"]];
                BOOL  showLeft = [[parmars valueForKey:@"showLeft"] boolValue];
                BOOL  showRight = [[parmars valueForKey:@"showRight"] boolValue];
                if (showLeft) {
                    NSDictionary *leftParm = [parmars valueForKey:@"left"];
                    NSInteger type = [[leftParm valueForKey:@"type"] integerValue];
                    if (type == 1) {
                        self.config.hidenBackButton = NO;
                    } else if (type == 2) {
                        self.config.hidenBackButton = YES;
                        self.config.navigationBarLeftTitle = [leftParm valueForKey:@"title"];
                    }
                    
                } else {
                    self.config.hidenBackButton = YES;
                    self.config.navigationBarLeftTitle = @"";
                }
                if (showRight) {
                    NSDictionary *rightParm = [parmars valueForKey:@"right"];
                    self.config.navigationBarRightTitle = [rightParm valueForKey:@"title"];
                    self.config.navigationBarRightImage = [rightParm valueForKey:@"img"];
                } else {
                    self.config.navigationBarRightImage = @"";
                    self.config.navigationBarRightTitle = @"";
                }
                [self relodNavigationBar];
            }
            responseCallback(@"刷新头部成功");

        }
        // 将加密的结果返回到JS中
    }];
}

- (void)navigationBarRightTitleAction:(id)sender {
    [self.bridge callHandler:@"OCcalljs" data:nil responseCallback:^(id responseData) {
        NSLog(@"js回调内容");
    }];
}

- (void) backButtonAction:(id)sender {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [super backButtonAction:sender];
    }
}


@end
