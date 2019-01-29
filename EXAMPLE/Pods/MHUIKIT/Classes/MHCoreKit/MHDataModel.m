//
//  MHDataModel.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHDataModel.h"

@implementation MHDataModel


@synthesize cellHeight = _cellHeight;
@synthesize cellType = _cellType;
@synthesize cellClass = _cellClass;
@synthesize actionClass = _actionClass;
@synthesize delegate = _delegate;
@synthesize cellInstance = _cellInstance;

- (id) initWithDictionary:(NSDictionary *)dictionary {
    if (dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.content = @"";
    }
    return self;
}



@end



@implementation MHListModel

- (id) initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray*) items {
    if (_items == nil) {
        _items = [[NSMutableArray alloc] init];
    }
    
    return _items;
}

- (NSArray*) arrayValue {
    return [NSArray array];
}

@end

