//
//  HYTabBarController.m
//  Haiyinhui
//
//  Created by Jelly on 7/1/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "HYTabBarController.h"
#import "HomeViewController.h"
#import "ProductViewController.h"
#import "AccountViewController.h"
#import "MoreViewController.h"
@interface HYTabBarController ()

- (void) initialize;
- (void) notifierUserLogin:(NSNotification*)notification;
@end



@implementation HYTabBarController

- (id) init {
    self = [super init];
    if (self) {
        
        UIView* backView = [[UIView alloc]init];
        backView.backgroundColor = HEX(0xffffff);
        backView.frame = self.tabBar.bounds;
        
        [[UITabBar appearance] insertSubview:backView atIndex:0];

        [self initialize];
       // self.delegate = self;
    }
    
    return self;
}

- (void) initialize {
    
    HomeViewController*           homeController      = [[HomeViewController alloc] init];
    UINavigationController*         homeNaviController  = [[UINavigationController alloc] initWithRootViewController:homeController];
  
    UITabBarItem * tabBarItem   = [[UITabBarItem alloc] initWithTitle:@"首页"
                                  image:[[UIImage imageNamed:@"home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                    selectedImage:[[UIImage imageNamed:@"homeSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    homeController.tabBarItem = tabBarItem;
    
  
    //    homeController.hidesBottomBarWhenPushed = YES;
    
    ProductViewController* productListController= [[ProductViewController alloc] init];
    UINavigationController*         productNaviController    = [[UINavigationController alloc]
                                                                initWithRootViewController:productListController];
    tabBarItem   = [[UITabBarItem alloc] initWithTitle:@"产品"
                                                 image:[[UIImage imageNamed:@"product"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                         selectedImage:[[UIImage imageNamed:@"productSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    productListController.tabBarItem = tabBarItem;

//    productListController.hidesBottomBarWhenPushed = YES;
    
    AccountViewController* accountController = [[AccountViewController alloc] init];
    UINavigationController*      accountNaviController  = [[UINavigationController alloc] initWithRootViewController:accountController];
//    accountController.hidesBottomBarWhenPushed = YES;
    tabBarItem   = [[UITabBarItem alloc] initWithTitle:@"账户"
                                                 image:[[UIImage imageNamed:@"account"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                         selectedImage:[[UIImage imageNamed:@"accountSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    accountController.tabBarItem = tabBarItem;

    
    MoreViewController* moreController = [[MoreViewController alloc] init];
    UINavigationController*      moreNaviController  = [[UINavigationController alloc] initWithRootViewController:moreController];
//    moreController.hidesBottomBarWhenPushed = YES;
    
    tabBarItem   = [[UITabBarItem alloc] initWithTitle:@"更多"
                                                 image:[[UIImage imageNamed:@"more"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                         selectedImage:[[UIImage imageNamed:@"moreSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
  
    
    moreController.tabBarItem = tabBarItem;

    [self setViewControllers:@[homeNaviController,
                               productNaviController,
                               accountNaviController,
                               moreNaviController]];
    
    
//     [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
//
//     [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], UITextAttributeTextColor, nil] forState:UIControlStateSelected];
//
    
    self.selectedIndex = 0;
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES];

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}




@end





