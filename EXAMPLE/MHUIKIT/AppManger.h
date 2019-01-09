//
//  AppManger.h
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsrModel.h"


@interface AppManger : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, strong) UsrModel *userModel;
@property (nonatomic, strong) NSString *ipAdress;
- (void)deviceWANIPAddress:(void (^)(NSString *WANIP))WANIPAddress;
@end


