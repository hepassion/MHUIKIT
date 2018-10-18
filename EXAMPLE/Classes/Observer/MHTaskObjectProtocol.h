//
//  MHTaskObjectProtocol.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MHTaskObjectProtocol <NSObject>

- (void) doTaskWithUserInfo:(NSDictionary*)userInfo callback:(void(^)(BOOL completed))callback;

@end
