//
//  Open.h
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface Open : NSObject
@property (copy, nonatomic) NSString *title;    //非首层展示的标题
@property (assign, nonatomic) NSInteger level;  //决定偏移量大小
@property (copy, nonatomic) NSString *openUrl;  //最后一层跳转的规则
@property (copy, nonatomic) NSMutableArray *detailArray; //下一层的数据
@property (assign, nonatomic) BOOL isOpen;        //是否要展开
@end
