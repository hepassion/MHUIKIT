//
//  MHDubugger.m
//  DDSD
//
//  Created by minghe on 2018/10/15.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHDubugger.h"
#import <Aspects/Aspects.h>

@implementation MHDubugger

+ (void)Debug {
    [self AspectsMethods];
}

+ (void)AspectsMethods {
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSString *info = [NSString stringWithFormat:@"%@", aspectInfo.instance];
        if (![self IsValidInfo:info]) {
            NSLog(@"进入控制器 %@", aspectInfo.instance);
        }
    } error:nil];
    
    [UITableViewCell aspect_hookSelector:@selector(setSelected:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL selected) {
        id cell = aspectInfo.instance;
        NSString *info = [NSString stringWithFormat:@"%@", cell];
        if (selected) {
            NSLog(@"点击CELL：%@", info);
            if ([cell isKindOfClass:NSClassFromString(@"NVTableViewCell")]) {
                if ([cell respondsToSelector:@selector(item)]) {
                    NSLog(@"CellModel:%@",[cell performSelector:@selector(item)]);
                }
            }
        }
    } error:nil];
    
    [UIViewController aspect_hookSelector:@selector(viewDidDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSString *info = [NSString stringWithFormat:@"%@", aspectInfo.instance];
        if (![self IsValidInfo:info]) {
            NSLog(@"离开控制器 %@ -viewDidDisappear", aspectInfo.instance);
        }
    } error:nil];
}

+ (BOOL)IsValidInfo:(NSString *) info {
    NSArray *pool = @[@"UICompatibilityInputViewController",
                      @"UIInputWindowController",
                      @"UINavigationController"];
    __block BOOL result = NO;
    [pool enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = obj;
        if ([info containsString:str]) {
            result = YES;
        }
    }];
    return result;
}

@end
