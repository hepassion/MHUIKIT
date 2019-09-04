//
//  MHGlassMainViewController.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHGlassMainViewController.h"
#import "CommonDefine.h"
#import "UIImage+Category.h"
#import "UIView+Utils.h"
#import <SDWebImage/UIButton+WebCache.h>


@implementation MHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        
    }
    return self;
}

- (void)setLeftButton:(UIButton *)leftButton {
    if (_leftButton != leftButton) {
        [_leftButton removeFromSuperview];
        _leftButton = leftButton;
        [self addSubview:_leftButton];
        _leftButton.centerY = (self.height-MH_Status_Bar_Height)/2+MH_Status_Bar_Height;
        _leftButton.left = MHNavigationBarButtonDistanceToEdge;
    }
}
- (void)setRightTitleButton:(UIButton *)rightTitleButton {
    {
        if (_rightTitleButton != rightTitleButton) {
            [_rightTitleButton removeFromSuperview];
            _rightTitleButton = rightTitleButton;
            [self addSubview:rightTitleButton];
            rightTitleButton.centerY = (self.height-MH_Status_Bar_Height)/2+MH_Status_Bar_Height;
            rightTitleButton.right = self.width - MHNavigationBarButtonDistanceToEdge;
        }
    }
    
}

- (void)setRightImageButton:(UIButton *)rightImageButton {
    if (_rightImageButton != rightImageButton) {
        [_rightImageButton removeFromSuperview];
        _rightImageButton = rightImageButton;
        [self addSubview:rightImageButton];
        rightImageButton.centerY =  (self.height-MH_Status_Bar_Height)/2+MH_Status_Bar_Height;
    }
    if (self.rightTitleButton.titleLabel.text && self.rightTitleButton.titleLabel.text.length) { //显示图片 和 文字
        self.rightImageButton.right = self.width - MHNavigationBarButtonDistanceToEdge - self.rightTitleButton.width - MHNavigationBarButtonImageTextSpace;
    } else {//只显示图片
        self.rightImageButton.right =    self.width - MHNavigationBarButtonDistanceToEdge;
    }
}


#pragma mark lazy loading ---------

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                MH_Status_Bar_Height,
                                                                self.width*0.5,
                                                                MH_NAVIGATION_BAR_DEFAULT_HEIGHT)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.centerX = self.width/2.0f;
    }return _titleLabel;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - FIT6(1), MH_SCREEN_WIDTH, FIT6(1))];
    }return _lineView;
}



@end

@interface MHGlassMainViewController ()

@property (nonatomic, strong) UIButton *leftTitleButton;
@property (nonatomic, strong) UIButton *leftBackButton;
@property (nonatomic, strong) UIButton *leftCloseButton;
@property (nonatomic, strong) UIButton *rightTitleButton;
@property (nonatomic, strong) UIButton *rightImageButton;

@end

@implementation MHGlassMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;

    self.view.backgroundColor = HEX(0xF5F5F5);
    if (!self.config) {
        self.config = [[MHWebBrowserConfig alloc] init];
    }
    self.config.useSystemNavigationBar = NO;
    self.config.navigationBarHidden = NO;
    self.config.navigationTitleColor = MHDefaultTitleColor;
    self.config.navigationBarBackgroundColor = MHDefaultNavBackGroundColor;
    self.config.showNavigationBarBottomLine = YES;
    self.config.navigationBarBackButtonColor =  MHDefaultBackButtonColor;
    self.config.navigationLeftRightTitleFont = MHDefaultNavLeftRightTitleFont;
    self.config.navigationLeftRightTitleColor = MHDefaultLeftRightTitleColor;
    self.config.hidenBackButton = NO;
    self.config.showCloseButton = NO;
    
    [self.view addSubview:self.pageNavigationBar];
}
/**
 刷新、配置 NavigationBar。配置config后调用
 */
- (void)relodNavigationBar {
    if (self.config.navigationBarHidden  ) {
        self.pageNavigationBar.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
        return;
    }
    
    if (self.config.useSystemNavigationBar ) {
        [self decorateNavigationBar:self.navigationController.navigationBar];
    } else {
        [self decorateCustomNavigationBar:self.pageNavigationBar];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self relodNavigationBar];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
#pragma mark  decorate    NavigationBar   left right button ---------

- (void) decorateNavigationBar:(UINavigationBar *)navigationBar {
    [self.navigationController setNavigationBarHidden:NO];
    self.pageNavigationBar.hidden =  YES;
    //设置左右按钮
    [self decorateLeftButtonNavigationBar:navigationBar];
    [self decorateRightButtonNavigationBar:navigationBar];
    //设置标题属性
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary new];
    [titleTextAttributes setObject:self.config.navigationTitleColor forKey:NSForegroundColorAttributeName];
    [titleTextAttributes setObject:MHDefaultNavTitleFont forKey:NSFontAttributeName];
    navigationBar.titleTextAttributes = titleTextAttributes;
    //设置背景色
    UIColor* colorBackground = self.config.navigationBarBackgroundColor;
    navigationBar.barTintColor = colorBackground;
    //底部线
        if (self.config.showNavigationBarBottomLine) {
               [navigationBar setShadowImage:[UIImage imageWithColor:NavBarBottomLineDefaultColor]];
        } else {
            UIImage* image = [[UIImage alloc] init];
            navigationBar.shadowImage = image;
        }
    
    self.navigationItem.titleView = nil;
    self.navigationItem.title = self.config.navigationTitle;
    
}
//自定义导航栏
- (void) decorateCustomNavigationBar:(MHNavigationBar *)navigationBar {
    self.navigationController.navigationBar.hidden = YES;
    self.pageNavigationBar.hidden = NO;
    
    navigationBar.backgroundColor = self.config.navigationBarBackgroundColor;
    navigationBar.titleLabel.text = self.config.navigationTitle;
    navigationBar.titleLabel.textColor = self.config.navigationTitleColor;
    navigationBar.titleLabel.font = MHDefaultNavTitleFont;
    
    //左侧按钮
    if (self.config.showCloseButton) {
        self.pageNavigationBar.leftButton = self.leftCloseButton;
    } else {
        if (self.navigationController && [self.navigationController.viewControllers count] > 1 && !self.config.hidenBackButton) {//显示back button
            self.pageNavigationBar.leftButton = self.leftBackButton;
        } else {
            self.pageNavigationBar.leftButton = [UIButton new];
            if (self.config.navigationBarLeftTitle && self.config.navigationBarLeftTitle.length > 0) {//显示左侧按钮
                self.pageNavigationBar.leftButton = self.leftTitleButton;
            }
        }
    }
    
    
    //右边按钮
    if ( self.config.navigationBarRightTitle && self.config.navigationBarRightTitle.length && self.config.navigationBarRightImage && self.config.navigationBarRightImage.length ) {
        self.pageNavigationBar.rightTitleButton = self.rightTitleButton;
        self.pageNavigationBar.rightImageButton = self.rightImageButton;
    } else  if (self.config.navigationBarRightTitle && self.config.navigationBarRightTitle.length && (!self.config.navigationBarRightImage || !self.config.navigationBarRightImage.length)) {
        self.pageNavigationBar.rightTitleButton = self.rightTitleButton;
        self.pageNavigationBar.rightImageButton = [UIButton new];
    }  else  if (self.config.navigationBarRightImage && self.config.navigationBarRightImage.length && (!self.config.navigationBarRightTitle || !self.config.navigationBarRightTitle.length)) {
        self.pageNavigationBar.rightTitleButton = [UIButton new];
        self.pageNavigationBar.rightImageButton = self.rightImageButton;
    } else {//什么都不显示
        self.pageNavigationBar.rightImageButton  =  [UIButton new];
        self.pageNavigationBar.rightTitleButton = [UIButton new];
    }
    
    if (self.config.showNavigationBarBottomLine) {
        self.pageNavigationBar.lineView.hidden = NO;
        self.pageNavigationBar.lineView.backgroundColor = NavBarBottomLineDefaultColor;
    } else {
        self.pageNavigationBar.lineView.hidden = YES;
    }
    
}


- (void) decorateLeftButtonNavigationBar:(UINavigationBar *)navigationBar {
    if (self.config.showCloseButton) {
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftCloseButton];
        self.navigationItem.leftBarButtonItem = backItem;
        return;
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1 && !self.config.hidenBackButton) {
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBackButton];
        self.navigationItem.leftBarButtonItem = backItem;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        if ( self.config.navigationBarLeftTitle && self.config.navigationBarLeftTitle.length > 0) {
            UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftTitleButton];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

- (void) decorateRightButtonNavigationBar:(UINavigationBar *)navigationBar {
    if ( self.config.navigationBarRightTitle && self.config.navigationBarRightTitle.length && self.config.navigationBarRightImage && self.config.navigationBarRightImage.length ) {
        UIBarButtonItem* rightTitleItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightTitleButton];
        UIBarButtonItem* rightImageItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightImageButton];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: rightTitleItem, rightImageItem,nil];
    } else  if (self.config.navigationBarRightTitle && self.config.navigationBarRightTitle.length && (!self.config.navigationBarRightImage || !self.config.navigationBarRightImage.length)) {
        UIBarButtonItem* rightTitleItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightTitleButton];
        self.navigationItem.rightBarButtonItem = rightTitleItem;;
    }  else  if (self.config.navigationBarRightImage && self.config.navigationBarRightImage.length && (!self.config.navigationBarRightTitle || !self.config.navigationBarRightTitle.length)) {
        UIBarButtonItem* rightImageItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightImageButton];
        self.navigationItem.rightBarButtonItem = rightImageItem;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItems = nil;
    }
}



#pragma mark - lazy loading -------
- (MHNavigationBar *)pageNavigationBar {
    if (_pageNavigationBar == nil) {
        CGFloat height = MH_NAVIGATION_BAR_DEFAULT_HEIGHT+MH_Status_Bar_Height;
        CGRect frame = CGRectMake(0, 0, MH_SCREEN_WIDTH, height);
        _pageNavigationBar = [[MHNavigationBar alloc] initWithFrame:frame];
    }
    return _pageNavigationBar;
}

#pragma mark tap action -------------

- (void) backButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) closeButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void) navigationBarLeftTitleAction:(id)sender {
    NSLog(@"navigationBarLeftTitleAction");
}

- (void) navigationBarRightTitleAction:(id)sender {
    NSLog(@"navigationBarRightTitleAction");
}

- (void) navigationBarRightImageAction:(id)sender {
    NSLog(@"navigationBarRightImageAction");
}

- (void)hidenBackButton {
    if (self.config.useSystemNavigationBar) {
        self.navigationItem.leftBarButtonItem  = nil;
    } else {
        self.pageNavigationBar.leftButton.hidden = YES;
    }
}

- (void)showBackButton {
    if (self.config.useSystemNavigationBar) {
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBackButton];
        self.navigationItem.leftBarButtonItem = backItem;
    } else {
        self.pageNavigationBar.leftButton.hidden = NO;
    }
}

#pragma mark ui ---------
- (UIButton *) leftTitleButton {
    if (_leftTitleButton == nil) {
         _leftTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftTitleButton.tag = MHLeftTitleButtonTag;
        [_leftTitleButton setTitle:self.config.navigationBarLeftTitle forState:UIControlStateNormal];
        [_leftTitleButton addTarget:self action:@selector(navigationBarLeftTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_leftTitleButton setTitleColor:self.config.navigationLeftRightTitleColor forState:UIControlStateNormal];
    [_leftTitleButton setTitleColor:self.config.navigationLeftRightTitleColor forState:UIControlStateHighlighted];
    [_leftTitleButton.titleLabel setFont:self.config.navigationLeftRightTitleFont];
    //动态设置宽度
    NSDictionary *attribute = @{NSFontAttributeName:self.config.navigationLeftRightTitleFont};
    CGFloat textWidth = [self.config.navigationBarLeftTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40.0f) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
    _leftTitleButton.frame = CGRectMake(0.0f, 0.0f, textWidth, 40.0f);
    return _leftTitleButton;
}

- (UIButton *)leftBackButton {
    if (_leftBackButton == nil) {
        _leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBackButton.frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
        _leftBackButton.tag = MHBackButtonTag;
        [_leftBackButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImage *btnImage = [[UIImage imageNamed:@"back-button"] imageWithColor:self.config.navigationBarBackButtonColor];
    [_leftBackButton setImage:btnImage forState:UIControlStateNormal];
    if (self.config.useSystemNavigationBar) {
        [_leftBackButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -3.0f, 0.0f, 3.0f)];
    }
    return _leftBackButton;
}


- (UIButton *) leftCloseButton {
    if (_leftCloseButton == nil) {
         _leftCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftCloseButton.frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
        _leftCloseButton.tag = MHCloseButtonTag;
        [_leftCloseButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImage *btnImage = [[UIImage imageNamed:@"nav-close-button"] imageWithColor:self.config.navigationBarBackButtonColor];
    [_leftCloseButton setImage:btnImage forState:UIControlStateNormal];
    if (self.config.useSystemNavigationBar) {
        [_leftCloseButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -3.0f, 0.0f, 3.0f)];
    }
    return _leftCloseButton;
}


- (UIButton *) rightTitleButton {
    if (_rightTitleButton == nil) {
        _rightTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightTitleButton.frame = CGRectMake(0.0f, 0.0f, 0.0f, 40.0f);
        _rightTitleButton.tag = MHRightTitleButtonTag;
        [_rightTitleButton addTarget:self action:@selector(navigationBarRightTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_rightTitleButton.titleLabel setFont:self.config.navigationLeftRightTitleFont];
    [_rightTitleButton setTitleColor:self.config.navigationLeftRightTitleColor forState:UIControlStateNormal];
    [_rightTitleButton setTitleColor:self.config.navigationLeftRightTitleColor forState:UIControlStateHighlighted];
    [_rightTitleButton setTitle:self.config.navigationBarRightTitle forState:UIControlStateNormal];
    NSDictionary *attribute = @{NSFontAttributeName:self.config.navigationLeftRightTitleFont};
    CGFloat textWidth =   [self.config.navigationBarRightTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, _rightTitleButton.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
    _rightTitleButton.width = textWidth;
    return _rightTitleButton;
}



- (UIButton *) rightImageButton {
    if (_rightImageButton == nil) {
        _rightImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightImageButton.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
        _rightImageButton.tag = MHRightImageButtonTag;
        [_rightImageButton addTarget:self action:@selector(navigationBarRightImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
   

    UIImage *nilImage = [UIImage new];
    [_rightImageButton setImage:nilImage forState:UIControlStateNormal];
    [_rightImageButton setImage:nilImage forState:UIControlStateHighlighted];
    
    
    if (self.config.navigationBarRightImage && self.config.navigationBarRightImage.length) {
        if ([self.config.navigationBarRightImage rangeOfString:@"http:"].location == NSNotFound) {
            UIImage *image = [[UIImage imageNamed:self.config.navigationBarRightImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [_rightImageButton setImage:image forState:UIControlStateNormal];
            [_rightImageButton setImage:image forState:UIControlStateHighlighted];
            _rightImageButton.width = image.size.width;
            _rightImageButton.height = image.size.height;
        } else {
            [_rightImageButton sd_setImageWithURL:[NSURL URLWithString:self.config.navigationBarRightImage ]
                                         forState:UIControlStateNormal];
            [_rightImageButton sd_setImageWithURL:[NSURL URLWithString:self.config.navigationBarRightImage ]
                                         forState:UIControlStateHighlighted];
            _rightImageButton.width = 35;
            _rightImageButton.height = 35;
        }
    }
    


    return _rightImageButton;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

