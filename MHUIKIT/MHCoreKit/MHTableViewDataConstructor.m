//
//  MHTableViewDataConstructor.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "MHTableViewDataConstructor.h"
#import "MHTableViewCell.h"
#import <objc/runtime.h>


@implementation MHTableViewDataConstructor

- (id) init {
    self = [super init];
    if (self) {
        _indexOfHighlight = -1;
    }
    
    return self;
}

- (void) constructData {
    
}

- (void) updateHighlightCell:(CGPoint)offset {
    
}

- (MHDataModel*) itemByCellType:(NSString *)cellType {
    if ([cellType length] == 0) {
        return nil;
    }
    
    for (NSArray* array in self.items.arrayIndexPath) {
        for (MHDataModel* item in array) {
            if ([item.cellType isEqualToString:cellType]) {
                return item;
            }
        }
    }
    
    return nil;
}

- (MHDataModel *)modelByCellType:(NSString *)cellType {
    return [self itemByCellType:cellType];
}

- (MHTableViewCell *) cellByCellType:(NSString*)cellType {
    MHDataModel *model = [self itemByCellType:cellType];
    if (!model) {
        return nil;
    }
    return (MHTableViewCell *)model.cellInstance;
}

- (void) indexPathByCellType:(NSString *)cellType block:(void (^)(NSIndexPath *))block {
    if ([cellType length] == 0) {
        return;
    }
    
    __block BOOL found = NO;
    [self.items.arrayIndexPath enumerateObjectsUsingBlock:^(id obj, NSUInteger section, BOOL *stop) {
        NSArray* array = (NSArray*)obj;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger row, BOOL *stop) {
            MHDataModel* item = (MHDataModel*)obj;
            if ([item.cellType isEqualToString:cellType]) {
                
                if (block) {
                    block([NSIndexPath indexPathForRow:row inSection:section]);
                }
                found = YES;
            }
            *stop = found;
        }];
        *stop = found;
    }];
}


- (void) refreshValueForCellType:(NSString *)cellType {
    MHDataModel* item = [self itemByCellType:cellType];
    if (item == nil) {
        return;
    }
    
    MHTableViewCell* cellInstance = (MHTableViewCell*)item.cellInstance;
    [cellInstance setItem:item];
}

- (void) refreshValueForCellType:(NSString *)cellType block:(void (^)(MHDataModel *))block {
    MHDataModel* item = [self itemByCellType:cellType];
    if (item == nil) {
        return;
    }
    
    if (block) {
        block(item);
        
        MHTableViewCell* cellInstance = (MHTableViewCell*)item.cellInstance;
        [cellInstance setItem:item];
    }
}


#pragma mark - setter/getter
- (MHIndexPathArray *) items {
    if (_items == nil) {
        _items = [[MHIndexPathArray alloc] init];
    }
    return _items;
}



@end



static char kAdapterArrayKeysObjectKey;


@implementation MHTableViewDataConstructor (Index)
@dynamic arrayKeys;


- (NSArray*) arrayKeys {
    return (NSArray *)objc_getAssociatedObject(self, &kAdapterArrayKeysObjectKey);
}

- (void) setArrayKeys:(NSArray *)arrayKeys {
    objc_setAssociatedObject(self, &kAdapterArrayKeysObjectKey, arrayKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void) constructIndex {
    
}

@end



