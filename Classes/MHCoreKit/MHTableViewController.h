//
//  MHTableViewController.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHGlassMainViewController.h"
#import "MHTableView.h"
#import "MHTableViewAdaptor.h"


@interface MHTableViewController : MHGlassMainViewController<UITableViewDataSource, UITableViewDelegate> {
    BOOL _isLoading;
}


@property (nonatomic, strong) MHTableView* uiTableView;         //tableView
@property (nonatomic, strong) MHTableViewAdaptor* adaptor;      //tableView delegate

/**
 从DataConstructor重新载入，刷新Tableview的Cell
 */
- (void) reloadTableViewData;

/**
 子类必须重写
 */
- (void) constructData;

- (UITableViewStyle)getTableViewStyle;


@end
