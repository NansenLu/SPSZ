//
//  SPSZ_suo_shouDongTableViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/26.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSZ_suo_shouDongRecordModel.h"

@interface SPSZ_suo_shouDongTableViewCell : UITableViewCell

@property (nonatomic, strong) SPSZ_suo_shouDongRecordModel *model;

@property (nonatomic, strong)UILabel *shopNameLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UILabel *productNameLabel;

@property (nonatomic, strong)UILabel *weightLabel;

@property (nonatomic, strong)UILabel *productLocationLabel;

@property (nonatomic, strong)UILabel *piFaNamelabel;

@property (nonatomic, strong)UILabel *phoneLabel;
@end
