
//
//  MHTableViewCellItemProtocol.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHPrefixHeader.pch"

@protocol MHTableViewCellItemProtocol <NSObject>

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) NSString* cellType;
@property (nonatomic, strong) NSNumber* cellHeight;
@property (nonatomic, strong) Class actionClass;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id cellInstance;

@end
