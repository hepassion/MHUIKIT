//
//  MHTableViewDataConstructor.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHIndexPathArray.h"
#import <UIKit/UIKit.h>
#import "MHDataModel.h"
#import "MHTableViewCell.h"

@interface MHTableViewDataConstructor : NSObject

@property (nonatomic, strong) MHIndexPathArray * items;
@property (nonatomic, assign) UIViewController* viewControllerDelegate;

- (void) constructData;
- (void) constructData:(void (^)(NSString *, MHDataModel *))reactBlock before:(void(^)(void))beforeBlock;

- (MHDataModel *) modelByCellType:(NSString*)cellType;
- (MHTableViewCell *) cellByCellType:(NSString*)cellType;

- (id) valueForCellType:(NSString*)cellType;
- (void) updateHighlightCell:(CGPoint)offset;

- (void) indexPathByCellType:(NSString*)cellType block:(void (^)(NSIndexPath* indexPath))block;

- (void) refreshValueForCellType:(NSString*)cellType;
- (void) refreshValueForCellType:(NSString *)cellType block:(void (^)(MHDataModel* item))block;

@end



@interface MHTableViewDataConstructor (Category)

@property (nonatomic, strong) NSMutableArray* arrayKeys;
@property (nonatomic, strong) NSMutableArray * headerModels;//MHTableViewHeaderViewModel
@property (nonatomic, strong) NSMutableArray * footerModels;//MHTableViewFooterViewModel

@end

