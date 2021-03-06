//
//  ChuzhengNetworkTool.h
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/25.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSZ_ChuhuoModel;
@class SPSZ_GoodsModel;

@interface ChuzhengNetworkTool : NSObject

/**
 *  添加货物,  获取数据源
 */
+ (void)addGoodsFromPageNumber:(int)pageNumber
                  successBlock:(void (^)(NSMutableArray *goodsArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock;


/**
 *  获取出证记录
 */
+ (void)geChuZhengRecordsPageSize:(NSInteger)pageSize
                           pageNo:(NSInteger)pageNo
                           userId:(NSString *)userId
                        printdate:(NSString *)printdate
                  successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                    errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                  failureBlock:(void (^)(NSString *failure))failureBlock;

/**
 *  获取批发商进货记录
 */
//+ (void)geChuZhengJinHuoRecordsStall_id:(NSString *)stall_id
//                        printdate:(NSString *)printdate
//                     successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
//                       errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
//                     failureBlock:(void (^)(NSString *failure))failureBlock;
+ (void)geChuZhengJinHuoRecordsUserid:(NSString *)userid
                             dishdate:(NSString *)dishdate
                             pageSize:(NSInteger )pageSize
                               pageNo:(NSInteger )pageNo
                           successBlock:(void (^)(NSMutableArray *modelArray))successBlcok
                             errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
                           failureBlock:(void (^)(NSString *failure))failureBlock;


/**
 出货录入
 */
+ (void)addGoods:(SPSZ_ChuhuoModel *)model
    successBlock:(void (^)(void))successBlcok
      errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
    failureBlock:(void (^)(NSString *failure))failureBlock;



/**
 上传打印内容
 */
+ (void)uploadPrintContent:(NSArray<SPSZ_GoodsModel *> *)dishes
              successBlock:(void (^)(NSString *qrCodeString))successBlcok
                errorBlock:(void (^)(NSString *errorCode, NSString *errorMessage))errorBlock
              failureBlock:(void (^)(NSString *failure))failureBlock;



@end
