//
//  LockViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "LockViewController.h"
#import "LockDataConstructor.h"
@interface LockViewController ()

@property (nonatomic, strong) LockDataConstructor *dataConstructor;
@property (nonatomic, assign) NSInteger tickets;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSRecursiveLock *recursiveLock;
@property (nonatomic, strong) dispatch_queue_t concurrentQueueOne;
@property (nonatomic, strong) dispatch_queue_t concurrentQueueTwo;
@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  7  @synchronized
//  4   NSLock 对象锁
//  6 NSRecursiveLock 递归锁 NSRecursiveLock类定义的锁可以在同一线程多次lock，而不会造成死锁。
//  5  NSConditionLock 条件锁
//  3  pthread_mutex 互斥锁（C语言）
//   2 dispatch_semaphore 信号量实现加锁（GCD）
//   1 OSSpinLock （暂不建议使用，原因参见这里）
   
//所有锁（包括NSLock）的接口实际上都是通过NSLocking协议定义的，它定义了lock和unlock方法。你使用这些方法来获取和释放该锁。
    
    self.lock = [[NSLock alloc] init];
    self.recursiveLock  = [[NSRecursiveLock alloc] init];
    self.concurrentQueueOne = dispatch_queue_create("test.queue.one", DISPATCH_QUEUE_CONCURRENT);
    self.concurrentQueueTwo = dispatch_queue_create("test.queue.two", DISPATCH_QUEUE_CONCURRENT);

    self.tickets = 5;
    
}

- (void)saleTicketsSynchronized
{
    while (1) {
        @synchronized(self) {
            [NSThread sleepForTimeInterval:1];
            if (_tickets > 0) {
                _tickets--;
                NSLog(@"剩余票数= %ld, Thread:%@",_tickets,[NSThread currentThread]);
            } else {
                NSLog(@"票卖完了  Thread:%@",[NSThread currentThread]);
                break;
            }
        }
    }
}
- (void)saleTicketsNSLock
{
    
    while (1) {
        [NSThread sleepForTimeInterval:1];
        //加锁
        [self.lock lock];
        if (_tickets > 0) {
            _tickets--;
            NSLog(@"剩余票数= %ld, Thread:%@",_tickets,[NSThread currentThread]);
        } else {
            NSLog(@"票卖完了  Thread:%@",[NSThread currentThread]);
            break;
        }
        //解锁
        [self.lock unlock];
    }
}


- (void)saleTicketsNSRecursiveLock
{
    
    while (1) {
        [NSThread sleepForTimeInterval:1];
        //加锁
        [self.recursiveLock lock];
        if (_tickets > 0) {
            _tickets--;
            NSLog(@"剩余票数= %ld, Thread:%@",_tickets,[NSThread currentThread]);
        } else {
            NSLog(@"票卖完了  Thread:%@",[NSThread currentThread]);
            break;
        }
        //解锁
        [self.recursiveLock unlock];
    }
}




#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    
    [ self.navigationController popViewControllerAnimated:YES];
    if ([cellType isEqualToString:@"cell.type.synchronized"]) {
        //线程1
        dispatch_async(self.concurrentQueueOne, ^{
            [self saleTicketsSynchronized];
        });
        //线程2
        dispatch_async(self.concurrentQueueOne, ^{
            [self saleTicketsSynchronized];
        });
      
    }  else if ([cellType isEqualToString:@"cell.type.nslock"]) {
        dispatch_async(self.concurrentQueueOne, ^{
            [self saleTicketsNSLock];
        });
        //线程2
        dispatch_async(self.concurrentQueueTwo, ^{
            [self saleTicketsNSLock];
        });
    } else if ([cellType isEqualToString:@"cell.type.NSRecursiveLock"]) {
        dispatch_async(self.concurrentQueueOne, ^{
            [self saleTicketsNSRecursiveLock];
        });
        //线程2
        dispatch_async(self.concurrentQueueTwo, ^{
            [self saleTicketsNSRecursiveLock];
        });
    }
    
    
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[LockDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
    [self.uiTableView reloadData];
}

- (NSString *)getNavigationTitle {
    return @"block test";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
