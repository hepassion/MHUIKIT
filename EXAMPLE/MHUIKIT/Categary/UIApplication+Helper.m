//
//  UIApplication+Helper.m
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/11.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//

#import "UIApplication+Helper.h"

@implementation UIApplication (Helper)

+ (UIViewController *)dd_rootViewController {
    UIWindow *appWindow = [[UIApplication sharedApplication].delegate performSelector:@selector(window)];
    return appWindow.rootViewController;
}

+ (UINavigationController *)dd_rootNavigationController {
    return (UINavigationController *)[UIApplication dd_rootViewController];
}

+ (UITabBarController *)dd_rootTabBarController {
    return [UIApplication dd_rootNavigationController].viewControllers.firstObject;
}

+ (UINavigationController *)dd_navigationControllerOnTabBarIndex:(NSInteger) index {
    UINavigationController *rootNavi = (UINavigationController *)[UIApplication dd_rootViewController];
    UITabBarController *tab = (UITabBarController *)rootNavi.viewControllers.firstObject;
    return (UINavigationController *)tab.viewControllers[index];
}

+ (UIViewController *)dd_controllerOnTabBarIndex:(NSInteger) index {
    return (UIViewController *)[UIApplication dd_navigationControllerOnTabBarIndex:index].viewControllers.firstObject;
}

+ (UINavigationController *)dd_currentNavigationControllerOnTabBar {
    UITabBarController *tabBarC = [UIApplication dd_rootTabBarController];
    return [tabBarC.viewControllers objectAtIndex:tabBarC.selectedIndex];
}

@end
