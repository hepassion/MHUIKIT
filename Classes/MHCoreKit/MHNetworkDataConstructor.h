//
//  MHNetworkDataConstructor.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTableViewDataConstructor.h"
#import "MHPrefixHeader.pch"

@protocol MHNetworkDataConstructorDelegate;

@interface MHNetworkDataConstructor : MHTableViewDataConstructor

@property (nonatomic, weak) id<MHNetworkDataConstructorDelegate> delegate;
@property (nonatomic, strong) MHListModel *list;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) BOOL hasNext;

/**
 子类复写
 */
- (void) loadData;
- (void) loadMore;
- (BOOL) isDelegateValid;


/**
 提供给子类安全调用MHNetworkDataConstructorDelegate,不用Override
 */
- (void) MH_responseSuccess:(id) data;
- (void) MH_responseError:(id) error;

@end

@protocol MHNetworkDataConstructorDelegate <NSObject>

@optional
- (void) networkDataContructorStartLoading:(MHNetworkDataConstructor*)dataConstructor;
- (void) networkDataContructor:(MHNetworkDataConstructor*)dataConstructor didFinishWithData:(id)data;
- (void) networkDataContructor:(MHNetworkDataConstructor*)dataConstructor didErrorWithData:(id)data;
@end
