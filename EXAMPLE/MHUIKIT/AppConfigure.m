//
//  AppConfigure.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "AppConfigure.h"

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
                               
                               NSLog(@"LOGIN");
                                callback(YES);                               
                           }];
    
    [observers addPublicParamName:@"nauth"
                           invoke:^(NSString *paramName,
                                    NSString *paramValue,
                                    UIViewController *viewController,
                                    void(^callback)(BOOL complete) ) {
                               
                               NSLog(@"nauth");
                               callback(YES);
                           }];
}
/**
 App Schema Task Process!
 */
- (void)initAppSchemaObservers {
    MHAppSchemaObserver* observers      = [MHAppSchemaObserver sharedInstance];
    [observers setAppSchema:[MHUtility appUrlScheme]];
    [observers addObserverName:@"service.task.deviceInfo"
                   serviceName:@"/deviceInfo"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                           
                          //  NSLog(@"%@ , %@, %@", name, parameters, viewController);
                            NSLog(@"deviceInfo");
                            return nil;
                        }];
    
    
    [observers addObserverName:@"service.task.webSetting"
                   serviceName:@"/webSetting"
                        invoke:^id (NSString *name, NSDictionary *parameters, UIViewController *viewController) {
                           // NSLog(@"%@ , %@, %@", name, parameters, viewController);
                        
                            NSLog(@"webSetting");

                            return nil;
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