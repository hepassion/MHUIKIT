//
//  MHUtility.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/26.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHUtility : NSObject

+ (NSString*) appUrlScheme;
+ (NSString*) appBundleId;
+ (NSString*) appVersion;
+ (NSString*) osVersion;
+ (NSString*) appBuildID;
+ (NSString*) deviceInfo;
+ (NSString*) uuid;
@end
