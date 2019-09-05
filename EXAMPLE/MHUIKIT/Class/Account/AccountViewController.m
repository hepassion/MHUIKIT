
//
//  AccountViewController.m
//  HYHText
//
//  Created by 赵明鹤 on 2017/12/8.
//  Copyright © 2017年 赵明鹤. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountDataConstructor.h"
#import <XMTXCustomKeyBoard/XMTextField.h>
@interface AccountViewController ()<NSCacheDelegate>

@property (nonatomic, strong) AccountDataConstructor *dataConstructor;

@end

@implementation AccountViewController
//@synthesize completion;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.config.navigationTitle = @"账户";
    
    
    XMTextField *field = [[XMTextField alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    field.placeholder = @"输入密码";
    field.xmKeyBoardType = XMkeyBoardType_charAndNumber;
    field.delegate = self;
    field.inputTextBlock = ^(id userInfo) {
        XMTextField *field2 = (XMTextField *)userInfo;
        if (field2.text.length > 3) {
            field2.text = [field2.text substringWithRange:NSMakeRange(0, 2)];
        }
        NSLog(@"inputTextBlock: %@", field2.text);

    };
    [self.view addSubview:field];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing: %@", textField.text);
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"textFieldDidEndEditing22: %@", textField.text);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)constructData {
    if (_dataConstructor == nil) {
        _dataConstructor = [[AccountDataConstructor alloc] init];
        _dataConstructor.viewControllerDelegate = self;
        _dataConstructor.delegate  = self;
    }
    // 初始化完毕 发送网络请求
   
}



#pragma mark NVTableViewAdaptor Delegate

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellType = object.cellType;
    if ([cellType isEqualToString:@"cell.type.collectionView"]) {
    
        
    } else   if ([cellType isEqualToString:@"cell.type.search"]) {

    } else  if ([cellType isEqualToString:@"cell.type.comp"]) {
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
