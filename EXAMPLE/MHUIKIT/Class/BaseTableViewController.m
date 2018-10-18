//
//  BaseTableViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/19.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.uiTableView.backgroundColor = [UIColor whiteColor];
    
//    self.uiTableView.top = 64;//self.pageNavigationBar.bottom;
//    self.uiTableView.height = SCREEN_HEIGHT - 64;//self.pageNavigationBar.height;
//    self.uiTableView.backgroundColor = COLOR_JJ_BACKGROUND;
//    // Do any additional setup after loading the view.
}

#pragma mark - NavigationBar

- (NSString*) getNavigationTitle {
    return @"title";
}


- (UIColor*) getNavigationTitleColor {
    return [UIColor blackColor];
}

- (UIColor*) getNavigationBarBackgroundColor {
    return COLOR_ORANGE;
}

- (BOOL)getNavigationBarEdgePanBack {
    return YES;
}


- (UIColor *)getCustomNavigationBarLeftButtonTintColor {
    return   HEX(0x313131)   ;
}

- (UIColor *)getCustomNavigationBarRightButtonTintColor {
    return   HEX(0x313131)   ;
}

- (UIColor *)getNavigationBarBackButtonColor {
    return [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
