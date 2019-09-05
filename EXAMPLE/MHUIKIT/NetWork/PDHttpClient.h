//
//  PDHttpClient.h
//  MHUIKIT
//
//  Created by minghe on 2018/12/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMNetworking/XMNetworking.h>
#import "MHErrorModel.h"

#define kResponseCode            @"code"
#define kResponseMsg             @"message"
#define kResponseError           @"error"
#define kResponseData            @"data"
#define kResponseRedirectUrl     @"redirectUrl"

#define         GET               @"GET"
#define         POST              @"POST"
#define         UPLOAD            @"UPLOAD"

typedef void(^Block)();



@interface PDHttpClient : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, copy) Block block;
@property (nonatomic, assign) BOOL isRefreshToken;

@property (nonatomic, strong) NSString *baseURL;

- (void)request:(NSString *)path
         method:(NSString*)method
     parameters:(id)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(MHErrorModel* dataModel))failure;


- (void)uploadFileWithPath:(NSString *)path parameters:(NSDictionary *)parameters
               uploadDatas:(NSMutableArray *)uploadDatas
                        success:(void (^)(id))success
                   failure:(void (^)(MHErrorModel *))failure;



@end

