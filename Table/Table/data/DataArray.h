//
//  DataArray.h
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Open.h"
@interface DataArray : NSObject
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *resultArray;
- (void)initData;
- (NSInteger)deleteObjectWithDataArray:(NSMutableArray *)dataArray count:(NSInteger)count;
- (void)compareSameLevelWithModel:(Open *)model row:(NSInteger)row ;
@end
