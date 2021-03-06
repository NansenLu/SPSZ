//
//  SPSZ_suo_MainViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suo_MainViewController.h"
#import "SPSZ_saoMa_ViewController.h"
#import "SPSZ_shouDongViewController.h"
#import "SPSZ_paiZhaoViewController.h"
#import "SPSZ_jinHuo_RecordsViewController.h"
#import "SPSZ_suo_personalCenterViewController.h"
#import "SPSZ_chu_personalCenterViewController.h"

 
#import "AppDelegate.h"
#import "BaseNavigationController.h"

#import "KRTagBar.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIButton+Gradient.h"


@interface SPSZ_suo_MainViewController ()
<
KRTagBarDelegate,
UIScrollViewDelegate,
paiZhaoSuccessDelegate,
saoMaSuccessDelegate
>
{
    SPSZ_saoMa_ViewController *vc1;
    SPSZ_paiZhaoViewController *vc2;
    SPSZ_shouDongViewController *vc3;
}
@property (nonatomic, strong) KRTagBar          *tagBar;

@property (nonatomic, strong) UIView          *containerView;

@property (nonatomic, strong) UIScrollView    *detailScrollView;

@property (nonatomic, strong) UIView          *bottomView;

@property (nonatomic, strong) UIButton        *recordsButton;

@property (nonatomic, strong) UIButton        *centerButton;

@property (nonatomic, strong) UIButton        *personButton;

@property (nonatomic, strong) NSString        *centerButtonTitle;

@property (nonatomic, strong) NSString        *centerButtonImageName;

@property (nonatomic, strong) UIImageView     *imageView;

@property (nonatomic, strong) NSMutableArray   *vcArray;

@property (nonatomic, assign) BOOL  paiZhaoVcType;

@property (nonatomic, assign) BOOL  saoMaVcType;





@end

@implementation SPSZ_suo_MainViewController

- (void)configNavigation
{
    self.navigationItem.title = @"进货录入";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"refresh_white"] forState:UIControlStateNormal];
    [rightButton setTitle:@"重新录入" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    rightButton.frame = CGRectMake(0, 0, 80, 44);
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,MainScreenHeight -120 - [ProgramSize statusBarAndNavigationBarHeight] - [ProgramSize bottomHeight], MainScreenWidth, 120 + [ProgramSize bottomHeight])];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, MainScreenWidth, 30)];
        imageView.image = [UIImage imageNamed:@"bg_white_radius"];
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, MainScreenWidth, 70 +[ProgramSize bottomHeight])];
        whiteView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        
        [_bottomView addSubview:imageView];
        [_bottomView addSubview:whiteView];

        [whiteView addSubview:self.recordsButton];
        [whiteView addSubview:self.personButton];
        [_bottomView addSubview:self.centerButton];
    }
    return _bottomView;
}

- (UIButton *)recordsButton{
    if (!_recordsButton) {
        _recordsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordsButton.frame = CGRectMake(20, 0, 80, 60);//25 25
        [_recordsButton setImage:[UIImage imageNamed:@"record_gray"] forState:UIControlStateNormal];
        [_recordsButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_recordsButton setTitle:@"进货记录" forState:UIControlStateNormal];
        [_recordsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_recordsButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];
        [_recordsButton addTarget:self action:@selector(recordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordsButton;
}

- (UIButton *)personButton{
    if (!_personButton) {
        _personButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _personButton.frame = CGRectMake(MainScreenWidth - 80 -20, 0, 80, 60);
        [_personButton setImage:[UIImage imageNamed:@"user_gray"] forState:UIControlStateNormal];
        [_personButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
 
        [_personButton setTitle:@"个人中心" forState:UIControlStateNormal];
        [_personButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_personButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5];

        [_personButton addTarget:self action:@selector(personButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personButton;
}

- (UIButton *)centerButton{
    if (!_centerButton){
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerButton.frame = CGRectMake((MainScreenWidth - 100)/2, 0, 100, 100);
        _centerButton.layer.masksToBounds = YES;
        _centerButton.layer.cornerRadius = 50;
        [_centerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_centerButton setImage:[UIImage imageNamed:@"scan_qr_white"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"扫码上传" forState:UIControlStateNormal];
        [_centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_centerButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [_centerButton addTarget:self action:@selector(sureUpLoadAction:) forControlEvents:UIControlEventTouchUpInside];
        [_centerButton gradientButtonWithSize:CGSizeMake(120, 120) colorArray:@[[ProgramColor RGBColorWithRed:33 green:211 blue:255 alpha:0.94],[ProgramColor RGBColorWithRed:67 green:130 blue:255 alpha:0.94]] percentageArray:@[@(1),@(0)] gradientType:GradientFromTopToBottom];
    }
    return _centerButton;
}




- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.navigationBar.hidden = NO;
    self.paiZhaoVcType = NO;
    self.saoMaVcType = NO;
    
    UIImage *naviBackImage = [[UIImage alloc] createImageWithSize:CGSizeMake([ProgramSize mainScreenWidth], [ProgramSize mainScreenHeight])
                                                   gradientColors:[ProgramColor blueGradientColors]
                                                       percentage:@[@(1), @(0)]
                                                     gradientType:GradientFromTopToBottom];

    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    [self.view addSubview:self.imageView];
    [self.imageView setImage:naviBackImage];
    self.imageView.userInteractionEnabled = YES;

    [self setupTagBar];
    
    [self configNavigation];
    [self setupDetailScrollView];
    [self.view addSubview:self.bottomView];
}

//设置按钮标签的scrollview
- (void)setupTagBar
{
    NSArray *itemArray = [NSArray arrayWithObjects:@"扫码上传",@"拍照上传",@"手动上传", nil];
    // 中间滑动的scrollView
    self.tagBar = [[KRTagBar alloc]init];
    self.tagBar.itemArray = itemArray;
    [self.view addSubview:self.tagBar];
    [self.tagBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.height.equalTo(40);
    }];
    self.tagBar.tagBarDelegate = self;
}



-(void)setupDetailScrollView
{
    NSInteger count = 3;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(40);
        make.left.right.bottom.equalTo(0);
    }];
    
    CGFloat wid = count * MainScreenWidth;
    
    self.containerView = [[UIView alloc] init];
    [scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
        make.width.equalTo(wid);
    }];
    
    
    
    vc1 = [[SPSZ_saoMa_ViewController alloc]init];
    vc1.delegate = self;
    vc2 = [[SPSZ_paiZhaoViewController alloc]init];
    vc2.delegate = self;
    vc3 = [[SPSZ_shouDongViewController alloc]init];
    

    self.vcArray = [NSMutableArray arrayWithObjects:vc1,vc2,vc3, nil];
    
    for (int i = 0; i < count; i ++) {
        CGFloat x = i * MainScreenWidth;
        CGFloat w = MainScreenWidth;
        BaseViewController *vc = self.vcArray[i];
        [self.containerView addSubview:vc.view];
        // !!!!
        [self addChildViewController:vc];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(x);
            make.width.equalTo(w);
            make.top.equalTo(0);
            make.height.equalTo(MainScreenHeight - 204);
        }];
    }

    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.bounces = false;
    self.detailScrollView = scrollView;
    [self.tagBar selectIndex:0];
}


#pragma mark ---- 点击了滑动的标签 ---- KRTagBarDelegate
-(void)tagBarDidClickBtn:(UIButton *)btn atIndex:(NSInteger)index
{
    self.detailScrollView.contentOffset = CGPointMake(index * MainScreenWidth, 0);
    [self changeCenterButtonTitleWith:index];

}

#pragma mark - ========== Delegate ==========
#pragma mark ---- UIScrollViewDelegate ----
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.detailScrollView]) {
        CGFloat pedding = scrollView.contentOffset.x;
        int index = (pedding / MainScreenWidth);
        if (index != self.tagBar.selectedIndex)
        {
            [self.tagBar selectIndex:index];
        }
        else
        {
            [self.tagBar updateContentOffSet:scrollView.contentOffset];
        }
        [self changeCenterButtonTitleWith:index];
        
        
    }
}

- (void)changeCenterButtonTitleWith:(NSInteger)index{
    if (index == 0 || index == 1) {
        SPSZ_shouDongViewController *vc = self.vcArray[2];
        [vc huishoujianpan];
    }
    
    if (index == 0) {
        [self setSaoMaVcButton];
        self.centerButtonImageName = @"scan_qr_white";
    }else if (index == 1){
        [self setPaiZhaoVcCenterButton];

        self.centerButtonImageName = @"scan_qr_white";
    }else if (index == 2){
        [_centerButton setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"确认上传" forState:UIControlStateNormal];
    }
}

// paizhao vc
- (void)buttonImageType:(BOOL)type
{
    self.paiZhaoVcType = type;
    
    [self setPaiZhaoVcCenterButton];
}

- (void)setPaiZhaoVcCenterButton
{
    if (self.paiZhaoVcType) { // 上传
        [_centerButton setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"确认上传" forState:UIControlStateNormal];
    }else{
        [_centerButton setImage:[UIImage imageNamed:@"take_photo_white"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"拍照上传" forState:UIControlStateNormal];
    }
}

// sao ma vc
- (void)saoMabuttonImageType:(BOOL)type
{
    self.saoMaVcType = type;
    [self setSaoMaVcButton];
}

- (void)setSaoMaVcButton
{
    if (self.saoMaVcType) {
        [_centerButton setImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"确认上传" forState:UIControlStateNormal];
    }else{
        [_centerButton setImage:[UIImage imageNamed:@"scan_qr_white"] forState:UIControlStateNormal];
        [_centerButton setTitle:@"扫码上传" forState:UIControlStateNormal];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.detailScrollView]) {
        [self.tagBar updateContentOffSet:scrollView.contentOffset];
    }
    
}

#pragma mark ---- action -----
- (void)recordButtonAction:(UIButton *)button{
    SPSZ_jinHuo_RecordsViewController *vc = [[SPSZ_jinHuo_RecordsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)personButtonAction:(UIButton *)button{
    SPSZ_suo_personalCenterViewController *vc = [[SPSZ_suo_personalCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sureUpLoadAction:(UIButton *)button{
    
    if (self.tagBar.selectedIndex == 2) {
         [vc3 sureUpload];
    }else if (self.tagBar.selectedIndex == 1){
         [vc2 takePhotoAction];
    }else{
         [vc1 saoMa];
    }
}




- (void)rightButtonAction:(UIButton *)button
{
    if (self.tagBar.selectedIndex == 2) {
        [vc3 reloadNewData];
    }else if (self.tagBar.selectedIndex == 1){
         [vc2 reEnterAction];
    }else{
         [vc1 reSaoMa];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
