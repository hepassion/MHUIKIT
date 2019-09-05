//
//  LockDataConstructor.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "LockDataConstructor.h"

@implementation LockDataConstructor

- (void)constructData {
    [self.items removeAllObjects];
    
  
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"cell.type.synchronized";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.synchronized";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
    model = [MHTitleDataModel new];
    model.content = @"showBack";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.showBack";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
}


@end
