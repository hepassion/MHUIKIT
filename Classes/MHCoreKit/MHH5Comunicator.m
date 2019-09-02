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
#import <WebKit/WKWebsiteDataStore.h>

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
+ (void)CleanCookies {
    //清理webview cookie
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                        WKWebsiteDataTypeDiskCache,
                                                        WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        WKWebsiteDataTypeLocalStorage,
                                                        WKWebsiteDataTypeCookies,
                                                        WKWebsiteDataTypeSessionStorage,
                                                        WKWebsiteDataTypeIndexedDBDatabases,
                                                        WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
    }
    
    //移除共享cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    //删除cookie文件 iOS8+
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
}
+ (NSArray *)GetCookies {
    //获取webview的cookie
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:@[WKWebsiteDataTypeCookies] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull arr) {
        }];
    }
    
    //获取共享cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    return storage.cookies;
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
