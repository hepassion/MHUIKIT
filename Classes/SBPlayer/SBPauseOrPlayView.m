//
//  PauseOrPlayView.m
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBPauseOrPlayView.h"
@interface SBPauseOrPlayView ()

@end
@implementation SBPauseOrPlayView

- (void)drawRect:(CGRect)rect {
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.imageBtn setShowsTouchWhenHighlighted:YES];
    [self.imageBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    [self.imageBtn addTarget:self action:@selector(handleImageTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.imageBtn];

    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(200);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(void)handleImageTapAction:(UIButton *)button{
    button.selected = !button.selected;
    _state = button.isSelected ;
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:_state];
    }
}

@end
