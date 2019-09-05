//
//  AppManger.m
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "AppManger.h"
static AppManger* instance = nil;

@implementation AppManger
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
        
        instance.sun = ^int(NSString *kkk) {
            
            return 12;
        };
    }) ;
    return instance ;
}


- (void)deviceWANIPAddress:(void (^)(NSString *WANIP))WANIPAddress {
    WEAK_SELF;
    dispatch_async( dispatch_queue_create("LoadWANIPAddress", DISPATCH_QUEUE_CONCURRENT), ^{
        NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
        NSData *data = [NSData dataWithContentsOfURL:ipURL];
        if (data){
            NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]; 
            NSString *ipStr = nil;
            if (ipDic && [ipDic[@"code"] integerValue] == 0) { //获取成功
                ipStr = ipDic[@"data"][@"ip"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    WANIPAddress(ipStr);
                    weakself.ipAdress = ipStr;
                });
            }
        }
    });
}



@end
