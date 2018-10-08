//
//  MHAsPublicParamObject.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHAsPublicParamObject.h"
#import "NSDictionary+Category.h"

@implementation MHAsPublicParamObject

- (void) doTaskWithUserInfo:(NSDictionary *)userInfo callback:(void (^)(BOOL))callback {
    
    if (self.invokeBlock) {
        NSString* value                     = [userInfo nvObjectForKey:@"value"];
        UIViewController* viewController    = [userInfo nvObjectForKey:@"viewController"];
        
        self.invokeBlock(self.name, value, viewController, ^(BOOL completed){
            if (callback) {
                callback(completed);
            }
        });
        
    } else {
        if (callback) {
            callback(NO);
        }
    }
}

@end
