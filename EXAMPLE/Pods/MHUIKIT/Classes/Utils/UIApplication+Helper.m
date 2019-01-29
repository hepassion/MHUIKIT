//
//  UIApplication+Helper.m
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/11.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//

#import "UIApplication+Helper.h"

@implementation UIApplication (Helper)

+ (UINavigationController *)dd_rootNavigationController {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return (UINavigationController *)window.rootViewController;
}

+ (UITabBarController *)dd_rootTabBarController {
    return [UIApplication dd_rootNavigationController].viewControllers.firstObject;
}

+ (UINavigationController *)dd_navigationControllerOnTabBarIndex:(NSInteger) index {
    UINavigationController *rootNavi = (UINavigationController *)[UIApplication dd_rootNavigationController];
    UITabBarController *tab = (UITabBarController *)rootNavi.viewControllers.firstObject;
    return (UINavigationController *)tab.viewControllers[index];
}


+ (UINavigationController *)dd_currentNavigationControllerOnTabBar {
    UITabBarController *tabBarC = [UIApplication dd_rootTabBarController];
    return [tabBarC.viewControllers objectAtIndex:tabBarC.selectedIndex];
}

+ (UINavigationController *)dd_currentNavigationViewController {
    UINavigationController *rootNav =   [UIApplication dd_rootNavigationController];
    if (rootNav.viewControllers && rootNav.viewControllers.count > 1) {
        return [UIApplication dd_rootNavigationController];
    }
    return [UIApplication dd_currentNavigationControllerOnTabBar];
}

+ (UIViewController *)dd_currentViewController {
  UINavigationController *rootNav =   [UIApplication dd_rootNavigationController];
    if (rootNav.viewControllers && rootNav.viewControllers.count > 1) {
        return (UIViewController *)rootNav.viewControllers.lastObject;
    }
    UINavigationController *currNav = [UIApplication dd_currentNavigationControllerOnTabBar];
    return (UIViewController *)currNav.viewControllers.firstObject;
}

@end
