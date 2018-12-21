//
//  CommonDefine.h
//  tseeee
//
//  Created by minghe on 2018/10/8.
//  Copyright © 2018年 minghe. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h



#define StatusRect                                  [[UIApplication sharedApplication] statusBarFrame]
#define Status_Bar_Height                            StatusRect.size.height
#define Status_Bar_Width                             StatusRect.size.width

#define NAVIGATION_BAR_DEFAULT_HEIGHT               44
#define TAB_BAR_HEIGHT                            [UIApplication dd_rootTabBarController].tabBar.bounds.size.height


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

#define WEAK_WITH_NAME_OBJECT(_obj, _name)      __weak typeof(_obj) weak##_name = _obj
#define WEAK(_obj)                              WEAK_WITH_NAME_OBJECT(_obj, _obj)
#define WEAK_SELF                               WEAK(self)

#define SIZE_PER_PAGE                   20
#define FIRST_NO_PER_PAGE               1
#endif /* CommonDefine_h */

