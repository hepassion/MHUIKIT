//
//  MHTitleTableViewCell.m
//  DDSD
//
//  Created by minghe on 2018/10/15.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTitleTableViewCell.h"

@implementation MHTitleDataModel


@end

@implementation MHTitleTableViewCell
- (void)initUI {
    [super initUI];
}

+ (CGFloat)heightForCell {
    return FIT6(100);
}

- (void)setItem:(MHDataModel *)item {
    [super setItem:item];
    MHTitleDataModel *model = (MHTitleDataModel *)self.item;
    self.textLabel.text = model.content;
}

/*!
 @property
 @abstract      设置Cell的高度。通过object来动态设置Cell的高度。
// */
//+ (CGFloat) tableView:(UITableView*)tableView rowHeightForObject:(id)object {
//    // model.cellHeight = height;
//    TestTableViewCellModel *model = (TestTableViewCellModel *)object;
//    model.cellHeight = @(100);
//
//    return 100;
//}

@end
