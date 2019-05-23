//
//  VideoTableViewCell.m
//  MHUIKIT
//
//  Created by minghe on 2018/11/15.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "SBPlayer.h"
@implementation VideoTableViewCellModel
@end
@implementation VideoTableViewCell

- (void)initUI {
    [super initUI];
    
    
    SBPlayer *player = [[SBPlayer alloc]initWithUrl:[NSURL URLWithString:@"http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4"]  frame:CGRectMake(0, MH_NAVIGATION_BAR_DEFAULT_HEIGHT + MH_Status_Bar_Height, MH_SCREEN_WIDTH, 250)];
    //设置标题ı
    [player setTitle:@"这是一个标题"];
    //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
    player.mode = SBLayerVideoGravityResizeAspectFill;
    //添加播放器到视图
    [self.contentView addSubview:player];
    
}

+ (CGFloat)heightForCell {
    return 250;
}

- (void)setItem:(MHDataModel *)item {
    [super setItem:item];
   // [self.contentView removeAllSubviews];
    VideoTableViewCellModel *model = (VideoTableViewCellModel *)self.item;
   
}

@end
