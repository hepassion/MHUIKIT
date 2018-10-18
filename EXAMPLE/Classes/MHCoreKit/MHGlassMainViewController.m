//
//  MHGlassMainViewController.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/14.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHGlassMainViewController.h"
#define MHNavigationBarButtonImageTextSpace         3.0f
#define MHNavigationBarButtonDistanceToEdge         12.0f
#define MHBackButtonTag                             11001

#define BACK_BUTTON_TITLE_COLOR                      [UIColor colorWithRed:227.0f/255.0f green:100.0f/255.0f blue:102.0f/255.0f alpha:1.0f]

@implementation MHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
       
    }
    return self;
}

- (void)setLeftButton:(UIButton *)leftButton {
    if (_leftButton != leftButton) {
        [_leftButton removeFromSuperview];
        
        _leftButton = leftButton;
        [self addSubview:_leftButton];
       
        //动态设置宽度
        NSDictionary *attribute = @{NSFontAttributeName:leftButton.titleLabel.font};
        CGFloat textWidth = [leftButton.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, leftButton.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
        CGFloat width = 0.0f;
        CGFloat imageWidth  = 0.0f;
        if (_leftButton.currentImage != nil) {
            UIImage *image = _leftButton.currentImage;
            CGFloat widthInPoints = image.size.width;
            imageWidth = widthInPoints;
            width += imageWidth;
        }
        
        if (leftButton.titleLabel.text.length > 0) {
            width += textWidth;
        }
        
        if (leftButton.titleLabel.text.length > 0 && _leftButton.currentImage != nil) {
            width += MHNavigationBarButtonImageTextSpace;
            leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, textWidth + MHNavigationBarButtonImageTextSpace, 0, -textWidth - MHNavigationBarButtonImageTextSpace);
            leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth- MHNavigationBarButtonImageTextSpace, 0, imageWidth + MHNavigationBarButtonImageTextSpace);
        }
        if (_leftButton.tag == MHBackButtonTag) {
            width += 15;
            [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -1.0f, 0.0f, 1.0f)];
            [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        _leftButton.width = width ;
        _leftButton.centerY = (self.height-Status_Bar_Height)/2+Status_Bar_Height;
        _leftButton.left = MHNavigationBarButtonDistanceToEdge;
    }
}

- (void)setRightButton:(UIButton *)rightButton {
    if (_rightButton != rightButton) {
        [_rightButton removeFromSuperview];
        
        _rightButton = rightButton;
        [self addSubview:_rightButton];
        
        //动态设置宽度
        NSDictionary *attribute = @{NSFontAttributeName:rightButton.titleLabel.font};
      CGFloat textWidth =   [rightButton.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, rightButton.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
        
        CGFloat width = 0.0f;
        CGFloat imageWidth  = 0.0f;
        if (_rightButton.currentImage != nil) {
            UIImage *image = _rightButton.currentImage;
            CGFloat widthInPoints = image.size.width;
            
            imageWidth = widthInPoints;
            width += imageWidth;
        }
        
        if (rightButton.titleLabel.text.length > 0) {
            width += textWidth;
        }
        
        if (rightButton.titleLabel.text.length > 0 && _rightButton.currentImage != nil) {
            width += MHNavigationBarButtonImageTextSpace;
            rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, textWidth + MHNavigationBarButtonImageTextSpace, 0, -textWidth - MHNavigationBarButtonImageTextSpace);
            rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth- MHNavigationBarButtonImageTextSpace, 0, imageWidth + MHNavigationBarButtonImageTextSpace);
        }
        
        _rightButton.width = width;
        
        _rightButton.centerY = (self.height-Status_Bar_Height)/2+Status_Bar_Height;
        _rightButton.right = self.width - MHNavigationBarButtonDistanceToEdge;
    }
}

#pragma mark lazy loading ---------

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               Status_Bar_Height,
                                                               self.width*0.3,
                                                               NAVIGATION_BAR_DEFAULT_HEIGHT)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.centerX = self.width/2.0f;
        _titleLabel.font = FONT_SYSTEM_SIZE(FIT6(38));
    }return _titleLabel;
}





@end

@interface MHGlassMainViewController ()

@end

@implementation MHGlassMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.pageNavigationBar];
    
    //边缘手势
    if ([self getNavigationBarEdgePanBack]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //保证给个控制器导航有固定的样式
    if ([self getCustomNavigationBar]) {
        [self decorateCustomNavigationBar:self.pageNavigationBar];
    } else {
        [self decorateNavigationBar:self.navigationController.navigationBar];
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark get value -----------
- (BOOL) getCustomNavigationBar {
    return YES;
}

- (NSString*) getNavigationTitle {
    return @"default title";
}
- (UIColor*) getNavigationTitleColor {
    return MHDefaultTitleColor;
}

- (UIFont *)getNavigationTitleFont {
    return FONT_SYSTEM_SIZE(FIT6(38));
}

- (UIColor*) getNavigationBarBackgroundColor {
    return MHDefaultNavBackGroundColor;
}

- (UIColor*) getNavigationBarBackButtonColor {
    return MHDefaultBackButtonColor ;
}

- (BOOL) getNavigationBarEdgePanBack {
    return YES;
}

#pragma mark right button --------
- (NSString *) getCustomNavigationBarRightButtonTitle {
    return @"";
}
- (UIImage *) getCustomNavigationBarRightButtonImage {
    return nil;
}

- (UIColor *) getCustomNavigationBarRightButtonTintColor {
    return MHDefaultLeftRightItemTitleColor;
}
- (UIFont *) getCustomNavigationBarRightButtonFont {
    return  FONT_SYSTEM_SIZE(FIT6(34));
    
}
#pragma mark left button --------

- (NSString *) getCustomNavigationBarLeftButtonTitle {
    return @"";
}

- (UIImage *) getCustomNavigationBarLeftButtonImage {
    return nil;
}

- (UIColor *) getCustomNavigationBarLeftButtonTintColor {
    return MHDefaultLeftRightItemTitleColor;
}

- (UIFont *) getCustomNavigationBarLeftButtonFont {
    return  FONT_SYSTEM_SIZE(FIT6(34));
}


#pragma mark  decorate    NavigationBar   left right button ---------

- (void) decorateNavigationBar:(UINavigationBar *)navigationBar {
    [self.navigationController setNavigationBarHidden:NO];
    self.pageNavigationBar.hidden =  YES;
    //preventing weird inset
    
    //设置左右按钮
    [self decorateLeftButtonNavigationBar:navigationBar];
    [self decorateRightButtonNavigationBar:navigationBar];
    
    //设置标题属性
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary new];
    if ([self getNavigationTitleColor]) {
        [titleTextAttributes setObject:[self getNavigationTitleColor] forKey:NSForegroundColorAttributeName];
        navigationBar.titleTextAttributes = titleTextAttributes;
    }
    if ([self getNavigationTitleFont]) {
        [titleTextAttributes setObject:[self getNavigationTitleFont] forKey:NSFontAttributeName];
        navigationBar.titleTextAttributes = titleTextAttributes;
    }
    
    //设置背景色
    UIColor* colorBackground = [self getNavigationBarBackgroundColor];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:colorBackground] forBarMetrics:UIBarMetricsDefault];
    
    //去除发丝线
    UIImage* image = [[UIImage alloc] init];
    navigationBar.shadowImage = image;
    
    
    self.navigationItem.titleView = nil;
    self.title = [self getNavigationTitle];

}
 //自定义导航栏
- (void) decorateCustomNavigationBar:(MHNavigationBar *)navigationBar {
    [self.navigationController setNavigationBarHidden:YES];
    self.pageNavigationBar.hidden = NO;
  //  [self setAutomaticallyAdjustsScrollViewInsets:YES];//TODO
    
    navigationBar.backgroundColor = [self getNavigationBarBackgroundColor];
    navigationBar.titleLabel.text = [self getNavigationTitle];
    navigationBar.titleLabel.textColor = [self getNavigationTitleColor];
    navigationBar.titleLabel.font = [self getNavigationTitleFont];
    if (self.navigationController && [self.navigationController.viewControllers count] > 1) {//显示back button
        self.pageNavigationBar.leftButton = [self newBackButton];
    } else {
        if ([self getCustomNavigationBarLeftButtonImage]!=nil ||
            [self getCustomNavigationBarLeftButtonTitle].length > 0) {//显示左侧按钮
            self.pageNavigationBar.leftButton = [self newLeftButton];
        }
    }
    
    //右边按钮
    if ([self getCustomNavigationBarRightButtonImage] != nil
        || [self getCustomNavigationBarRightButtonTitle].length > 0) {
       
        self.pageNavigationBar.rightButton = [self newRightButton];
    }
}


- (void) decorateLeftButtonNavigationBar:(UINavigationBar *)navigationBar {
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:[self newBackButton]];
        self.navigationItem.leftBarButtonItem = backItem;
    } else {
        UIButton *btn =  [self newLeftButton];
        if ( [self getCustomNavigationBarLeftButtonTitle] && [self getCustomNavigationBarLeftButtonTitle].length > 0) {
            [btn.titleLabel setFont:[self getCustomNavigationBarLeftButtonFont]];
            [btn setTitleColor:[self getCustomNavigationBarLeftButtonTintColor] forState:UIControlStateNormal];
            [btn setTitleColor:[self getCustomNavigationBarLeftButtonTintColor] forState:UIControlStateHighlighted];
            [btn setTitle:[self getCustomNavigationBarLeftButtonTitle] forState:UIControlStateNormal];
           // [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
            
        }
        if ([self getCustomNavigationBarLeftButtonImage]) {
            UIImage *btnImage = [self getCustomNavigationBarLeftButtonImage];
            [btn setImage:btnImage forState:UIControlStateNormal];
            [btn setImage:btnImage forState:UIControlStateHighlighted];
        }
        if ([self getCustomNavigationBarLeftButtonTitle] && [self getCustomNavigationBarLeftButtonTitle].length > 1 && [self getCustomNavigationBarLeftButtonImage]) {
            NSDictionary *attribute = @{NSFontAttributeName:btn.titleLabel.font};
            CGFloat textWidth = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, btn.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
            CGFloat width = 0.0f;
            UIImage *image = btn.currentImage;
            CGFloat widthInPoints = image.size.width;
            CGFloat   imageWidth = widthInPoints;
            width += imageWidth;
            width += textWidth;
            width += MHNavigationBarButtonImageTextSpace;
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, textWidth + MHNavigationBarButtonImageTextSpace, 0, -textWidth - MHNavigationBarButtonImageTextSpace);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth- MHNavigationBarButtonImageTextSpace, 0, imageWidth + MHNavigationBarButtonImageTextSpace);
            btn.width = width;
        }
        
        if (btn.titleLabel.text.length > 0  || btn.currentImage) {
            UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
    self.navigationController.navigationBar.hidden = NO;
}

- (void) decorateRightButtonNavigationBar:(UINavigationBar *)navigationBar {
        UIButton *btn =  [self newRightButton];
        if ( [self getCustomNavigationBarRightButtonTitle] && [self getCustomNavigationBarRightButtonTitle].length > 0) {
            [btn.titleLabel setFont:[self getCustomNavigationBarRightButtonFont]];
            [btn setTitleColor:[self getCustomNavigationBarRightButtonTintColor] forState:UIControlStateNormal];
            [btn setTitleColor:[self getCustomNavigationBarRightButtonTintColor] forState:UIControlStateHighlighted];
            [btn setTitle:[self getCustomNavigationBarRightButtonTitle] forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
            
        }
        if ([self getCustomNavigationBarRightButtonImage]) {
            UIImage *btnImage = [self getCustomNavigationBarRightButtonImage];
            [btn setImage:btnImage forState:UIControlStateNormal];
            [btn setImage:btnImage forState:UIControlStateHighlighted];
        }
        if ([self getCustomNavigationBarRightButtonTitle] && [self getCustomNavigationBarRightButtonTitle].length > 1 && [self getCustomNavigationBarRightButtonImage]) {
            NSDictionary *attribute = @{NSFontAttributeName:btn.titleLabel.font};
            CGFloat textWidth = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, btn.height) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attribute context:nil].size.width;
            CGFloat width = 0.0f;
            UIImage *image = btn.currentImage;
            CGFloat widthInPoints = image.size.width;
            CGFloat   imageWidth = widthInPoints;
            width += imageWidth;
            width += textWidth;
            width += MHNavigationBarButtonImageTextSpace;
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, textWidth + MHNavigationBarButtonImageTextSpace, 0, -textWidth - MHNavigationBarButtonImageTextSpace);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth- MHNavigationBarButtonImageTextSpace, 0, imageWidth + MHNavigationBarButtonImageTextSpace);
            btn.width = width;
        }
        
        if (([self getCustomNavigationBarRightButtonTitle] && [self getCustomNavigationBarRightButtonTitle].length > 0)|| [self getCustomNavigationBarRightButtonImage]) {
            UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
            self.navigationItem.rightBarButtonItem = leftItem;
        }
}



#pragma mark - lazy loading -------
- (MHNavigationBar *)pageNavigationBar {
    if (_pageNavigationBar == nil) {
        CGFloat height = NAVIGATION_BAR_DEFAULT_HEIGHT+Status_Bar_Height;
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        _pageNavigationBar = [[MHNavigationBar alloc] initWithFrame:frame];
    }
    return _pageNavigationBar;
}

#pragma mark action -------------

- (void) customNavigationBarRightButtonAction:(id)sender {
    
}

- (void) customNavigationBarLeftButtonAction:(id)sender {
    
}

- (void) backButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ui ---------
- (UIButton *) newLeftButton {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 100.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarLeftButtonFont]];
    [btn setTitleColor:[self getCustomNavigationBarLeftButtonTintColor] forState:UIControlStateNormal];
    [btn setTitleColor:[self getCustomNavigationBarLeftButtonTintColor] forState:UIControlStateHighlighted];
    [btn setTitle:[self getCustomNavigationBarLeftButtonTitle] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    UIImage *image = [self getCustomNavigationBarLeftButtonImage];
    if (image != nil) {
        UIImage *btnImage = [image imageWithColor:[self getCustomNavigationBarLeftButtonTintColor]];
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImage:btnImage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(customNavigationBarLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (UIButton *) newBackButton {
    UIImage *btnImage = [[UIImage imageNamed:@"icon_back"] imageWithColor:[self getNavigationBarBackButtonColor]];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 30.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarLeftButtonFont]];
    [btn setTitle:@" " forState:UIControlStateNormal];
    [btn setTitleColor:BACK_BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    btn.tag = MHBackButtonTag;
    [btn setImage:btnImage forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -3.0f, 0.0f, 3.0f)];
    [btn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (UIButton *) newRightButton {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 100.0f, 40.0f);
    
    [btn.titleLabel setFont:[self getCustomNavigationBarRightButtonFont]];
    [btn setTitleColor:[self getCustomNavigationBarRightButtonTintColor] forState:UIControlStateNormal];
    [btn setTitleColor:[self getCustomNavigationBarRightButtonTintColor] forState:UIControlStateHighlighted];
    [btn setTitle:[self getCustomNavigationBarRightButtonTitle] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    UIImage *image = [self getCustomNavigationBarRightButtonImage];
    if (image != nil) {
        
      //  UIImage *btnImage = [image imageWithColor:[self getCustomNavigationBarRightButtonTintColor]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImage:image forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(customNavigationBarRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
