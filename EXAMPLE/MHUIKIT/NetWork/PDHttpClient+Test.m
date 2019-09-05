//
//  PDHttpClient+Test.m
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "PDHttpClient+Test.h"


@implementation PDHttpClient (Test)

- (void)getTestDataSuccess:(void (^)(UsrModel* dataModel))success
                                failure:(void (^)(MHErrorModel* dataModel))failure {
    NSString* path = @"login";
        [self request:path method:GET parameters:nil success:^(id responseObject) {
            NSDictionary* dictionary = [responseObject valueForKeyPath:kResponseData];
            UsrModel *model = [[UsrModel alloc] initWithDictionary:dictionary];
            success(model);
        } failure:^(MHErrorModel *dataModel) {
            failure(dataModel);
        }];
    
}


- (void)postTestDataSuccess:(void (^)(UsrModel* dataModel))success
                    failure:(void (^)(MHErrorModel* dataModel))failure {
    NSString* path = @"postTest";
    NSMutableDictionary *par = [NSMutableDictionary new];
    [par nvSetObject:@"minghe" forKey:@"name"];
    [par nvSetObject:@(200) forKey:@"code"];

    [self request:path method:POST parameters:par success:^(id responseObject) {
        NSDictionary* dictionary = [responseObject valueForKeyPath:kResponseData];
        UsrModel *model = [[UsrModel alloc] initWithDictionary:dictionary];
        success(model);
    } failure:^(MHErrorModel *dataModel) {
        failure(dataModel);

    }];
}

- (BOOL)isTokenExpire {
    
  NSString *token =   [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token isEqualToString:@"1"]) {
        return YES;
    }
        return NO;
}



@end
