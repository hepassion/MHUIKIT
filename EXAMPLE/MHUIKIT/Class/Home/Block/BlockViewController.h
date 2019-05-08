//
//  BlockViewController.h
//  HYHText
//
//  Created by 赵明鹤 on 2018/1/29.
//  Copyright © 2018年 赵明鹤. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BlockDataConstructor.h"



// 1 原生   返回头  颜色不一样
//2 自定义    去原生时 


@interface BlockViewController : MHTableViewController

@property (nonatomic, strong) BlockDataConstructor *dataConstructor;



@end
