//
//  MHTableViewHeaderView.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewHeaderView.h"
@implementation MHTableViewHeaderViewModel

@end

@interface MHTableViewHeaderView ()

@property (nonatomic, strong) UILabel* uiTitle;

@end

@implementation MHTableViewHeaderView

- (id) init {
    CGRect frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 20.0f);
    self = [super initWithFrame:frame];
   // self.backgroundColor = [UIColor greenColor];
    if (self) {
        
        self.backgroundColor        = COLOR_GRAY;
        
        self.uiTitle                = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, SCREEN_WIDTH/2, 20.0f)];
        [self addSubview:self.uiTitle];
        self.uiTitle.font           = FONT_SYSTEM_SIZE(FIT6(24));
        self.uiTitle.textColor      = [UIColor blackColor];
    }
    
    return self;
}

- (void)setModel:(MHTableViewHeaderViewModel *)model {
    _model = model;
    self.uiTitle.text = model.title;
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


@end
