
//
//  ProductDataConstructor.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/20.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "ProductDataConstructor.h"

@implementation ProductDataConstructor
- (void)constructData {
    [self.items removeAllObjects];
    
   
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"cell.type.task";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.task";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
}
@end
