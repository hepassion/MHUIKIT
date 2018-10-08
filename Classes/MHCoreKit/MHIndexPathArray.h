//
//  MHIndexPathArray.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MHUiKity.h"
//#import <Foundation/NSObject.h>
//#import <Foundation/NSRange.h>

@interface MHIndexPathArray : NSObject

@property (nonatomic, strong, readonly) NSMutableArray* arrayIndexPath;

- (void) addObject:(id)object;
- (void) addObjects:(NSArray*)array;//在最后一个分区的最后加cell
- (void) addObjectsAtNewSection:(NSArray *)array;
- (void) addObjects:(NSArray *)array inSection:(NSInteger)section;

- (void) removeAllObjects;
- (void) removeObjectAtIndex:(NSUInteger)index inSection:(NSInteger)section;;

- (NSUInteger) sectionCount;
- (NSUInteger) countAtSection:(NSInteger)section;

- (id) objectAtIndexPath:(NSIndexPath*)indexPath;
- (NSArray*) arrayInSection:(NSInteger)section;

@end




@interface MHIndexPathArray (NVTableViewCell)
- (void) addObject:(id)object beforeCellType:(NSString*)cellType;
- (void) addObject:(id)object afterCellType:(NSString *)cellType;
- (void) removeObjectByCellType:(NSString*)cellType;
@end
