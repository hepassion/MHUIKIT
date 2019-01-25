//
//  MHNetworkDataConstructor.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "MHNetworkDataConstructor.h"

@interface MHNetworkDataConstructor ()
@property (nonatomic, strong) Class delegateClass;
@end

Class object_getClass(id object);

@implementation MHNetworkDataConstructor

- (void) dealloc {
    _delegate = nil;
    self.delegateClass = nil;
    
    
}

- (void) setDelegate:(id<MHNetworkDataConstructorDelegate>)delegate {
    _delegate = delegate;
    if (_delegate) {
        self.delegateClass = object_getClass(_delegate);
    } else {
        self.delegateClass = nil;
    }
}

- (BOOL) isDelegateValid {
    return (_delegate && object_getClass(_delegate) == _delegateClass);
}


- (void) loadData {
    
}

- (void) loadMore {
    
}

- (void) MH_startLoading {
    if (self.delegate && [self.delegate respondsToSelector:@selector(networkDataContructorStartLoading:)]) {
        [self.delegate networkDataContructorStartLoading:self];
    }
}

- (void)MH_responseError:(id)error {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(networkDataContructor:didErrorWithData:)]) {
        [self.delegate networkDataContructor:self didErrorWithData:error];
    }
}

- (void)MH_responseSuccess:(id)data {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(networkDataContructor:didFinishWithData:)]) {
        [self.delegate networkDataContructor:self didFinishWithData:data];
    }
}

@end


