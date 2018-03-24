//
//  DataArray.m
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import "DataArray.h"

@implementation DataArray
- (void)initData {
    _dataArray = [NSMutableArray new];//第一层数据
    _resultArray = [NSMutableArray new];
    NSMutableArray *secondArray1 = [NSMutableArray new];//第二层数据
    NSMutableArray *threeArray1 = [NSMutableArray new]; //第三层数据
    NSMutableArray *fourArray1 = [NSMutableArray new];  //第四层数据
    
    NSArray *FirstTitleArray = @[@"FirstTitle1", @"FirstTitle2", @"FirstTitle3"];
    NSArray *SecondTitleArray = @[@"SecondTitle1", @"SecondTitle2", @"SecondTitle3"];
    NSArray *ThreeTitleArray = @[@"ThreeTitle1", @"ThreeTitle2", @"ThreeTitle3", @"ThreeTitle4"];
    NSArray *FourTitleArray = @[@"FourTitle1", @"FourTitle2", @"FourTitle3"];
    //第四层数据
    for (int i = 0; i < FourTitleArray.count; i++) {
        Open *model = [[Open alloc] init];
        model.title = FourTitleArray[i];
        model.level = 3;
        model.isOpen = NO;
        [fourArray1 addObject:model];
    }
    //第三层数据
    for (int i = 0; i < ThreeTitleArray.count; i++) {
        Open *model = [[Open alloc] init];
        model.title = ThreeTitleArray[i];
        model.level = 2;
        model.isOpen = NO;
        model.detailArray = fourArray1;
        [threeArray1 addObject:model];
    }
    //第二层数据
    for (int i = 0; i < SecondTitleArray.count; i++) {
        Open *model = [[Open alloc] init];
        model.title = SecondTitleArray[i];
        model.level = 1;
        model.isOpen = NO;
        model.detailArray = [threeArray1 mutableCopy];
        [secondArray1 addObject:model];
    }
    //第一层数据
    for (int i = 0; i < FirstTitleArray.count; i++) {
        Open *model = [[Open alloc] init];
        model.title = FirstTitleArray[i];
        model.level = 0;
        model.isOpen = NO;
        model.detailArray = [secondArray1 mutableCopy];
        [_dataArray addObject:model];
    }
    //处理源数据，获得展示数组_resultArray
    [self dealWithDataArray:_dataArray];
}
#pragma 将源数据数组处理成要展示的一维数组，最开始是展示首层的所有的数据
/**
 @param dataArray 源数据数组
 */
- (void)dealWithDataArray:(NSMutableArray *)dataArray {//递归
    for (Open *model in dataArray) {
        [_resultArray addObject:model];
        if (model.isOpen && model.detailArray.count > 0) {
            [self dealWithDataArray:model.detailArray];
        }
    }
}
#pragma 当首层没有展开数据时，点击首层展开第二层数据，比较容易实现，即在_resultArray添加下一层数据
/**
 在指定位置插入要展示的数据
 @param dataArray 数据数组
 @param row       需要插入的数组下标
 */
- (void)addObjectWithDataArray:(NSMutableArray *)dataArray row:(NSInteger)row {
    for (int i = 0; i < dataArray.count; i++) {
        Open *model = dataArray[i];
        model.isOpen = NO;
        [_resultArray insertObject:model atIndex:row];
        row += 1;
    }
}
#pragma 收起方法实现
/**
 删除要收起的数据
 @param dataArray 数据
 @param count     统计删除数据的个数
 @return 删除数据的个数
 */
- (NSInteger)deleteObjectWithDataArray:(NSMutableArray *)dataArray count:(NSInteger)count {
    for (Open *model in dataArray) {
        count += 1;
        
        if (model.isOpen && model.detailArray.count > 0) {
            count = [self deleteObjectWithDataArray:model.detailArray count:count];
        }
        
        model.isOpen = NO;
        
        [_resultArray removeObject:model];
    }
    
    return count;
}
#pragma 在已经展开的时候点击另外一个目录，要先收起再展开。因为每个层次只有一个目录是展开的，所以收起的时候，只需要跟同层次的目录数据比较，如果是已经打开的，则删除打开目录的所有子层
/**
 与点击同一层的数据比较，然后删除要收起的数据和插入要展开的数据
 @param model 点击的cell对应的model
 @param row   点击的在tableview的indexPath.row,也对应_resultArray的下标
 */
- (void)compareSameLevelWithModel:(Open *)model row:(NSInteger)row {
    NSInteger count = 0;
    NSInteger index = 0;    //需要收起的起始位置
    //如果直接用_resultArray，在for循环为完成之前，_resultArray会发生改变，使程序崩溃。
    NSMutableArray *copyArray = [_resultArray mutableCopy];
    
    for (int i = 0; i < copyArray.count; i++) {
        Open *openModel = copyArray[i];
        if (openModel.level == model.level) {
            //同一个层次的比较
            if (openModel.isOpen) {
                //删除openModel所有的下一层
                count = [self deleteObjectWithDataArray:openModel.detailArray count:count];
                index = i;
                openModel.isOpen = NO;
                break;
            }
        }
    }
    //插入的位置在删除的位置的后面，则需要减去删除的数量。
    if (row > index && row > count) {
        row -= count;
    }
    
    [self addObjectWithDataArray:model.detailArray row:row + 1];
}
@end
