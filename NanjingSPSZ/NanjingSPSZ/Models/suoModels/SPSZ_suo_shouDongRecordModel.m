//
//  SPSZ_suo_shouDongRecordModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/26.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_shouDongRecordModel.h"

@implementation SPSZ_suo_shouDongRecordModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"answer_id" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end