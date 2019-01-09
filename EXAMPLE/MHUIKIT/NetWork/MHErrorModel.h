//
//  MHErrorModel.h
//  MHUIKIT
//
//  Created by minghe on 2018/12/21.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHDataModel.h"



#define kResponseErrorTypeNeedLogin     @"ERROR.NEED.LOGIN"
#define kResponseErrorTypeFail           @"ERROR.FAIL"
#define kResponseErrorTypeInvalid        @"ERROR.INVALID"
#define kResponseErrorTypeException      @"ERROR.EXCEPTION"
#define kResponseErrorTypeError          @"ERROR.ERROR"
#define kResponseErrorTypeDataPurview    @"ERROR.DATA.PURVIEW"
#define kResponseErrorTypeUpgrade        @"ERROR.UPGRADE"
#define kResponseErrorTypeUpgradeForce   @"ERROR.UDGRADE.FORCE"
#define kResponseErrorTypeRedirection    @"ERROR.REDIRECTION"


@interface MHErrorModel : MHDataModel
@property (nonatomic, assign) NSInteger code;           //状态码
@property (nonatomic, strong) NSString* error;          //错误消息
@property (nonatomic, strong) NSString* message;        //成功消息
@property (nonatomic, strong) NSString* errorType;      //错误类型
@property (nonatomic, strong) NSString* redirectUrl;    //维护期间，重定向URL
@end


//87250708
