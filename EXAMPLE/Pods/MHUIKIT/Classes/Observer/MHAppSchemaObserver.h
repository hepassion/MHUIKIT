//
//  MHAppSchemaObserver.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHAsObservedObject.h"
#import "MHAsPublicParamObject.h"
#import "MHTaskManager.h"

@interface MHAppSchemaObserver : NSObject
+ (instancetype)sharedInstance;


@property (nonatomic, strong, readonly) NSString* appSchema;

- (void) setAppSchema:(NSString*)appSchema;
- (BOOL) hasAppSchema:(NSString*)urlSchema;

- (void) addPublicParamName:(NSString*)paramName
                     invoke:(void(^)(NSString* paramName, NSString* paramValue, UIViewController* viewController, void(^callback)(BOOL completed)))block;

- (void) addObserverName:(NSString*)name
             serviceName:(NSString*)serviceName
                  invoke:(id (^)(NSString* name, NSDictionary* parameters, UIViewController* viewController))block;


- (MHAsObservedObject *)observedObjectForServiceName:(NSString*)serviceName;
- (MHAsPublicParamObject *)publicParamObjectForParamName:(NSString*)paramName;
- (NSArray*) hasPublicParamExisted:(NSArray*)paramNames;


/**
 判断是否能打开一个服务
 1. 在appdellegate调用
 2. private method
 @param url 服务的URL
 */
- (BOOL) handleOpenURL:(NSURL*)url;
- (BOOL) handleOpenURL:(NSURL *)url controller:(id) controller;

/**
  打开一个服务
 
 @param urlString 服务的URL
 */
- (void) openURLString:(NSString *)urlString;
- (void) openURLString:(NSString *)urlString controller:(id) controller;

/**
 同步方式 打开一个服务 返回结果
 
 @param url 服务URL
 */
- (id) syncOpenURL:(NSURL*)url;


//- (NSURL*) generateAppUrlWithSchemaName:(NSString*)schemaName;



@end
