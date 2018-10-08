//
//  MHTableViewFooterView.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewFooterView.h"
#import "CommonDefine.h"

@implementation MHTableViewFooterViewModel
@end

@interface MHTableViewFooterView ()

@property (nonatomic, strong) UILabel* uiTitle;

@end

@implementation MHTableViewFooterView


- (id) init {
    CGRect frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 20);
    self = [super initWithFrame:frame];
   // self.backgroundColor = [UIColor blueColor];

    if (self) {
        
       self.backgroundColor        = COLOR_GRAY;
        
        self.uiTitle                = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 0.0f,200, 20.0f)];
        [self addSubview:self.uiTitle];
        self.uiTitle.font           = FONT_SYSTEM_SIZE(FIT6(24));
        self.uiTitle.textColor      = [UIColor blackColor];
    }
    
    return self;
}


- (void)setModel:(MHTableViewFooterViewModel *)model {
    _model = model;
    self.uiTitle.text = model.footerTitle;
    
}


+ (CGFloat) tableView:(UITableView*)tableView sectionFooterHeightForObject:(MHTableViewFooterViewModel *)object {
    CGFloat height = 0;
    
    if ([object conformsToProtocol:@protocol(MHTableViewCellItemProtocol)]) {
        if ([object respondsToSelector:@selector(cellHeight)]) {
            if ([object cellHeight]) {
                height = [[object cellHeight] floatValue];
            }
        }
    }
   // return 100;
    return height;
}


+ (CGFloat) heightForFooterView {
    return 20.0f;
}


@end
