//
//  UIViewController+Exception.h
//  MHUIKIT
//
//  Created by minghe on 2018/10/18.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, MHExceptionType) {
    MHExceptionError = 1,
    MHExceptionaNoData,
    MHExceptionOffNet
};

@interface UIViewController (Exception)

- (UIImage *) imageOfExceptionView;
- (NSString *) textOfExceptionView;
- (void) showExceptionViewWithType:(MHExceptionType)type;
- (void) hideExceptionView;
- (void) touchAtExceptionViewWithType:(MHExceptionType)type;

@end
