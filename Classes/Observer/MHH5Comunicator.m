//
//  MHH5Comunicator.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/26.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHH5Comunicator.h"
#import "MHUtility.h"
#import "NSString+Category.h"
static MHH5Comunicator* instance = nil;

@implementation MHH5Comunicator

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}



- (NSString *)appendUserInfoWithURL:(NSString *) urlString
                             userid:(NSString *) userId
                              token:(NSString *) token {
    
    if (userId == nil || token == nil) {
        return urlString;
    }
    NSString *resultStr = nil;
    // TODO
    NSString *encodedUserID =   [userId getAESEncrptyWithKey:AES_KEY];
    NSString *encodedToken  =   [token getAESEncrptyWithKey:AES_KEY];
    NSString *encodedUUID   =   [[MHUtility uuid] getAESEncrptyWithKey:AES_KEY];
    if(![urlString containsString:@"?"]) {
        urlString = [urlString stringByAppendingString:@"?"];
    }
    resultStr = [NSString stringWithFormat:@"%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",
                 urlString,
                 kDEF_UUID_KEY,
                 [encodedUUID URLEncodedString],
                 kDEF_IS_NEED_DECODE_KEY,
                 kDEF_IS_NEED_DECODE_VALUE,
                 kDEF_USERID_COOKIE_KEY,
                 [encodedUserID URLEncodedString],
                 kDEF_TOKEN_COOKIE_KEY,
                 [encodedToken URLEncodedString],
                 @"device",
                 [@"iPhone OS" URLEncodedString]
                 ];
    
    return resultStr;
    
}


@end
