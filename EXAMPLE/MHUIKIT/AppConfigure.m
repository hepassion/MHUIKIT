//
//  AppConfigure.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "AppConfigure.h"
#import "LockViewController.h"
#import "ProductViewController.h"

@implementation AppConfigure

static AppConfigure* instance = nil;

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}


- (void)initialize {
    [self initAppSchemaObservers];
    [self initAppSchemaPublicParams];
    [self initUserAgent];
}

- (void) initAppSchemaPublicParams {
    MHAppSchemaObserver* observers      = [MHAppSchemaObserver sharedInstance];
    [observers addPublicParamName:@"nlogin"
                           invoke:^(NSString *paramName,
                                    NSString *paramValue,
                                    UIViewController *viewController,
                                    void(^callback)(BOOL complete) ) {

                               LockViewController *lockVC = [LockViewController new];
                               
                               UINavigationController *naVC = [UIApplication dd_rootNavigationController ];
                               NSLog(@"5 %@", viewController);
                               
                               
                               WEAK(lockVC);
                               lockVC.completion = ^(BOOL success, id info) {
                                   if (success) {
                                     
                                       [weaklockVC dismissViewControllerAnimated:YES completion:nil];
                                       callback(YES);
                                   } else {
                                    
                                       callback(NO);
                                   }
                               };
                               [naVC presentViewController:lockVC animated:YES completion:nil];
                           }];
    
    [observers addPublicParamName:@"nauth"
                           invoke:^(NSString *paramName,
                                    NSString *paramValue,
                                    UIViewController *viewController,
                                    void(^callback)(BOOL complete) ) {
                               UINavigationController *naVC = [UIApplication dd_rootNavigationController ];
                              
                               ProductViewController *productVC = [ProductViewController new];
                               WEAK(productVC);
                               productVC.completion = ^(BOOL success, id info) {
                                   if (success) {
                                     
                                       [weakproductVC dismissViewControllerAnimated:YES completion:nil];
                                       callback(YES);
                                   } else {
                                     
                                       callback(NO);
                                   }
                               };
                               [naVC presentViewController:productVC animated:YES completion:nil];

                           }];
}
/**
 App Schema Task Process!
 */
- (void)initAppSchemaObservers {
    MHAppSchemaObserver* observers      = [MHAppSchemaObserver sharedInstance];
    [observers setAppSchema:[MHUtility appUrlScheme]];
    [observers addObserverName:@"Service/web"
                   serviceName:@"/web"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                            NSLog(@"web");
                          NSString *url = [parameters objectForKey:@"url"];
                            MHWebBrowserViewController *web = [[MHWebBrowserViewController alloc] initWithURLString:url];
                             [[UIApplication dd_rootNavigationController] pushViewController:web animated:YES];
                            return nil;
                        }];
    [observers addObserverName:@"llpromt"
                   serviceName:@"/promt"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                            NSLog(@"promt");
                            return @"promot";
                        }];
    
    [observers addObserverName:@"service.task.deviceInfo"
                   serviceName:@"/deviceInfo"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                            NSLog(@"deviceInfo");
                            return nil;
                        }];
    
    
    [observers addObserverName:@"service.task.webSetting"
                   serviceName:@"/webSetting"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                            NSLog(@"7 %@", viewController);
                            NSLog(@"........%@", parameters);
                           
                            
                            
                            return nil;
                            
                            // mhuikit://Service/webSetting?BgColor=0x0000ff
                        }];
}

/*
 定义webView中的navigator.userAgent
 */
- (void) initUserAgent {
    NSString *defaultUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/12H143";
    NSString *appVersion        = [MHUtility appVersion];
    NSString *systemVersion     = [[UIDevice currentDevice] systemVersion];
    NSString *customUserAgent   = [NSString stringWithFormat:@"%@ {{schema:%@,os_v:%@,app_v:%@}}",
                                   defaultUserAgent,
                                   [MHUtility appUrlScheme],
                                   systemVersion,
                                   appVersion];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
}
@end
