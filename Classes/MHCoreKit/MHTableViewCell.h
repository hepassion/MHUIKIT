//
//  MHTableViewCell.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDataModel.h"


#define MHTableViewCell_DEFAULT_BACKGROUND_COLOR                          [UIColor whiteColor]
/*!
 @class
 @abstract      继承UITableViewCell
 a) Cell需继承PATableViewCell
 b) DataModel需继承NVDataModel
 */
@interface MHTableViewCell : UITableViewCell
/*!
 @property
 @abstract      DataModel对象
 */
@property (nonatomic, strong) MHDataModel *item;

/*!
 @property
 @abstract      设置Cell的高度。通过object来动态设置Cell的高度。
 */
+ (CGFloat) tableView:(UITableView*)tableView rowHeightForObject:(id)object;

/**
 初始化UI
 */
- (void)initUI;

/*!
 @property
 @abstract      Cell的标识
 */
+ (NSString*) cellIdentifier;

/*!
 @property
 @abstract      Cell的高度
 */
+ (CGFloat) heightForCell;
@end
