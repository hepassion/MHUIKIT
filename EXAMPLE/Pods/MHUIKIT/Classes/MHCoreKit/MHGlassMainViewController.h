//
//  MHGlassMainViewController.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHViewController.h"

#define MHDefaultTitleColor        HEX(0x3d9dff)
#define MHDefaultNavBackGroundColor    [UIColor whiteColor]
#define MHDefaultBackButtonColor         HEX(0x3d9dff)
#define MHDefaultLeftRightItemTitleColor     HEX(0x3d9dff)
#define NavBarBottomLineDefaultColor          HEX(0xaaaaaa)




@interface MHNavigationBar : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIButton* leftButton;
@property (nonatomic, strong) UIButton* rightButton;
@property (nonatomic, strong) UIView* lineView;

@end




@interface MHGlassMainViewController : MHViewController

@property (nonatomic, strong) MHNavigationBar* pageNavigationBar;
/**
是否使用默认导航栏
默认：NO 使用系统导航

@return NO 使用系统导航；YES 使用自定义导航
*/
- (BOOL) getCustomNavigationBar;

/**
是否隐藏导航栏
 默认：NO 不隐藏
 */
- (BOOL) hidenNavigationBar;


/**
 子类设置NavigationBar标题
 
 @return 标题
 */
- (NSString*) getNavigationTitle;

/**
 子类设置NavigationBar标题颜色
 
 @return 颜色
 */
- (UIColor*) getNavigationTitleColor;


/**
 子类设置NavigationBar标题属性
 
 @return 属性字典
 */
- (UIFont*) getNavigationTitleFont;

/**
 子类设置NavigationBar背景色
 
 @return 背景色
 */
- (UIColor*) getNavigationBarBackgroundColor;

/**
 是否显示NavigationBar 底部线颜色
 默认： yes 显示底部线颜色
 
 */
- (BOOL) getShowNavigationBarBottomLine;


/**
 子类设置NavigationBar 底部线颜色 背景色
 
 @return 背景色
 */
- (UIColor*) getNavigationBarBottomLineColor;



/**
 自定义返回按钮颜色
 
 @return 颜色
 */
- (UIColor*) getNavigationBarBackButtonColor;


/**
 边缘返回手势
 默认: NO 关闭
 
 @return YES开启 NO关闭
 */
- (BOOL) getNavigationBarEdgePanBack;


/**
 重构NavigationBar。
 @param navigationBar 配置导航栏
 */
- (void) decorateNavigationBar:(UINavigationBar*)navigationBar;//系统导航栏
- (void) decorateLeftButtonNavigationBar:(UINavigationBar*)navigationBar;
- (void) decorateRightButtonNavigationBar:(UINavigationBar*)navigationBar;

- (void) decorateCustomNavigationBar:(MHNavigationBar *)navigationBar;//自定义导航栏


- (NSString *) getCustomNavigationBarRightButtonTitle;
- (UIImage *) getCustomNavigationBarRightButtonImage;
- (UIColor *) getCustomNavigationBarRightButtonTintColor;
- (UIFont *) getCustomNavigationBarRightButtonFont;

- (NSString *) getCustomNavigationBarLeftButtonTitle;
- (UIImage *) getCustomNavigationBarLeftButtonImage;
- (UIColor *) getCustomNavigationBarLeftButtonTintColor;
- (UIFont *) getCustomNavigationBarLeftButtonFont;




/**
 拦截返回按钮点击事件，用于自定义事件操作处理
 
 @param sender UIBarItem
 */
- (void) backButtonAction:(id)sender;

- (void) customNavigationBarRightButtonAction:(id)sender;
- (void) customNavigationBarLeftButtonAction:(id)sender;
- (UIButton *) newBackButton ;

@end
