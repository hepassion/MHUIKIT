//
//  UsrModel+Category.m
//  MHUIKIT
//
//  Created by minghe on 2019/7/25.
//  Copyright © 2019 minghe. All rights reserved.
//

#import "UsrModel+Category.h"
#import <objc/runtime.h>
static const char *key = "cateKEY";
@implementation UsrModel (Category)


- (NSString *)categoryTest {
    return objc_getAssociatedObject(self, key);
}


//- (void)setBaseURL:(NSString *)baseURL
- (void)setCategoryTest:(NSString *)categoryTest {
    objc_setAssociatedObject(self, key, categoryTest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}





@end
