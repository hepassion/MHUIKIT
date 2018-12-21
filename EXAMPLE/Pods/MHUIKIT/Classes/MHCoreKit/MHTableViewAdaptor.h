//
//  NVTableViewAdaptor.h
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTableView.h"
#import "MHIndexPathArray.h"
#import "MHTableViewCellItemProtocol.h"
#import "MHTableViewCell.h"
@protocol MHTableViewAdaptorDelegate <NSObject>

- (void) tableView:(UITableView *)tableView didSelectObject:(id<MHTableViewCellItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (BOOL) tableView:(UITableView *)tableView canEditObject:(id<MHTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView commitDeletingObject:(id<MHTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell withObject:(id<NVTableViewCellItemProtocol>)object forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewDidScroll:(UITableView *)tableView;
- (void)tableViewWillBeginDragging:(UITableView *)tableView;
- (void)tableViewDidEndDragging:(UITableView *)tableView;
- (void)tableViewScrollBottom:(UITableView*)tableView;

@end


@interface MHTableViewAdaptor : NSObject<MHTableViewDataSource,
UITableViewDelegate>

@property (nonatomic, weak)     MHTableView*                    uiTableView;
@property (nonatomic, strong)   MHIndexPathArray*               items;
@property (nonatomic, weak)     id<MHTableViewAdaptorDelegate>  delegate;
@property (nonatomic, assign)   BOOL                            canEdit;
@property (nonatomic, assign)   BOOL                            canMove;


- (MHTableViewCell *) generateCellForObject:(id<MHTableViewCellItemProtocol>)object
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifier;

- (NSString*) tableViewClassName;

- (void)tableViewDidScroll:(UITableView *)tableView;
- (void)tableViewDidEndDragging:(UITableView *)tableView;
- (void)tableViewWillBeginDragging:(UITableView *)tableView;

@end





@interface MHTableViewAdaptor (Index)

@property (nonatomic, strong) NSMutableArray* arrayKeys; //右侧索引数组  nsstring

@end



@interface MHTableViewAdaptor (Header)

@property (nonatomic, strong) NSMutableArray * headerModels;//MHTableViewHeaderViewModel

@end


@interface MHTableViewAdaptor (Footer)
@property (nonatomic, strong) NSMutableArray * footerModels;//MHTableViewFooterViewModel
@end





