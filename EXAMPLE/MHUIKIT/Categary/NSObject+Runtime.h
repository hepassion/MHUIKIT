//
//  NSObject+Runtime.h
//  Haiyinhui
//
//  Created by Dejun Liu on 2017/4/12.
//  Copyright © 2017年 Steven.Lin. All rights reserved.
//
//  用途：通过运行交换方法，处理部分全局业务逻辑。
//

#import <Foundation/Foundation.h>
 
@interface NSObject (Runtime)

@end

@interface UIViewController (Runtime)


/**
 手势密码消失的时候，手势的独立window消失，程序回到主window

 @param flag <#flag description#>
 @param completion <#completion description#>
 */
- (void)dd_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;

@end

@interface UINavigationController (PushController)


/**
 所有导航Push的时候，都使用RootNavigationController来Push保证唯一性

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)dd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

