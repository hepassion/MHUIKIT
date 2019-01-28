//
//  ProductViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2017/12/8.
//  Copyright © 2017年 赵明鹤. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductDataConstructor.h"

@interface ProductViewController ()
@property (nonatomic, strong) ProductDataConstructor *dataConstructor;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[ProductDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
    [self.uiTableView reloadData];
}


- (NSString *)getNavigationTitle {
    return @"product";
}


#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.task"]) {
        self.completion(YES, @"authvc");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
