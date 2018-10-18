//
//  MHTableViewAdaptor.m
//  MHUIKIT
//
//  Created by minghe on 2018/9/19.
//  Copyright © 2018年 minghe. All rights reserved.
//

#import "MHTableViewAdaptor.h"
#import <objc/runtime.h>
#import "MHTableViewHeaderView.h"
#import "MHTableViewFooterView.h"
@interface MHTableViewAdaptor ()
- (NSInteger) numberOfSections;

//获取indexpath位置上cell的数据模型
- (id<MHTableViewCellItemProtocol>) objectForRowAtIndexPath:(NSIndexPath *)indexPath;

//获取cell数据模型item对应的cell的类对象
- (Class) cellClassForObject:(id<MHTableViewCellItemProtocol>)object;

- (NSString*) identifierForCellAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation MHTableViewAdaptor

- (id) init {
    self = [super init];
    if (self) {
        self.canMove = NO;
        self.canEdit = NO;
    }
    
    return self;
}

- (NSString*) tableViewClassName {
    return @"MHTableView";
}

- (MHTableViewCell *) generateCellForObject:(id<MHTableViewCellItemProtocol>)object
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifier {
    MHTableViewCell * cell = nil;
    
    if (object) {
        Class cellClass = [self cellClassForObject:object];
        
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (NSInteger) numberOfSections {
    return [_items sectionCount];
}

- (CGFloat) heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight       = 0;
    
    UITableView * tableView = _uiTableView;
    id object               = [self objectForRowAtIndexPath:indexPath];
    
    Class cellClass         = [self cellClassForIndexPath:indexPath];
//    if ([object isKindOfClass:[MHDataModel class]]) {
//        MHDataModel *model = object;
//        return model.cellHeight.doubleValue;
//    }
    rowHeight               = [cellClass tableView:tableView rowHeightForObject:object];
    
    return rowHeight;
}

- (id<MHTableViewCellItemProtocol>) objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object   = nil;
    object      = [self.items objectAtIndexPath:indexPath];
    return object;
}

- (Class) cellClassForObject:(id<MHTableViewCellItemProtocol>)object{
    Class cellClass = nil;
    
    if (object) {
        if ([object respondsToSelector:@selector(cellClass)]) {
            cellClass = [object cellClass];
        }
    }
    
    return cellClass;
}



- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath{
    Class cellClass = nil;
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    cellClass = [self cellClassForObject:object];
    
    return cellClass;
}

- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = nil;
    identifier = [self cellTypeAtIndexPath:indexPath];
    
    return identifier;
}

- (NSString *)cellTypeAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellType = nil;
    
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object) {
        cellType = [object cellType];
    }
    
    return cellType;
}



#pragma mark - UI TableView DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSections];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items countAtSection:section];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    NSString * identifier  = [self identifierForCellAtIndexPath:indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil) {
        //初始化cell
        cell = [self generateCellForObject:object indexPath:indexPath identifier:identifier];
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height      = 0;
    
    if (_uiTableView == nil) {
        _uiTableView = (MHTableView*)tableView;
    }
    height = [self heightForRowAtIndexPath:indexPath];
    return height;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:canEditObject:forRowAtIndexPath:)]) {
        return [_delegate tableView:tableView canEditObject:object forRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:canMoveObject:forRowAtIndexPath:)]) {
        return [_delegate tableView:tableView canMoveObject:object forRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_delegate && [_delegate respondsToSelector:@selector(tableView:commitDeletingObject:forRowAtIndexPath:)]) {
            [_delegate tableView:tableView commitDeletingObject:object forRowAtIndexPath:indexPath];
        }
    }
}

- (BOOL) tableView:(UITableView *)tableView enableGroupModeAtSection:(NSInteger)section {
    
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:enableGroupModeAtSection:)]) {
        return [_delegate tableView:tableView enableGroupModeAtSection:section];
    }
    
    return NO;
}


#pragma mark - UI TableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didSelectObject:rowAtIndexPath:)]) {
        [_delegate tableView:tableView didSelectObject:object rowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    id<MHTableViewCellItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    
    //更新数据
    if ([cell isKindOfClass:[MHTableViewCell class]]) {
        [(MHTableViewCell *)cell setItem:object];
    }
}


#pragma mark - UI ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if ([self respondsToSelector:@selector(tableViewWillBeginDragging:)]) {
        [self performSelector:@selector(tableViewWillBeginDragging:) withObject:scrollView];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewWillBeginDragging:)]) {
        [_delegate tableViewWillBeginDragging:(UITableView*)scrollView];
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ([self respondsToSelector:@selector(tableViewDidEndDragging:)]) {
        [self performSelector:@selector(tableViewDidEndDragging:) withObject:scrollView];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewDidEndDragging:)]) {
        [_delegate tableViewDidEndDragging:(UITableView*)scrollView];
    }
}


- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    
    if ([self respondsToSelector:@selector(tableViewDidScroll:)]) {
        [self performSelector:@selector(tableViewDidScroll:) withObject:scrollView];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        [_delegate tableViewDidScroll:(UITableView*)scrollView];
    }
    
    CGRect frame = scrollView.frame;
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    
    if (size.height <= offset.y + frame.size.height - 30.0f) {
        if (_delegate && [_delegate respondsToSelector:@selector(tableViewScrollBottom:)]) {
            [_delegate tableViewScrollBottom:(UITableView*)scrollView];
        }
    }
}


@end



static char kAdapterArrayKeysObjectKey;
static char kAdapterHeaderModelsObjectKey;


@implementation MHTableViewAdaptor (Index)
@dynamic arrayKeys;
@dynamic headerModels;


- (NSArray*) arrayKeys {
    return (NSArray *)objc_getAssociatedObject(self, &kAdapterArrayKeysObjectKey);
}

- (void) setArrayKeys:(NSMutableArray *)arrayKeys {
    objc_setAssociatedObject(self, &kAdapterArrayKeysObjectKey, arrayKeys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (Class) headerModels {
    return (Class)objc_getAssociatedObject(self, &kAdapterHeaderModelsObjectKey);
}

- (void)setHeaderModels:(NSMutableArray *)headerModels {
    objc_setAssociatedObject(self, &kAdapterHeaderModelsObjectKey, headerModels, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - UI TableView DataSource
- (NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.arrayKeys && self.arrayKeys.count) {
            return self.arrayKeys;
    }
    return @[];
}

//- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    NSInteger count = 0;
//
//    for (NSString* character in self.arrayKeys) {
//        if ([character isEqualToString:title]) {
//            return count;
//        }
//        count++;
//    }
//    return count;
//}


#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.0f;
    if (self.headerModels && self.headerModels.count && section < self.headerModels.count) {
        MHTableViewHeaderViewModel *model = self.headerModels[section];
        if (model.cellClass) {
          height = [model.cellClass tableView:tableView sectionHeaderHeightForObject:model];
        }
    }
    return height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MHTableViewHeaderViewModel *model = self.headerModels[section];

    MHTableViewHeaderView* headerView = nil;
    if (model.cellClass) {
        headerView = [[model.cellClass alloc] init];
    } else {
        headerView = [[MHTableViewHeaderView alloc] init];
    }
    headerView.model = model;
    return headerView;
}

@end



static char kAdapterFooterModelsObjectKey;

@implementation MHTableViewAdaptor (Footer)
@dynamic footerModels;


- (NSArray*) footerModels {
    return (NSArray*)objc_getAssociatedObject(self, &kAdapterFooterModelsObjectKey);
}

- (void)setFooterModels:(NSMutableArray *)footerModels {
    objc_setAssociatedObject(self, &kAdapterFooterModelsObjectKey, footerModels, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.0f;
    NSInteger count = [self.footerModels count];
    if (count > 0) {
        if (count > section) {
            MHTableViewFooterViewModel * object = [self.footerModels objectAtIndex:section];
            Class cellClass = [self cellClassForObject:object];
            if (cellClass) {
                height = [cellClass tableView:tableView sectionFooterHeightForObject:object];
            }
        }
    }
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSInteger count = [self.footerModels count];
    if (count > 0 && count > section) {
        MHTableViewFooterViewModel * object = [self.footerModels objectAtIndex:section];
        Class cellClass = [self cellClassForObject:object];
        
        if (cellClass) {
            MHTableViewFooterView* footerView       = [[cellClass alloc] init];
            [footerView setModel:object];
            return footerView;
        }
    }    
    return nil;
}

@end

