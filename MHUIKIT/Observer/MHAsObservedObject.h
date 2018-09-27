//
//  MHAsObservedObject.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef id (^AppSchemaInvoke) (NSString* name, NSDictionary* parameters, UIViewController* viewController);

@interface MHAsObservedObject : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* serviceName;
@property (nonatomic, copy) AppSchemaInvoke invokeBlock;

@end
