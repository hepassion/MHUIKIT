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
    CGRect frame = CGRectMake(0.0f, 0.0f, MH_SCREEN_WIDTH, 20);
    self = [super initWithFrame:frame];

    if (self) {
        
       self.backgroundColor        = [UIColor whiteColor];
        
     [self addSubview:self.uiTitle];
      
    }
    
    return self;
}


- (void)setModel:(MHTableViewFooterViewModel *)model {
    _model = model;
  //  self.uiTitle.text = model.footerTitle;
    self.uiTitle.text = [NSString stringWithFormat:@"%ld--%@",model.sectionIndex, model.footerTitle];

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

#pragma mark lazy loading ---------
- (UILabel *)uiTitle {
    if (_uiTitle == nil) {
        _uiTitle                = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, MH_SCREEN_WIDTH/2, [MHTableViewFooterView heightForFooterView])];
        _uiTitle.font           = FONT_SYSTEM_SIZE(FIT6(24));
        _uiTitle.textColor      = [UIColor blackColor];
    }return _uiTitle;
}


@end
