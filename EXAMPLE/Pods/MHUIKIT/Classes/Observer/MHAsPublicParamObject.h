//
//  MHAsPublicParamObject.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTaskObjectProtocol.h"
#import <UIKit/UIKit.h>
#import "NSDictionary+Category.h"

typedef void(^PublicParamInvoke) (NSString* name, NSString* value, UIViewController* viewController, void(^callback)(BOOL completed));
@interface MHAsPublicParamObject : NSObject<MHTaskObjectProtocol>

@property (nonatomic, strong) NSString* name;
@property (nonatomic, copy) PublicParamInvoke invokeBlock;

@end
