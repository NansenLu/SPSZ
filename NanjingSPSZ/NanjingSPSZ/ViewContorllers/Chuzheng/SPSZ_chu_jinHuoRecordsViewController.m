//
//  SPSZ_chu_jinHuoRecordsViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/28.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chu_jinHuoRecordsViewController.h"

#import "SPSZ_chu_jinHuoRecordsTableViewCell.h"

#import "SPSZ_chu_jinHuoModel.h"

#import "ChuzhengNetworkTool.h"

#import "KRAccountTool.h"
#import "SPSZ_chuLoginModel.h"
#import "PGDatePickManager.h"
#import "MJRefresh.h"

@interface SPSZ_chu_jinHuoRecordsViewController ()<UITableViewDelegate,UITableViewDataSource,PGDatePickerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *dateString;
@end


@implementation SPSZ_chu_jinHuoRecordsViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth,MainScreenHeight - [ProgramSize statusBarAndNavigationBarHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SPSZ_chu_jinHuoRecordsTableViewCell class] forCellReuseIdentifier:@"SPSZ_chu_jinHuoRecordsTableViewCell"];
        KRWeakSelf;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.dataArray removeAllObjects];
            weakSelf.index = 1;
            [weakSelf downLoadDataWith:self.dateString];
         }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf upLoadDataWith:self.dateString];
        }];
    }
    return _tableView;
}

- (void)configNavigation
{
    self.navigationItem.title = @"进货记录";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"calendar_white"] forState:UIControlStateNormal];
    [rightButton setTitle:@"日期查询" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
 
    rightButton.frame = CGRectMake(0, 0, 90, 44);
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(13, 10, 13, 62)];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
     [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)backToUpView
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 1;
    self.dateString = nil;
    [self configNavigation];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backToUpView)];
    self.navigationItem.leftBarButtonItem = item;
    [self.view addSubview:self.tableView];
    
    [self downLoadDataWith:self.dateString];
}


//下拉
- (void)downLoadDataWith:(NSString *)date
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
    [ChuzhengNetworkTool geChuZhengJinHuoRecordsUserid:model.login_Id dishdate:date pageSize:10 pageNo:self.index successBlock:^(NSMutableArray *modelArray) {
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.index++;
        [weakSelf.dataArray addObjectsFromArray:modelArray];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer  setState:MJRefreshStateIdle];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf.tableView.mj_header endRefreshing];
    } failureBlock:^(NSString *failure) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

// 上拉
- (void)upLoadDataWith:(NSString *)date
{
    KRWeakSelf;
    SPSZ_chuLoginModel *model = [KRAccountTool getChuUserInfo];
    [ChuzhengNetworkTool geChuZhengJinHuoRecordsUserid:model.login_Id dishdate:date pageSize:10 pageNo:self.index successBlock:^(NSMutableArray *modelArray) {
        [weakSelf.tableView.mj_footer endRefreshing];
        weakSelf.index++;
        [weakSelf.dataArray addObjectsFromArray:modelArray];
        [weakSelf.tableView reloadData];
    } errorBlock:^(NSString *errorCode, NSString *errorMessage) {
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    } failureBlock:^(NSString *failure) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======== UITableViewDeleate, UITableViewDataSource ========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSZ_chu_jinHuoModel *model = self.dataArray[indexPath.row];
    
    SPSZ_chu_jinHuoRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPSZ_chu_jinHuoRecordsTableViewCell" forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)rightButtonAction:(UIButton *)button{
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    datePickManager.style = PGDatePickManagerStyle3;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGDatePickerType2;
    datePicker.isHiddenMiddleText = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    [self presentViewController:datePickManager animated:false completion:nil];
}



- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",dateComponents.year,dateComponents.month,dateComponents.day];    
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    self.dateString = date;
    self.index = 1;
    [self downLoadDataWith:date];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
