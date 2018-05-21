//
//  SPSZ_suo_RecordTableViewCell.h
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/21.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSZ_suo_RecordModel.h"

@interface SPSZ_suo_RecordTableViewCell : UITableViewCell


@property (nonatomic, strong) SPSZ_suo_RecordModel *model;

@property (nonatomic, strong)UILabel *shopNameLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UILabel *orderNumberlabel;

@property (nonatomic, strong)UILabel *orderNameLabel;

@property (nonatomic, strong)UILabel *phoneNumberLabel;

@property (nonatomic, strong)UIButton *detailButton;
@end