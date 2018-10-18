//
//  MHTaskQueue.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTask.h"
/**
 任务队列：执行队列顺序为先进先出
 */
@interface MHTaskQueue : NSObject

/**
 前期任务位置，从0开始，到队列中总任务数-1。
 */
@property (nonatomic, assign, readonly) NSUInteger interator;

/**
 整个任务队列完成后，触发回调。
 */
@property (nonatomic, copy) void(^taskQueueCallback)(MHTaskQueue* taskQueue, BOOL completed);

/**
 添加一个任务
 
 @param task 任务
 */
- (void) addTask:(MHTask*)task;

/**
 移除任务

 @param task 指定的任务
 */
- (void) removeTask:(MHTask*)task;

/**
 取消所有任务
 */
- (void) cancelAllTasks;

/**
 开始执行任务
 */
- (void) start;

/**
 下一个任务
 
 @return YES 执行下个任务成功 NO没有任务可执行了
 */
- (BOOL) next;

@end
