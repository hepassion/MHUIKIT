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
    self.config.navigationTitle = @"navigationTitle";
    //明鹤
}

#pragma mark - NavigationBar





//- (UITableViewStyle )getTableViewStyle {
//    return UITableViewStyleGrouped;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
