//
//  UIApplication+Helper.h
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/11.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Helper)

+ (UINavigationController *)dd_rootNavigationController;
+ (UITabBarController *)dd_rootTabBarController;
+ (UINavigationController *)dd_navigationControllerOnTabBarIndex:(NSInteger) index;
+ (UINavigationController *)dd_currentNavigationControllerOnTabBar;
+ (UIViewController *)dd_currentViewController;




@end
