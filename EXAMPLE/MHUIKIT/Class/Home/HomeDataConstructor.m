//
//  HomeDataConstructor.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/19.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "HomeDataConstructor.h"
#import "MHTitleTableViewCell.h"
@implementation HomeDataConstructor

- (void)loadData {
    self.pageIndex = FIRST_NO_PER_PAGE;
//    [[PDHttpClient sharedClient] getProductListWithType:2 page:self.pageIndex pageSize:SIZE_PER_PAGE Success:^(ProductListModel *listModel) {
//
//    } failure:^(NVErrorDataModel *dataModel) {
//
//    }];
    
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(networkDataContructor:didFinishWithData:)]) {
        [self.delegate networkDataContructor:self didFinishWithData:nil];
    }
    
}
- (void)constructData {
    [self.items removeAllObjects];
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"cell.type.block";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.block";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.lock";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.lock";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];

    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.html";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.html";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
 
    model = [MHTitleDataModel new];
    model.content = @"cell.type.failure";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.failure";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.baidu";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.baidu";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.task";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.task";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
}

@end
