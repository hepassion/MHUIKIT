//
//  MHTask.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTaskObjectProtocol.h"
@interface MHTask : NSObject

/**
 对象实现NVTaskObjectProtocol协议，即可作为一个Task
 */
@property (nonatomic, strong) id<MHTaskObjectProtocol> object;

/**
 Task需要传递的参数
 */
@property (nonatomic, strong) NSDictionary* userInfo;

/**
 Task任务完成后的回调
 */
@property (nonatomic, copy) void(^callback)(BOOL completed);

/**
 执行任务
 */
- (void) execute;
@end
