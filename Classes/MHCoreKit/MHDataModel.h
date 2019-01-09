//
//  MHDataModel.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTableViewCellItemProtocol.h"
#import <UIKit/UIKit.h>

@interface MHDataModel : NSObject<MHTableViewCellItemProtocol>


@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) UITableViewCellSelectionStyle selectedStyle; //cell点击效果
@property (nonatomic, strong) UIColor *normalBackgroudColor;                //cell 背景色

@property (nonatomic, assign) BOOL showRightRow;                             //显示右侧箭头  yes显示  no不显示


@property (nonatomic, assign) BOOL showTopLine;                             //顶部分割组线
@property (nonatomic, strong) UIColor *topLineColor;
@property (nonatomic, assign) CGFloat topLineLeft;
@property (nonatomic, assign) CGFloat topLineRight;

@property (nonatomic, assign) BOOL showBottomLine;                          //底部分割线
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) CGFloat bottomLineLeft;
@property (nonatomic, assign) CGFloat bottomLineRight;

- (NSDictionary*) dictionaryValue;

@end




@interface MHListModel<ObjectType> : MHDataModel
@property (nonatomic, strong) NSMutableArray<ObjectType>* items;
@property (nonatomic, assign) NSInteger total;

@end
