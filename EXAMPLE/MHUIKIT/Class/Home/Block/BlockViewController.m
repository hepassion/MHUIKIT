//
//  BlockViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "BlockViewController.h"
#import "SBPlayer.h"

@interface BlockViewController ()

//@property (nonatomic, copy) void(^textBlock)(NSString *);
@property (nonatomic, strong) SBPlayer *player;

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.uiTableView.top = NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height;
    
    self.player = [[SBPlayer alloc]initWithUrl:[NSURL URLWithString:@"http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4"]  frame:CGRectMake(0, NAVIGATION_BAR_DEFAULT_HEIGHT + Status_Bar_Height, SCREEN_WIDTH, 250)];
    //设置标题
    [self.player setTitle:@"这是一个标题"];
    //设置播放器填充模式 默认SBLayerVideoGravityResizeAspectFill，可以不添加此语句
    self.player.mode = SBLayerVideoGravityResizeAspectFill;
    //添加播放器到视图
    [self.view addSubview:self.player];
  
    
}

#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.block"]) {
        
    }
    
    
}

- (BOOL)getNavigationBarEdgePanBack {
    return NO;
}


- (void) constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[BlockDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
//    [self.dataConstructor constructData];
//    self.adaptor.items = self.dataConstructor.items;
//    [self.uiTableView reloadData];
}

- (NSString *)getNavigationTitle {
    return @"block test";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player stop];
}

- (void)dealloc {
    [self.view removeAllSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
