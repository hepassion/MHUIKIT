//
//  HomeDataConstructor.m
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/19.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "HomeDataConstructor.h"
#import "MHTitleTableViewCell.h"
#import "MHTestTableViewHeaderView.h"
#import "PDHttpClient+Test.h"

@implementation HomeDataConstructor

- (void)loadData {
    self.pageIndex = FIRST_NO_PER_PAGE;
    
    
    [self MH_startLoading];
    

    [[PDHttpClient sharedInstance] getTestDataSuccess:^(UsrModel *dataModel) {
        [self MH_responseSuccess:dataModel];
        NSLog(@"success");
    } failure:^(MHErrorModel *dataModel) {
        [self MH_responseError:dataModel];
        NSLog(@"failure");
    }];


    [[PDHttpClient sharedInstance] postTestDataSuccess:^(UsrModel *dataModel) {
        NSLog(@"post success");
    } failure:^(MHErrorModel *dataModel) {
         NSLog(@"post failure");
    }];
    
}
- (void)constructData {
    [self.items removeAllObjects];
    MHTitleDataModel *model = [MHTitleDataModel new];
    model.content = @"cell.type.block";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.block";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    model.showTopLine = YES;
    model.topLineColor = COLOR_GRAY;
    model.selectedStyle = UITableViewCellSelectionStyleGray;
    [self.items addObject:model];
    
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.lock";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.lock";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    model.showTopLine = YES;
    model.topLineColor = COLOR_GRAY;
    [self.items addObject:model];

    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.html";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.html";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    model.showTopLine = YES;
    model.topLineColor = COLOR_GRAY;
    model.showRightRow = YES;
    [self.items addObject:model];
 
    model = [MHTitleDataModel new];
    model.content = @"cell.type.failure";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.failure";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
    model.showTopLine = YES;
    model.topLineColor = COLOR_GRAY;

    [self.items addObject:model];
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.baidu";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.baidu";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
//    model.showTopLine = YES;
//    model.topLineColor = COLOR_GRAY;

    [self.items addObject:model];
    
    
    model = [MHTitleDataModel new];
    model.content = @"cell.type.task";
    model.cellClass = [MHTitleTableViewCell class];
    model.cellType  = @"cell.type.task";
    model.cellHeight = @([MHTitleTableViewCell heightForCell]);
    model.delegate = self.viewControllerDelegate;
//    model.showTopLine = YES;
//    model.topLineColor = COLOR_GRAY;
    
    [self.items addObject:model];
    
//
//    NSMutableArray *array = [NSMutableArray new];
//    [array addObject:model];
//
// //   [self.items addObjects:array];
//    [self.items addObjectsAtNewSection:array];
//    
    
    
    MHTestTableViewHeaderViewModel *header = [MHTestTableViewHeaderViewModel new];
    header.title = @"header";
    header.midleText = @"headerText";
    header.cellHeight  =@([ MHTestTableViewHeaderView heightForHeaderView]);
    header.cellType = @"ccdd";
    header.cellClass = [MHTestTableViewHeaderView class];
    NSMutableArray *saa = [NSMutableArray new];
    [saa addObject:header];
    [saa addObject:header];
    
   // self.headerModels = saa;
    
    MHTableViewFooterViewModel *footer = [MHTableViewFooterViewModel new];
    footer.footerTitle = @"footer";
    footer.cellHeight  =@([ MHTableViewFooterView heightForFooterView ]);
    footer.cellType = @"ccdd";
    footer.cellClass = [MHTableViewFooterView class];
    NSMutableArray *bbb = [NSMutableArray  new];
    [bbb addObject:footer];
    [bbb addObject:footer];
    
    //self.footerModels = bbb;
    
    
    
    NSMutableArray *keys = [NSMutableArray new];
    [keys addObject:@"a"];
    [keys addObject:@"b"];
    [keys addObject:@"c"];
    
    //self.arrayKeys = keys;
    
}

@end
