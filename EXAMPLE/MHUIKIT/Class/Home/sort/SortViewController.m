//
//  SortViewController.m
//  MHUIKIT
//
//  Created by minghe on 2019/7/22.
//  Copyright © 2019 minghe. All rights reserved.
//

#import "SortViewController.h"
#import "SortNetworkDataConstructor.h"
@interface SortViewController ()
@property (nonatomic, strong) SortNetworkDataConstructor *dataConstructor;
@property (nonatomic, strong) NSMutableArray *dataArray ;


@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.config.navigationTitle = @"排序";
    self.dataArray = [NSMutableArray arrayWithObjects:@(4), @(2), @(0), @(3), @(4), @(1), nil];
}

- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[SortNetworkDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
    [self.dataConstructor constructData];
    self.adaptor.items = self.dataConstructor.items;
    [self.uiTableView reloadData];
}

#pragma mark NVTableViewAdaptor Delegate
- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    int a[6] = {4, 2, 0, 3,4, 1};
    
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.Bubble"]) {
        bubbleWithArray(a);
  

    }
}

void bubbleWithArray(int score[]) {
    
    
    
    
}

- (void)bubbleWithArray:(NSMutableArray *)array {

    for (int i = 0; i< array.count; i ++) {
        
        for (int j = 1; j < array.count; j ++) {
            NSInteger left = [(NSNumber *)array[i] integerValue];
            
            NSInteger right = [(NSNumber *)array[j] integerValue];
            if (left > right) {
                NSInteger tem = left;
                array[i] = array[j];
                array[j] = @(tem);
                
            }
            
            
        }
        
        
        
    }
    
    
}



@end
