//
//  UIColor+Category.m
//  MHUIKIT
//
//  Created by minghe on 2019/7/2.
//  Copyright © 2019 minghe. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)
//hexColorStr    =   'ffffff' l
+ (UIColor*)hexColorFromStr:(NSString*)hexColorStr {
    
    unsigned int red, green, blue, alpha;
    NSRange range;
    range.length = 2;
    @try {
        if ([hexColorStr hasPrefix:@"#"]) {
            hexColorStr = [hexColorStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
        }
        range.location = 0;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&blue];
        
        if ([hexColorStr length] > 6) {
            range.location = 6;
            [[NSScanner scannerWithString:[hexColorStr substringWithRange:range]] scanHexInt:&alpha];
        }
    }
    @catch (NSException * e) {
        
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(float)(1.0f)];
}

@end
