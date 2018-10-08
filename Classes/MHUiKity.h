//
//  MHUiKity.h
//  test
//
//  Created by minghe on 2018/10/8.
//  Copyright © 2018年 minghe. All rights reserved.
//

#ifndef MHUiKity_h
#define MHUiKity_h




#import "UIView+Utils.h"
#import "UIImage+Category.h"
#import "MHIndexPathArray.h"
#import "MHTableViewCellItemProtocol.h"
#import "MHTableViewCell.h"
#import "MHDataModel.h"
#import "MHTableViewHeaderView.h"
#import "MHTableViewFooterView.h"
#import "MHTableViewAdaptor.h"
#import "NSDictionary+Category.h"
#import "MHAppSchemaObserver.h"
#import "MHAsObservedObject.h"
#import "MHAsPublicParamObject.h"
#import "MHTaskObjectProtocol.h"
#import "EncryptEncodeHelper.h"
#import "MHUtility.h"
#import "NSString+Category.h"
#import "MHTableView.h"
#import "UIView+Utils.h"


#define StatusRect                                  [[UIApplication sharedApplication] statusBarFrame]
#define Status_Bar_Height                            StatusRect.size.height
#define NAVIGATION_BAR_DEFAULT_HEIGHT               44
#define iPhoneX                                      ([[UIScreen mainScreen] bounds].size.height == 812.0)
#define TAB_BAR_HEIGHT                               (iPhoneX?49:83)


#define SCREEN_SIZE                                  [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH                                  SCREEN_SIZE.width
#define SCREEN_HEIGHT                                 SCREEN_SIZE.height

#define FIT5(x)                 ((x)/640.0f)*SCREEN_WIDTH
#define FIT6(x)                 ((x)/750.0f)*SCREEN_WIDTH
#define FIT6P(x)                ((x)/1242.0f)*SCREEN_WIDTH

#define FONT_SYSTEM_SIZE(s)                 [UIFont systemFontOfSize:s]
#define FONT_BOLD_SYSTEM_SIZE(s)            [UIFont boldSystemFontOfSize:s]

#define HEXA(hex,a)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]
#define HEX(hex)                HEXA(hex,1)

#define COLOR_DEFAULT_WHITE        HEX(0xffffff)
#define COLOR_GRAY                  HEX(0xaaaaaa)
#define COLOR_ORANGE            HEX(0xfa5e3f)

#define WEAK_WITH_NAME_OBJECT(_obj, _name)      __weak typeof(_obj) weak##_name = _obj
#define WEAK(_obj)                              WEAK_WITH_NAME_OBJECT(_obj, _obj)
#define WEAK_SELF                               WEAK(self)

#define SIZE_PER_PAGE                   20
#define FIRST_NO_PER_PAGE               1




#endif /* MHUiKity_h */
