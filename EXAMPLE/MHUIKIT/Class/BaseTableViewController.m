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
  //min
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

- (BOOL)getShowNavigationBarBottomLine {
    return YES;
}

- (UIColor *)getNavigationBarBottomLineColor {
    return [UIColor greenColor];
}

//- (UITableViewStyle )getTableViewStyle {
//    return UITableViewStyleGrouped;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
