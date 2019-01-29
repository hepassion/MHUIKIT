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
 get
 */
- (void)getTestDataSuccess:(void (^)(UsrModel* dataModel))success
                                failure:(void (^)(MHErrorModel* dataModel))failure;




/*
 post
 */
- (void)postTestDataSuccess:(void (^)(UsrModel* dataModel))success
                                failure:(void (^)(MHErrorModel* dataModel))failure;





@end


