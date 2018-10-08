//
//  MHDataModel.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTableViewCellItemProtocol.h"
#import "MHPrefixHeader.pch"

typedef enum : NSUInteger {
    MHTBCellSelectedStyleNone,
    MHTBCellSelectedStyleCustom,
} MHTBCellSelectedStyle;

@interface MHDataModel : NSObject<MHTableViewCellItemProtocol>


@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) MHTBCellSelectedStyle selectedStyle;
@property (nonatomic, strong) UIColor *normalBackgroudColor;
@property (nonatomic, strong) UIColor *selectedBackgroudColor;              //Cell选中背景色-默认白色

@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

@property (nonatomic, assign) BOOL showTopLine;                             //顶部分割组线
@property (nonatomic, strong) UIColor *topLineColor;
@property (nonatomic, assign) CGFloat topLineLeft;
@property (nonatomic, assign) CGFloat topLineRight;

@property (nonatomic, assign) BOOL showBottomLine;                          //底部分割线
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) CGFloat bottomLineLeft;
@property (nonatomic, assign) CGFloat bottomLineRight;

@end




@interface MHListModel<ObjectType> : MHDataModel
@property (nonatomic, strong) NSMutableArray<ObjectType>* items;
@property (nonatomic, assign) NSInteger total;

@end
