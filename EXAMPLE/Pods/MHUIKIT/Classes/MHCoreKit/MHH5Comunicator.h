//
//  MHH5Comunicator.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/26.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptEncodeHelper.h"

#define AES_KEY                            @"nQAi2alQIVqLtXeI"            //AES加解密Key
#define kDEF_USERID_COOKIE_KEY                  @"_m8k42bcDprEZceEU"           //用户ID的Cookie解密
#define kDEF_TOKEN_COOKIE_KEY                   @"_tZBWFNXKoZzFfVgq"           //用户Token的Cookie解密
#define kDEF_DEVICEID_KEY                       @"DQWRK4LVUGEXGZK1"
#define kDEF_UUID_KEY                           @"WOT5meBIr5CAile0"            //UUID KEY
#define kDEF_IS_NEED_DECODE_KEY                 @"rV7DVufssizJ8Slk"            //服务器用于判断webview的get请求是否需要解密用户ID和TOKEN
#define kDEF_IS_NEED_DECODE_VALUE               @"tqCeih5YpdJnNc33"

@interface MHH5Comunicator : NSObject

+ (instancetype)sharedInstance;



/**
 将URL字符串拼接用户信息
 
 @param urlString 需要拼接的目标URL
 @param userId    用户ID
 @param token     用户Token
 
 @return 拼接后的URL
 */
- (NSString *)appendUserInfoWithURL:(NSString *) urlString
                             userid:(NSString *) userId
                              token:(NSString *) token;



+ (void)CleanCookies;
+ (NSArray *)GetCookies;


@end
