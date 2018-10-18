
//
//  AccountViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2017/12/8.
//  Copyright © 2017年 赵明鹤. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountDataConstructor.h"
//NSCache

@interface AccountViewController ()<NSCacheDelegate>

@property (nonatomic, strong) AccountDataConstructor *dataConstructor;

@end

@implementation AccountViewController
//@synthesize completion;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
   
}

- (void)constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[AccountDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
    [self.uiTableView reloadData];
}


- (NSString *)getNavigationTitle {
    return @"account";
}

#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.collectionView"]) {
       
       

        
    } else   if ([cellType isEqualToString:@"cell.type.search"]) {

    } else  if ([cellType isEqualToString:@"cell.type.comp"]) {
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
