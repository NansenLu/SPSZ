//
//  SPSZ_suo_saoMaoOrderModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_saoMaoOrderModel.h"

@implementation SPSZ_suo_saoMaoOrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"suo_saoMaId" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
