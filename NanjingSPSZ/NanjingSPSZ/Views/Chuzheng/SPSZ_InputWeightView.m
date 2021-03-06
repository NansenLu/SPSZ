//
//  SPSZ_InputWeightView.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_InputWeightView.h"

@interface SPSZ_InputWeightView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *unitLabel;

@end


@implementation SPSZ_InputWeightView

- (instancetype)init
{
    if (self = [super init]) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews
{
    self.weight = @"0";
    self.unit = @"公斤";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"edit_white"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.width.height.equalTo(32);
        make.centerY.equalTo(0);
    }];
    
    UILabel *label = [UICreateTool labelWithFont:[UIFont systemFontOfSize:15] text:self.unit textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-2);
        make.width.equalTo(30);
    }];
    label.userInteractionEnabled = YES;
    self.unitLabel = label;
    
    UILabel *weightLabel = [UICreateTool labelWithFont:[UIFont systemFontOfSize:15] text:self.weight textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight];
    [self addSubview:weightLabel];
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.right.mas_equalTo(label.mas_left).offset(-2);
        make.centerY.equalTo(0);
    }];
    weightLabel.adjustsFontSizeToFitWidth = YES;
    self.label = weightLabel;
    weightLabel.userInteractionEnabled = YES;
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(0);
    }];
}

-(void)setWeight:(NSString *)weight
{
    _weight = weight;
    
    self.label.text = weight;
}

- (void)setUnit:(NSString *)unit
{
    _unit = unit;
    
    if (unit) {
        self.unitLabel.text = unit;
    }
    else {
        self.unitLabel.text = @"公斤";
        _unit = @"公斤";
    }
}


@end
