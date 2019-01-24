//
//  PDHttpClient.m
//  MHUIKIT
//
//  Created by minghe on 2018/12/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "PDHttpClient.h"
static PDHttpClient* instance = nil;

@implementation PDHttpClient
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:DO_MAIN] ;
    }) ;
    
    return instance ;
}

- (id) initWithBaseURL:(NSString *)url {
    self = [super init];
    self.baseURL = url;
    if (self) {
        [XMCenter setupConfig:^(XMConfig * _Nonnull config) {
            NSMutableDictionary *headers = [NSMutableDictionary new];
            
            [headers setObject:[MHUtility uuid]  forKey:@"phoneId"];
            [headers setObject:@"ios"           forKey:@"type"];

            // app build版本
            NSString *app_build = [MHUtility appBuildID];
            NSString *version = [MHUtility appVersion];
            NSString *appVersion = [NSString stringWithFormat:@"2,V%@,%@",version,app_build];
            [headers setObject:appVersion forKey:@"appVersion"];
            if ([AppManger sharedInstance].ipAdress && [AppManger sharedInstance].ipAdress.length) {
                [headers setObject:[AppManger sharedInstance].ipAdress forKey:@"clientIp"];
            }
            config.generalServer = url ;
            config.generalHeaders = headers;
            config.callbackQueue = dispatch_get_main_queue();
            
#ifdef DEBUG
          //  config.consoleLog = YES;
#endif
     
        
        
        }];
    }
    return self;
}



- (void)request:(NSString *)path
         method:(NSString*)method
     parameters:(id)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(MHErrorModel* dataModel))failure {

    [self processRequestPath:path  method:method parameters:parameters  uploadDatas:nil success:success failure:failure];
    
}


- (void)uploadFileWithPath:(NSString *)path parameters:(NSDictionary *)parameters uploadDatas:(NSMutableArray *)uploadDatas
                   success:(void (^)(id))success         failure:(void (^)(MHErrorModel *))failure {
    [self processRequestPath:path   method:UPLOAD  parameters:parameters uploadDatas:uploadDatas success:success failure:failure];

}



- (void) processRequestPath:(NSString *)url
                 method:(NSString *)method
             parameters:(NSDictionary *)parameters
                 uploadDatas:(NSMutableArray *)uploadDatas
                success:(void (^)(id))success
                failure:(void (^)(MHErrorModel *))failure {
    
    WEAK_SELF;
    NSString* mothedUpper = [method uppercaseString];
    if ([mothedUpper isEqualToString:GET]) {
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.api         = url;
            request.parameters  = parameters;
            request.retryCount  = 1;            // api请求出错，可以重试一次。杜绝kCFErrorDomainCFNetwork error -1005
            request.httpMethod  = kXMHTTPMethodGET; // optional, `POST` by default.
            request.requestType = kXMRequestNormal; // optional, `Normal` by default.
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id  _Nullable responseObject) {
            [weakself translatorResponseObject:responseObject success:success failure:failure];
        } onFailure:^(NSError * _Nullable error) {
            [weakself onFailedWithError:error failure:failure];
        }];
        
    } else if ([mothedUpper isEqualToString:POST]) {
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.api         = url;
            request.parameters  = parameters;
            request.retryCount  = 1;
            request.httpMethod  = kXMHTTPMethodPOST;
            request.requestType = kXMRequestNormal;
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id  _Nullable responseObject) {
            [weakself translatorResponseObject:responseObject success:success failure:failure];
        } onFailure:^(NSError * _Nullable error) {
            [weakself onFailedWithError:error failure:failure];
        }];

    } else if ([mothedUpper isEqualToString:UPLOAD]) {
        NSMutableArray *formDatas = [NSMutableArray new];
        [uploadDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIImage class]]) {
                NSData *imageData = UIImageJPEGRepresentation(obj,1.0f);//第二个参数为压缩倍数
                NSString *name = [NSString stringWithFormat:@"uploadFile%ld", idx];
                NSString *fileName = [NSString stringWithFormat:@"image-ios%ld.jpg", idx];
                XMUploadFormData *data = [XMUploadFormData formDataWithName:name
                                                                   fileName:fileName
                                                                   mimeType:@"image/jpeg"
                                                                   fileData:imageData];
                [formDatas addObject:data];
            } else {
                NSString *name = [NSString stringWithFormat:@"file%ld", idx];
                NSString *fileName = [NSString stringWithFormat:@"filename%ld", idx];
                XMUploadFormData *data = [XMUploadFormData formDataWithName:name
                                                                   fileName:fileName
                                                                   mimeType:@"*/*"
                                                                   fileData:obj];
                [formDatas addObject:data];
            }
        }];
        
        
        [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
            request.api         = url;
            request.parameters  = parameters;
            request.httpMethod = kXMHTTPMethodPOST;
            request.uploadFormDatas = formDatas;
            request.requestType = kXMRequestUpload;
            request.requestSerializerType = kXMRequestSerializerRAW;
            request.responseSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id  _Nullable responseObject) {
            [weakself translatorResponseObject:responseObject success:success failure:failure];
        } onFailure:^(NSError * _Nullable error) {
            [weakself onFailedWithError:error failure:failure];
        }];
    }
}



//处理成功数据
- (void) translatorResponseObject:(id)responseObject
                          success:(void (^)(id))success
                          failure:(void (^)(MHErrorModel *))failure {
    
    NSDictionary* jsonObject = responseObject;
    NSString* codeString = [jsonObject valueForKeyPath:kResponseCode];
  NSInteger  code = [codeString integerValue];
    
    
    if (code == 200) {
        
        if (success) {
            success(jsonObject);
        }
        
    } else {
        NSString* errorType = nil;
        if (code == 401 ) {
            errorType = kResponseErrorTypeFail;
       }
  //          else if ([code isEqualToString:@"LOGIN"]) {
//            errorType = kResponseErrorTypeNeedLogin;
//        } else if ([code isEqualToString:@"INVALID"]) {
//            errorType = kResponseErrorTypeInvalid;
//        } else if ([code isEqualToString:@"EXCEPTION"]) {
//            errorType = kResponseErrorTypeException;
//        } else if ([code isEqualToString:@"ERROR"]) {
//            errorType = kResponseErrorTypeError;
//        } else if ([code isEqualToString:@"DATA_PURVIEW_ERROR"]) {
//            errorType = kResponseErrorTypeDataPurview;
//        } else if ([code isEqualToString:@"UPGRADE"]) {
//            errorType = kResponseErrorTypeUpgrade;
//        } else if ([code isEqualToString:@"UPGRADE_FORCE"]) {
//            errorType = kResponseErrorTypeUpgradeForce;
//        } else if ([code isEqualToString:@"REDIRECTION"]) {
//            errorType = kResponseErrorTypeRedirection;
//        }
        
        NSString* error         = [jsonObject nvObjectForKey:kResponseError];
        NSString* msg           = [jsonObject nvObjectForKey:kResponseMsg];
        NSString* redirectUrl   = [jsonObject nvObjectForKey:kResponseRedirectUrl];
        
        MHErrorModel* dataModel = [[MHErrorModel alloc] init];
        dataModel.errorType         = errorType;
        dataModel.code              = code;
        dataModel.message           = msg;
        dataModel.error             = error;
        dataModel.redirectUrl       = redirectUrl;
        failure(dataModel);
    }
}

//处理失败数据
- (void) onFailedWithError:(NSError *)error
                   failure:(void (^)(MHErrorModel *))failure{
    if (failure) {
        MHErrorModel* errorModel = [[MHErrorModel alloc] init];
        errorModel.code = error.code;
        errorModel.message = @"网络异常";
        errorModel.error = [error localizedDescription];
        errorModel.errorType = kResponseErrorTypeFail;
        failure(errorModel);
    }
}


@end
