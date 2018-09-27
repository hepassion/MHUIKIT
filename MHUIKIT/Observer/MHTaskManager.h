//
//  MHTaskManager.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTask.h"
@interface MHTaskManager : NSObject
+ (instancetype)sharedInstance;
/**
 添加任务到指定的队列中，每个队列可用一个字符串来指定
 
 @param task    任务
 @param queueID 队列ID字符串，自定义
 */
- (void) addTask:(MHTask*)task name:(NSString*)queueID;

/**
 移除指定队列中的任务
 
 @param task    任务
 @param queueID 队列ID
 */
- (void) removeTask:(MHTask*)task name:(NSString*)queueID;

/**
 移除一组任务队列
 
 @param queueID 任务队列ID
 */
- (void) removeAllTaskWithName:(NSString*)queueID;


/**
 开始执行指定的任务队列
 
 @param queueID 队列ID
 @param block   完成后的回调
 */
- (void) start:(NSString*)queueID
        finish:(void(^)(BOOL completed))block;
@end
