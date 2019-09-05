//
//  SortNetworkDataConstructor.m
//  MHUIKIT
//
//  Created by minghe on 2019/7/22.
//  Copyright © 2019 minghe. All rights reserved.
//

#import "SortNetworkDataConstructor.h"

@implementation SortNetworkDataConstructor

- (void)constructData {
    [self.items removeAllObjects];
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"冒泡";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.Bubble";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    model.showTopLine = YES;
    model.topLineColor = COLOR_GRAY;
    model.selectedStyle = UITableViewCellSelectionStyleGray;
    [self.items addObject:model];
}

@end
