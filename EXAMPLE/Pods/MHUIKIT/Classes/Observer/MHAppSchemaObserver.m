//
//  MHAppSchemaObserver.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHAppSchemaObserver.h"
#import "NSDictionary+Category.h"
#import "NSString+Category.h"
#import "UIApplication+Helper.h"
#import "NSString+Category.h"
@interface MHAppSchemaObserver ()

@property (nonatomic, strong) NSMutableDictionary* dictObserver;
@property (nonatomic, strong) NSMutableDictionary* dictPublicParams;

@end
@implementation MHAppSchemaObserver

static MHAppSchemaObserver* instance = nil;

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    
    return instance ;
}


- (id) init {
    self = [super init];
    if (self) {
        
        self.dictObserver           = [NSMutableDictionary dictionary];
        self.dictPublicParams       = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void) setAppSchema:(NSString *)appSchema {
    _appSchema = appSchema;
}

- (BOOL) hasAppSchema:(NSString *)urlSchema {
    return [_appSchema isEqualToString:urlSchema];
}



- (void) addPublicParamName:(NSString *)paramName
                     invoke:(void (^)(NSString *, NSString *, UIViewController *, void(^callback)(BOOL completed)))block {
    
    MHAsPublicParamObject* object   = [[MHAsPublicParamObject alloc] init];
    object.name                     = paramName;
    object.invokeBlock              = block;
    
    [self.dictPublicParams setObject:object forKey:paramName];
}



- (void) addObserverName:(NSString *)name
             serviceName:(NSString *)serviceName
                  invoke:(id (^)(NSString *, NSDictionary *, UIViewController *))block {
    
    MHAsObservedObject* object      = [[MHAsObservedObject alloc] init];
    object.name                     = name;
    object.serviceName              = serviceName;
    object.invokeBlock              = block;
    
    [self.dictObserver setObject:object forKey:serviceName];
}



- (void) addObserverName:(NSString *)name
                 webName:(NSString *)webName
                  invoke:(void (^)(NSString *, NSDictionary *, UIViewController *))block {
    
}

- (MHAsObservedObject*) observedObjectForServiceName:(NSString *)serviceName {
    return [self.dictObserver nvObjectForKey:serviceName];
}

- (MHAsPublicParamObject*) publicParamObjectForParamName:(NSString *)paramName {
    return [self.dictPublicParams nvObjectForKey:paramName];
}

- (NSArray*) hasPublicParamExisted:(NSArray *)paramNames {
    if ([paramNames count] > 0) {
        
        NSMutableArray* result  = [NSMutableArray array];
        
        [paramNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary* keyValue  = (NSDictionary*)obj;
            NSString* paramName     = [[keyValue allKeys] objectAtIndex:0];
            //            NSString* paramName     = (NSString*)obj;
            
            [self.dictPublicParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString* name                  = (NSString*)key;
                MHAsPublicParamObject* object   = (MHAsPublicParamObject*)obj;
                
                if ([paramName isEqualToString:name]) {
                    [result addObject:object];
                    *stop = YES;
                }
            }];
        }];
        
        return result;
    }
    
    return nil;
}

- (BOOL) handleOpenURL:(NSURL *)url {
    return [self handleOpenURL:url controller:nil];
}

/**
 *  TaskFlow 是否注册有对应的任务
 *
 *  @param url URL Scheme
 *
 *  @return NO 被TaskFlow截获，不用再做任务处理。 YES TaskFlow没有注册对应的任务。
 */
- (BOOL) handleOpenURL:(NSURL *)url controller:(id) controller {
    NSString* scheme        = url.scheme;
    //    NSString* host          = url.host;
    NSString* service       = url.path;
    NSString* paramStr      = [url.query URLDecodedChineseString];
    
    
    if ([self hasAppSchema:scheme]) {
        NSLog(@"OPEN-URL: %@",url.absoluteString);
        
        MHAsObservedObject* observedObject = [self observedObjectForServiceName:service];
        
        if ([observedObject isKindOfClass:[MHAsObservedObject class]]) {
            
            if (observedObject.invokeBlock) {
                NSDictionary* parameters = nil;
                if ([service isEqualToString:@"/webImages"]) {
                    parameters        = [paramStr jsonPatameters];
                }else {
                    if (paramStr.length > 0) {
                        parameters        = [paramStr parameters];
                    }
                    
                }
                
                NSArray* parametersSorted       = [paramStr parametersSorted];
                NSArray* publicParams            = [self hasPublicParamExisted:parametersSorted];
                
                UIViewController* currentController ;
                
                if (controller) {
                    currentController = controller;
                } else {
                    currentController = [UIApplication dd_currentViewController];
                }
                
                NSString* const kTaskNamePublicParams       = @"task.name.public.params";
                [[MHTaskManager sharedInstance] removeAllTaskWithName:kTaskNamePublicParams];
                // 是否需要 登陆/认证等，有的话 需要建立对应的任务。
                if ([publicParams count] > 0) {
                    
                    for (MHAsPublicParamObject* paramObject in publicParams) {
                        MHTask* task            = [[MHTask alloc] init];
                        task.object             = paramObject;

                        NSString* value         = [parameters nvObjectForKey:paramObject.name];
                        task.userInfo           = @{@"value": value,
                                                    @"viewController": currentController};

                        [[MHTaskManager sharedInstance] addTask:task
                                                           name:kTaskNamePublicParams];
                    }


                    [[MHTaskManager sharedInstance] start:kTaskNamePublicParams finish:^(BOOL completed) {
                        observedObject.invokeBlock(observedObject.name, parameters, currentController);
                    }];
                    
                    
                } else {
                    observedObject.invokeBlock(observedObject.name, parameters, currentController);
                }
                
                
            }
            
            return NO;
        }
    }
    
    return YES;
}

- (void) openURLString:(NSString *)urlString {
    UIViewController *currentVC = [UIApplication dd_currentViewController];
    [self openURLString:urlString controller:currentVC];
}


- (void) openURLString:(NSString *)urlString controller:(id) controller{
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        urlString = [urlString URLEncodedChineseString];
        url = [NSURL URLWithString:urlString];
    }
    BOOL result = [[MHAppSchemaObserver sharedInstance] handleOpenURL:url controller:controller];
    
    if (result) {
        NSString* scheme    = url.scheme;
        if ([scheme isEqualToString:@"http"] ||
            [scheme isEqualToString:@"https"]) {
            
            NSString* urlWebStr   = [NSString stringWithFormat:@"%@://Service/web?url=%@", self.appSchema, url.absoluteString];
            [self openURLString:urlWebStr controller:controller];
        }
    }
}

- (id) syncOpenURL:(NSURL*)url {
    NSString* scheme        = url.scheme;
    //NSString* host          = url.host;
    NSString* service       = url.path;
    NSString* paramStr      = [url.query URLDecodedChineseString];
    
    
    if ([self hasAppSchema:scheme]) {
        NSLog(@"OPEN-URL: %@",url.absoluteString);
        
        MHAsObservedObject* observedObject = [self observedObjectForServiceName:service];
        
        if ([observedObject isKindOfClass:[MHAsObservedObject class]]) {
            
            if (observedObject.invokeBlock) {
                NSDictionary* parameters = nil;
                if (paramStr.length > 0) {
                    parameters        = [paramStr parameters];
                }
                //NSArray* parametersSorted       = [paramStr parametersSorted];
                //                NSArray* arrayNames             = [parameters allKeys];
                //NSArray* publicParams            = [self hasPublicParamExisted:parametersSorted];
                
                UIViewController* curretnController = [UIApplication dd_currentViewController];
                return observedObject.invokeBlock(observedObject.name, parameters, curretnController);
            }
        }
    }
    return  nil;
}


@end
