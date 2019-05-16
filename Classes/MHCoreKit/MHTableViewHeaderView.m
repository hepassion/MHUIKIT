//
//  MHTableViewHeaderView.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewHeaderView.h"
#import "CommonDefine.h"
@implementation MHTableViewHeaderViewModel

@end

@interface MHTableViewHeaderView ()


@end

@implementation MHTableViewHeaderView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor        = [UIColor whiteColor];
        // [self addSubview:self.uiTitle];

    }
    return self;
}

- (void)setModel:(MHTableViewHeaderViewModel *)model {
    _model = model;
    // UI赋值
 //   self.uiTitle.text = [NSString stringWithFormat:@"%ld--%@",model.sectionIndex, model.title];
}

+ (CGFloat) tableView:(UITableView*)tableView sectionHeaderHeightForObject:(MHTableViewHeaderViewModel *)object {
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




+ (CGFloat) heightForHeaderView {
    return 20.0f;
}

#pragma mark lazy loading ---------
- (UILabel *)uiTitle {
    if (_uiTitle == nil) {
        _uiTitle                = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, MH_SCREEN_WIDTH/2, [MHTableViewHeaderView heightForHeaderView])];
        _uiTitle.font           = FONT_SYSTEM_SIZE(FIT6(24));
        _uiTitle.textColor      = [UIColor blackColor];
    }return _uiTitle;
}

@end
