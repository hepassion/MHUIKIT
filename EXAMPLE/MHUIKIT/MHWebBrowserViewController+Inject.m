//
//  MHWebBrowserViewController+Inject.m
//  MHUIKIT
//
//  Created by minghe on 2019/2/18.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "MHWebBrowserViewController+Inject.h"

@implementation MHWebBrowserViewController (Inject)

- (void)injectOcMethod {
    
    [self.bridge registerHandler:@"jsoc2" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
//        NSDictionary *dic = (NSDictionary *)data;
//        NSString *string = [dic valueForKey:@"name"];
        NSString *string = (NSString *)data;
        NSDictionary *dic = @{
                              @"name":@"walker",
                              @"sex":@"male",
                              };
        // 将加密的结果返回到JS中
        responseCallback(dic);
    }];
    [self.bridge registerHandler:@"jsEvent" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        //        NSDictionary *dic = (NSDictionary *)data;
        //        NSString *string = [dic valueForKey:@"name"];
        NSString *string = [NSString stringWithFormat:@"%@+%@", data, @"fff"];
        
        // 将加密的结果返回到JS中
        responseCallback(string);
    }];
}

@end
