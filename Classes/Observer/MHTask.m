//
//  MHTask.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTask.h"
#import "MHTaskObjectProtocol.h"
@implementation MHTask

- (void) execute {
    if (self.object &&
        [self.object conformsToProtocol:@protocol(MHTaskObjectProtocol)]) {
        [self.object doTaskWithUserInfo:self.userInfo callback:^(BOOL completed) {
            if (self.callback) {
                self.callback(completed);
            }
        }];
    }
}
@end
