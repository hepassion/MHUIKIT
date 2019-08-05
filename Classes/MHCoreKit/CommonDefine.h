//
//  CommonDefine.h
//  tseeee
//
//  Created by minghe on 2018/10/8.
//  Copyright © 2018年 minghe. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h



#define MH_StatusRect                                  [[UIApplication sharedApplication] statusBarFrame]
#define MH_Status_Bar_Height                            MH_StatusRect.size.height


#define MH_NAVIGATION_BAR_DEFAULT_HEIGHT               44
#define MH_TAB_BAR_HEIGHT                              49

#define MH_Bottom_DangerArea_Height (@available(iOS 11.0, *) ? [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom :0)

#define MH_NAVIGATION_TOP_ALL_HEIGHT                       (MH_NAVIGATION_BAR_DEFAULT_HEIGHT + MH_Status_Bar_Height)
#define MH_TAB_BAR_BOTTOM_ALL_HEIGHT                       (MH_TAB_BAR_HEIGHT + MH_Bottom_DangerArea_Height)


#define MH_SCREEN_SIZE                                  [[UIScreen mainScreen] bounds].size
#define MH_SCREEN_WIDTH                                  MH_SCREEN_SIZE.width
#define MH_SCREEN_HEIGHT                                 MH_SCREEN_SIZE.height
#define MH_SCREEN_SCALE                                  [UIScreen mainScreen].scale

#define FIT5(x)                 ((x)/640.0f)*MH_SCREEN_WIDTH
#define FIT6(x)                 ((x)/750.0f)*MH_SCREEN_WIDTH
#define FIT6P(x)                ((x)/1242.0f)*MH_SCREEN_WIDTH

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

