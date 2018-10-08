//
//  MHTableViewCell.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewCell.h"
#import "MHUiKity.h"
@interface MHTableViewCell ()

@property (nonatomic, strong)   UIView *topLine;
@property (nonatomic, strong)   UIView *bottomLine;

@end
@implementation MHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.bottomLine];
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
    self.backgroundColor = self.item.normalBackgroudColor?self.item.normalBackgroudColor:MHTableViewCell_DEFAULT_BACKGROUND_COLOR;
    self.item.selectedBackgroudColor =  self.item.selectedBackgroudColor ?  self.item.selectedBackgroudColor : MHTableViewCell_DEFAULT_SELECT_BGCOLOR;
    
   
    // top line
    
    
    if (self.item.showTopLine) {
        self.topLine.hidden = NO;
        self.topLine.left =  self.item.topLineLeft;
        self.topLine.width = self.width - self.item.topLineRight - self.item.topLineLeft;
        self.topLine.backgroundColor = self.item.topLineColor;
    }else {
        self.topLine.hidden = YES;
    }
    
    // bottom line
    if (self.item.showBottomLine) {
        self.bottomLine.hidden = NO;
        self.bottomLine.bottom = [self.item.cellHeight floatValue];
        self.bottomLine.left =  self.item.bottomLineLeft;
        self.bottomLine.width = self.width - self.item.bottomLineLeft - self.item.bottomLineRight;
        self.bottomLine.backgroundColor = self.item.bottomLineColor;
    }else {
        self.bottomLine.hidden = YES;
    }
    
    self.accessoryType  = self.item.accessoryType;
    
    
}


+ (NSString*) cellIdentifier {
    return @"theDefaultCell";
}

+ (CGFloat) heightForCell {
    return 32.0f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == MHTBCellSelectedStyleCustom) {
        self.backgroundColor = self.item.selectedBackgroudColor;
        
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == MHTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = weakself.item.normalBackgroudColor?weakself.item.normalBackgroudColor:MHTableViewCell_DEFAULT_BACKGROUND_COLOR;
        }];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.item.selectedStyle == MHTBCellSelectedStyleCustom) {
        WEAK_SELF;
        [UIView animateWithDuration:0.5 animations:^{
            weakself.backgroundColor = weakself.item.normalBackgroudColor?weakself.item.normalBackgroudColor:MHTableViewCell_DEFAULT_BACKGROUND_COLOR;
        }];
    }
    [super touchesCancelled:touches withEvent:event];
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
        _topLine.backgroundColor = self.item.topLineColor?self.item.topLineColor:[UIColor lightGrayColor];
       
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
        _bottomLine.backgroundColor = self.item.bottomLineColor?self.item.bottomLineColor:[UIColor lightGrayColor];
    }
    return _bottomLine;
}


@end
