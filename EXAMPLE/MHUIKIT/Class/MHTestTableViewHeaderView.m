//
//  MHTestTableViewHeaderView.m
//  MHUIKIT
//
//  Created by minghe on 2018/12/20.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTestTableViewHeaderView.h"
#import <MHUIKIT/UIView+Utils.h>
@implementation MHTestTableViewHeaderViewModel

@end

@interface MHTestTableViewHeaderView ()

@property (nonatomic, strong) UILabel *mideLabel;

@end


@implementation MHTestTableViewHeaderView


- (id) initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
     self.backgroundColor = [UIColor greenColor];
    if (self) {
        [self addSubview:self.mideLabel];
        
    }
    
    return self;
}

- (void)setModel:(MHTableViewHeaderViewModel *)model {
    [super setModel:model];
    MHTestTableViewHeaderViewModel *testModel = (MHTestTableViewHeaderViewModel *)model;
    
    self.mideLabel.text = testModel.midleText;
    

}


- (UILabel *)mideLabel {
    if (_mideLabel == nil) {
        _mideLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6(290), 0, FIT6(200), FIT6(60))];
        _mideLabel.centerY = [MHTestTableViewHeaderView heightForHeaderView] / 2.0f;
    }return _mideLabel;
}

+ (CGFloat) heightForHeaderView {
    return 100.0f;
}


@end
