//
//  UIApplication+Helper.h
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/11.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Helper)

+ (UIViewController *)dd_rootViewController;
+ (UINavigationController *)dd_rootNavigationController;
+ (UITabBarController *)dd_rootTabBarController;
+ (UINavigationController *)dd_navigationControllerOnTabBarIndex:(NSInteger) index;
+ (UIViewController *)dd_controllerOnTabBarIndex:(NSInteger) index;
+ (UINavigationController *)dd_currentNavigationControllerOnTabBar;

@end
