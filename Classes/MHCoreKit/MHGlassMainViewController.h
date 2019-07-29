//
//  MHGlassMainViewController.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHViewController.h"

#define MHDefaultNavLeftRightTitleFont       FONT_SYSTEM_SIZE(FIT6(26))//导航栏左右侧文字font
#define MHDefaultNavTitleFont                FONT_BOLD_SYSTEM_SIZE(FIT6(32))//导航栏标题font   **固定值**

#define MHDefaultTitleColor                  HEX(0x3d9dff)//导航栏标题颜色
#define MHDefaultLeftRightTitleColor         HEX(0x3d9dff)//导航栏左右侧文字颜色

#define MHDefaultNavBackGroundColor          [UIColor whiteColor]//导航栏背景色
#define MHDefaultBackButtonColor             HEX(0x3d9dff)//返回按钮颜色
#define NavBarBottomLineDefaultColor         HEX(0xaaaaaa)//底部线颜色   **固定值**


#define MHNavigationBarButtonImageTextSpace         5.0f
#define MHNavigationBarButtonDistanceToEdge         12.0f



#define MHBackButtonTag                             11001
#define MHLeftTitleButtonTag                        11002
#define MHRightTitleButtonTag                       11003
#define MHRightImageButtonTag                       11004
#define MHCloseButtonTag                             11005


NS_ASSUME_NONNULL_BEGIN

@interface MHNavigationBar : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIButton* leftButton;

@property (nonatomic, strong) UIButton* rightTitleButton;
@property (nonatomic, strong) UIButton* rightImageButton;

@property (nonatomic, strong) UIView* lineView;

@end


@interface MHWebBrowserConfig: NSObject

/**
 导航栏透明；YES 则WebView Y轴起始点为 0.0f； NO 则 Y起始点为64.0f
 */
@property (nonatomic, assign) BOOL useSystemNavigationBar; // 是否使用系统导航栏，yes 系统导航，no 自定义导航；默认 NO
@property (nonatomic, assign) BOOL navigationBarHidden;//是否隐藏导航栏    默认：NO 不隐藏
@property (nonatomic, assign) BOOL showCloseButton;//是否显示close  button    默认：NO 不隐藏
@property (nonatomic, strong) NSString* navigationTitle;//NavigationBar标题
@property (nonatomic, strong) UIColor* navigationTitleColor;//NavigationTitle标题颜色
@property (nonatomic, strong) UIColor*  navigationBarBackgroundColor;//NavigationBar 背景色
@property (nonatomic, assign) BOOL showNavigationBarBottomLine;// 是否显示NavigationBar底部线    yes 显示; no 不显示

@property (nonatomic, strong) UIColor*  navigationBarBackButtonColor ;//返回 close按钮颜色
@property (nonatomic, strong) UIColor*  navigationLeftRightTitleColor ;//左右侧文字color
@property (nonatomic, strong) UIFont*  navigationLeftRightTitleFont ;//左右侧文字font

@property (nonatomic, strong) NSString* navigationBarLeftTitle ;//左侧文字

@property (nonatomic, strong) NSString* navigationBarRightTitle ;//右侧文字
@property (nonatomic, strong) NSString* navigationBarRightImage ;//右侧图片

@property (nonatomic, assign) BOOL  hidenBackButton ;//隐藏返回按钮，默认NO：不隐藏。yes：隐藏，

@end


@interface MHGlassMainViewController : MHViewController
@property (nonatomic, strong) MHWebBrowserConfig*  config;
@property (nonatomic, strong) MHNavigationBar*  pageNavigationBar;


/**
 刷新、配置 NavigationBar。配置config后调用
 */
- (void)relodNavigationBar;



/**
 点击事件
 */
- (void) backButtonAction:(id )sender;
- (void) closeButtonAction:(id)sender;
- (void) navigationBarLeftTitleAction:(id)sender;

- (void) navigationBarRightTitleAction:(id)sender;
- (void) navigationBarRightImageAction:(id)sender;



@end
NS_ASSUME_NONNULL_END
