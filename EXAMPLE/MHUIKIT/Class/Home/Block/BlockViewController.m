//
//  BlockViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "BlockViewController.h"
#import "BlockDataConstructor.h"

@interface BlockViewController ()

@property (nonatomic, strong) BlockDataConstructor *dataConstructor;
//@property (nonatomic, copy) void(^textBlock)(NSString *);

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //block其实编译后是一个结构体struct对象，包含外部引用的变量和方法。所以当block初始化完成后，捕获到的变量不能更改，需要加__block进行拷贝，拷贝后又是一个struct。
    //由于block对外部的变量有强引用，所以通常用 __weak修饰
    
}

#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.block"]) {

    }
    
    
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[BlockDataConstructor alloc] init];
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
