//
//  SPSZ_saoMa_OrderViewController.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/23.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "BaseViewController.h"

@interface SPSZ_saoMa_OrderViewController : BaseViewController

@property (nonatomic, strong)NSString *timeString;


- (void)reloadDataWithDateWith:(NSString *)date;

- (void)loadDataWith:(NSString *)date newDate:(NSString *)newdate;
@end
