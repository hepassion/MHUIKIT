//
//  MHTableViewFooterView.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDataModel.h"

@interface MHTableViewFooterViewModel : MHDataModel

@property (nonatomic, strong) NSString* footerTitle;
@property (nonatomic, assign) NSInteger sectionIndex;


@end


@interface MHTableViewFooterView : UIView

@property (nonatomic, strong) MHTableViewFooterViewModel* model;


/*!
 @property
 @abstract      设置header的高度。通过object来动态设置Cell的高度。
 */
+ (CGFloat) tableView:(UITableView*)tableView sectionFooterHeightForObject:(MHTableViewFooterViewModel *)object;


+ (CGFloat) heightForFooterView;
@end
