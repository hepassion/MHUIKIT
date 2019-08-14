//
//  MHTableViewCell.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewCell.h"
#import "CommonDefine.h"
#import "UIView+Utils.h"

@interface MHTableViewCell ()

@property (nonatomic, strong)   UIView *topLine;
@property (nonatomic, strong)   UIView *bottomLine;
@property (nonatomic, strong)   UIImageView *rowImageView;



@end
@implementation MHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.rowImageView];
    
}


#pragma mark - height
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CGFloat height = 0;
    
    if ([object conformsToProtocol:@protocol(MHTableViewCellItemProtocol)]) {
        if ([object respondsToSelector:@selector(cellHeight)]) {
            if ([object cellHeight]) {
                height = [[object cellHeight] floatValue];
            }
        }
    }
    
    return height;
}

- (void)setItem:(MHDataModel *)item {
    if (_item != item && item != nil) {
        _item = item;
    }
    
    self.contentView.backgroundColor = self.item.normalBackgroudColor?self.item.normalBackgroudColor:MHTableViewCell_DEFAULT_BACKGROUND_COLOR;
    if (!self.item.selectedStyle) {
        self.selectionStyle = UITableViewCellSelectionStyleGray; //默认点击灰色
    } else{
        self.selectionStyle = _item.selectedStyle;
    }
    // top line    
    if (_item.showTopLine) {
        self.topLine.hidden = NO;
        self.topLine.left =  _item.topLineLeft;
        self.topLine.width = self.width - _item.topLineRight - _item.topLineLeft;
        self.topLine.backgroundColor = _item.topLineColor?_item.topLineColor: HEX(0xaaaaaa);
    }else {
        self.topLine.hidden = YES;
    }
    
    // bottom line
    if (_item.showBottomLine) {
        self.bottomLine.hidden = NO;
        self.bottomLine.bottom = [self.item.cellHeight floatValue];
        self.bottomLine.left =  self.item.bottomLineLeft;
        self.bottomLine.width = self.width - self.item.bottomLineLeft - self.item.bottomLineRight;
        self.bottomLine.backgroundColor = _item.bottomLineColor?_item.bottomLineColor: HEX(0xaaaaaa);
    }else {
        self.bottomLine.hidden = YES;
    }
    
    if (self.item.showRightRow) {
        self.rowImageView.hidden = NO;
        self.rowImageView.centerY = _item.cellHeight.floatValue/2.0f;
        self.rowImageView.left = self.width - FIT6P(77);
    } else {
        self.rowImageView.hidden = YES;
    }
    
    
    
    
}


+ (NSString*) cellIdentifier {
    return @"theDefaultCell";
}

+ (CGFloat) heightForCell {
    return 32.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            self.width,
                                                            FIT6(1))];
        _topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               self.height - FIT6(1),
                                                               self.width,
                                                               FIT6(1))];
        _bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _bottomLine;
}

-(UIImageView *)rowImageView {
    if (_rowImageView == nil) {
         _rowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_icon"]];
        _rowImageView.frame = CGRectMake(0, 0, FIT6P(30), FIT6P(42));
      //  _rowImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        _rowImageView.hidden = YES;

    }return _rowImageView;
}


@end
