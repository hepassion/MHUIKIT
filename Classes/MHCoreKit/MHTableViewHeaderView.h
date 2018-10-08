//
//  MHTableViewHeaderView.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHPrefixHeader.pch"
#import "MHDataModel.h"
@interface MHTableViewHeaderViewModel : MHDataModel

@property (nonatomic, strong) NSString* title;


@end


@interface MHTableViewHeaderView : UIView

@property (nonatomic, strong) MHTableViewHeaderViewModel* model;


/*!
 @property
 @abstract      设置header的高度。通过object来动态设置Cell的高度。
 */
+ (CGFloat) tableView:(UITableView*)tableView sectionHeaderHeightForObject:(MHTableViewHeaderViewModel *)object;


+ (CGFloat) heightForHeaderView;

@end
