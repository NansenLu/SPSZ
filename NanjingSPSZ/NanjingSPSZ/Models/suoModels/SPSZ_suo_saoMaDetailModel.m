//
//  SPSZ_suo_saoMaDetailModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/29.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_saoMaDetailModel.h"

@implementation SPSZ_suo_saoMaDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"suo_PaiZhaoId" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
