//
//  Open.m
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import "Open.h"

@implementation Open
- (instancetype)init {
    self = [super init];
    if (self) {
        [Open mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"detailArray" : [Open class]
                     };
        }];
    }
    return self;
}
@end
