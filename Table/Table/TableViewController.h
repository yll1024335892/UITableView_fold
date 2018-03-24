//
//  TableViewController.h
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataArray.h"

@interface TableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *resultArray;
@end
