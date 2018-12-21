//
//  MHTableView.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>


/*!
 @property
 @abstract      继承UITableViewDataSource.
 设置某个section是否分组
 */
@protocol MHTableViewDataSource <NSObject, UITableViewDataSource>


@end

@interface MHTableView : UITableView


@end
