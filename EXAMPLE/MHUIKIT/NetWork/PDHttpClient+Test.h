//
//  PDHttpClient+Test.h
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "PDHttpClient.h"



@interface PDHttpClient (Test)



/*
 获取未登录的首页头部数据
 */
- (void)getHomeUnLoginHeaderDataSuccess:(void (^)(UsrModel* dataModel))success
                                failure:(void (^)(MHErrorModel* dataModel))failure;





@end


