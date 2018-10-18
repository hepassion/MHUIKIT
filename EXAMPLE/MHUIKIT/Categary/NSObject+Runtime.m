//
//  NSObject+Runtime.m
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/12.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//

#import "NSObject+Runtime.h"
#import "AppDelegate.h"
#import "UIApplication+Helper.h"
//#import "NSString+Helper.h"
@implementation NSObject (Runtime)

@end

@implementation UIViewController (Runtime)

- (void)dd_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    NSString *currentClassName = NSStringFromClass([self class]);
    if ([currentClassName isEqualToString:@"LLLockViewController"]) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window makeKeyAndVisible];
    }
    [self dd_dismissViewControllerAnimated:flag
                                completion:completion];
}

@end

@implementation UINavigationController (PushController)

- (void)dd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *rootViewController = self.viewControllers.firstObject;
    if (rootViewController) {
        NSString *naviRootVCClassName = NSStringFromClass([rootViewController class]);
        if ([naviRootVCClassName isEqualToString:@"HomeViewController"] ||
            [naviRootVCClassName isEqualToString:@"ProductViewController"] ||
            [naviRootVCClassName isEqualToString:@"AccountViewController"] ||
            [naviRootVCClassName isEqualToString:@"MoreViewController"]) {
            
            [[UIApplication dd_rootNavigationController] pushViewController:viewController
                                                                   animated:animated];
            return;
        }
    }
    [self dd_pushViewController:viewController
                       animated:animated];
}

@end
