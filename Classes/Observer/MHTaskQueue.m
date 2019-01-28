//
//  MHTaskQueue.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/27.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTaskQueue.h"

@interface MHTaskQueue ()
@property (nonatomic, strong) NSMutableArray* arrayTasks;
@property (nonatomic, copy) void(^taskCallback)(BOOL completed);
@end
@implementation MHTaskQueue
@synthesize interator = _interator;

- (void)dealloc
{
    NSLog(@"MHTaskQueue Dealloc");
}

- (NSMutableArray*) arrayTasks {
    if (_arrayTasks == nil) {
        _arrayTasks = [[NSMutableArray alloc] init];
    }
    
    return _arrayTasks;
}

- (void(^)(BOOL completed)) taskCallback {
    return ^(BOOL completed) {
        if (completed) {
            [self next];
        }
    };
}


- (void) addTask:(MHTask *)task {
    [self.arrayTasks addObject:task];
    task.callback   = self.taskCallback;
}

- (void) removeTask:(MHTask *)task {
    [self.arrayTasks removeObject:task];
}

- (void) cancelAllTasks {
    [self.arrayTasks removeAllObjects];
}

- (void) start {
    _interator = 0;
    
}

- (BOOL) next {
    if (_interator < [self.arrayTasks count]) {
        MHTask* task = [self.arrayTasks objectAtIndex:_interator++];
        [task execute];
        
        return YES;
    }
    
    if (self.taskQueueCallback) {
        self.taskQueueCallback(self, YES);
    }
    
    return NO;
}
@end
