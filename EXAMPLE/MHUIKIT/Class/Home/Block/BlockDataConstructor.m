//
//  BlockDataConstructor.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "BlockDataConstructor.h"
#import "VideoTableViewCell.h"
@implementation BlockDataConstructor

- (void)constructData {
    [self.items removeAllObjects];
    
    VideoTableViewCellModel *videomodel = [VideoTableViewCellModel new];
    videomodel.url = @"http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4";
    videomodel.cellClass = [VideoTableViewCell class];
    videomodel.cellType  = @"cell.type.video";
    videomodel.cellHeight = @([VideoTableViewCell heightForCell]);
    videomodel.delegate = self.viewControllerDelegate;
    [self.items addObject:videomodel];
    
    
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"cell.type.block";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.block";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.test";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.test";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    [self.items addObject:model];
    
    
    
    
  
}


@end
