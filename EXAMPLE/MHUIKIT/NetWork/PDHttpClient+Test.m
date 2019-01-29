//
//  PDHttpClient+Test.m
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "PDHttpClient+Test.h"

@implementation PDHttpClient (Test)

//
//
//[self request:path
//       mothed:@"POST"
//      version:@"5.0"
//   parameters:nil
//      success:^(id responseObject) {
//          NSArray* array = [responseObject valueForKey:kResponseData];
//          NSString *userId = [[responseObject valueForKey:@"userId"] stringValue];//当为0的时候，就是未登录的状态
//          if (success) {
//              HYHomeProductDistrictListModel * dataModel = [[HYHomeProductDistrictListModel alloc] initWithArray:array];
//              dataModel.content = userId; //暂存用户id，用于首页判断是否登陆
//              success(dataModel);
//          }
//      }
//      failure:^(NVErrorDataModel *dataModel) {
//          if (failure) {
//              failure(dataModel);
//          }
//      }];



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
    [par nvSetObject:@(20) forKey:@"code"];

    
    
    
    [self request:path method:POST parameters:par success:^(id responseObject) {
        NSDictionary* dictionary = [responseObject valueForKeyPath:kResponseData];
        UsrModel *model = [[UsrModel alloc] initWithDictionary:dictionary];
        success(model);
    } failure:^(MHErrorModel *dataModel) {
        failure(dataModel);

    }];
}


@end
