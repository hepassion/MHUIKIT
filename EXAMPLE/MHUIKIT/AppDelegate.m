//
//  AppDelegate.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "AppDelegate.h"
#import "MHGlassMainViewController.h"
#import "MHTableViewController.h"
#import "MHWebBrowserViewController.h"
#import "AppConfigure.h"
#import "HYTabBarController.h"
#import <MHUIKIT/MHDubugger.h>
#import "PDHttpClient.h"
#import "AppManger.h"
#import "NSObject+Runtime.h"
#import <MHUIKIT/NSString+Category.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self runtimeConfig ];
   
    UIImage *image = [UIImage imageNamed:@"moreSelect"];
    NSLog(@"%@", NSStringFromCGSize(image.size));
    
    CGSize size = CGSizeMake(CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));//这个size就是实际图片的像素大小
    NSLog(@"%@", NSStringFromCGSize(size));

    

//    [MHDubugger Debug];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor =  [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSDecimalNumber *numbwe;
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    
    
    [[AppConfigure sharedInstance] initialize];

#if T_DEPLOY
    
    //  [self openDevEnvir];
    [self openApp];
#else
    
    [self openApp];
#endif
    
    [[AppManger sharedInstance] deviceWANIPAddress:^(NSString *WANIP) {
        
    }];
    
    [PDHttpClient sharedInstance];
 
    
    return YES;
}


- (void)openApp {
    HYTabBarController *tab = [[HYTabBarController alloc] init];
    UINavigationController* glassController = [[UINavigationController alloc] initWithRootViewController:tab];
    self.window.rootViewController = glassController;
}




- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
   // BOOL result = [[MHAppSchemaObserver sharedInstance] handleOpenURL:url];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 运行时全局方法交换
- (void)runtimeConfig {
    //让所有的NavigationController都是用全局NavigationController来push
    [UINavigationController jk_swizzleMethod:@selector(pushViewController:animated:)
                                  withMethod:@selector(dd_pushViewController:animated:)];
    
    //处理手势密码在多window问题
    [UIViewController jk_swizzleMethod:@selector(dismissViewControllerAnimated:completion:)
                            withMethod:@selector(dd_dismissViewControllerAnimated:completion:)];
    
    //  [NVWebBrowserViewController jk_swizzleMethod:@selector(backButtonAction:)
    //                                   withMethod:@selector(hy_backButtonAction:)];
    
    
    
}


@end
