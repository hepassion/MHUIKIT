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


@interface MHTitleTableViewCell ()

@property (nonatomic, strong) UILabel *leftLabel;

@end


@implementation MHTitleTableViewCell

- (void)initUI {
    [super initUI];
    [self.contentView addSubview:self.leftLabel];
}

+ (CGFloat)heightForCell {
    return FIT6(100);
}

- (void)setItem:(MHDataModel *)item {
    [super setItem:item];
    MHTitleDataModel *model = (MHTitleDataModel *)self.item;
    self.leftLabel.text = model.content;
}
- (UILabel *)leftLabel {
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6(50), 0, FIT6(400), FIT6(60))];
        _leftLabel.centerY = [MHTitleTableViewCell heightForCell] / 2.0f;
    }return _leftLabel;
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
