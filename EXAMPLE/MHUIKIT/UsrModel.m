//
//  UsrModel.m
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#import "UsrModel.h"

@implementation UsrModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.token            = [dictionary nvObjectForKey:@"token"];
        self.name            = [dictionary nvObjectForKey:@"name"];
        self.IP             = [[dictionary nvObjectForKey:@"IP"] integerValue];
    }return self;
}


@end
