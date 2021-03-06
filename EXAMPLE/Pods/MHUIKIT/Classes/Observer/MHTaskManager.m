//
//  MHTaskManager.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTaskManager.h"
#import "MHTaskQueue.h"
@interface MHTaskManager ()
@property (nonatomic, strong) NSMutableDictionary* dictionary;
@property (nonatomic, copy) void(^taskQueueCallback)(MHTaskQueue* taskQueue, BOOL completed);
@property (nonatomic, copy) void(^finishBlock)(BOOL completed);
@end

@implementation MHTaskManager

static MHTaskManager* instance = nil;

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}

- (NSMutableDictionary*) dictionary {
    if (_dictionary == nil) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _dictionary;
}

- (void(^)(MHTaskQueue* taskQueue, BOOL completed))taskQueueCallback {
    __weak __typeof(self) weakself = self;

    return ^(MHTaskQueue* taskQueue, BOOL completed) {
        if (weakself.finishBlock) {
            [taskQueue cancelAllTasks];
            weakself.finishBlock(completed);
        }
    };
}


- (void) addTask:(MHTask *)task name:(NSString *)name {
    
    MHTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if (![taskQueue isKindOfClass:[MHTaskQueue class]]) {
        taskQueue                   = [[MHTaskQueue alloc] init];
        taskQueue.taskQueueCallback = self.taskQueueCallback;
        [self.dictionary setObject:taskQueue forKey:name];
    }
    
    [taskQueue addTask:task];
}

- (void) removeAllTaskWithName:(NSString *)name {
    MHTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if ([taskQueue isKindOfClass:[MHTaskQueue class]]) {
        [self.dictionary removeObjectForKey:name];
    }
}

- (void) removeTask:(MHTask *)task name:(NSString *)name {
    MHTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if ([taskQueue isKindOfClass:[MHTaskQueue class]]) {
        [taskQueue removeTask:task];
    }
}


- (void) start:(NSString *)name finish:(void (^)(BOOL))block {
    
    self.finishBlock            = block;
    
    MHTaskQueue* taskQueue      = [self.dictionary objectForKey:name];
    
    [taskQueue start];
    [taskQueue next];
}



@end
