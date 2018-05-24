//
//  SPSZ_shouDongViewController.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/22.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_shouDongViewController.h"

@interface SPSZ_shouDongViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *mainView;

@property (nonatomic, strong)UITextField *productNameTextField;

@property (nonatomic, strong)UIButton *productLocationButton;

@property (nonatomic, strong)UITextField *detailLocationTextField;

@property (nonatomic, strong)UITextField *numberTextField;

@property (nonatomic, strong)UITextField *companyTextField;

@property (nonatomic, strong)UITextField *nameTextField;

@property (nonatomic, strong)UITextField *phoneTextField;

@property (nonatomic, strong)UIButton *timeButton;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSMutableArray *titleArray;

@end

@implementation SPSZ_shouDongViewController


- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"产品名称",@"产品产地",@"详细地址",@"进货数量/重量",@"供货单位",@"批发商姓名",@"联系电话",@"发货时间", nil];
    }
    return _titleArray;
}

- (UITextField *)productNameTextField{
    if (!_productNameTextField) {
        _productNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _productNameTextField.delegate = self;
        _productNameTextField.tintColor = [UIColor redColor];
        _productNameTextField.textAlignment = NSTextAlignmentRight;
        _productNameTextField.placeholder = @"请输入";
    }
    return _productNameTextField;
}


- (UITextField *)detailLocationTextField{
    if (!_detailLocationTextField) {
        _detailLocationTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _detailLocationTextField.delegate = self;
        _detailLocationTextField.tintColor = [UIColor redColor];
        _detailLocationTextField.textAlignment = NSTextAlignmentRight;
        _detailLocationTextField.placeholder = @"请输入";
    }
    return _detailLocationTextField;
}

- (UITextField *)numberTextField{
    if (!_numberTextField) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 0, _width - 140 -10, _height)];
        _numberTextField.delegate = self;
        _numberTextField.tintColor = [UIColor redColor];
        _numberTextField.textAlignment = NSTextAlignmentRight;
        _numberTextField.placeholder = @"请输入";
    }
    return _numberTextField;
}

- (UITextField *)companyTextField{
    if (!_companyTextField) {
        _companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _companyTextField.delegate = self;
        _companyTextField.tintColor = [UIColor redColor];
        _companyTextField.textAlignment = NSTextAlignmentRight;
        _companyTextField.placeholder = @"请输入";
    }
    return _companyTextField;
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, _width - 130 -10, _height)];
        _nameTextField.delegate = self;
        _nameTextField.tintColor = [UIColor redColor];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        _nameTextField.placeholder = @"请输入";
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, _width - 110 -10, _height)];
        _phoneTextField.delegate = self;
        _phoneTextField.tintColor = [UIColor redColor];
        _phoneTextField.textAlignment = NSTextAlignmentRight;
        _phoneTextField.placeholder = @"请输入";
    }
    return _phoneTextField;
}

- (UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        [_timeButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

- (UIButton *)productLocationButton{
    if (!_productLocationButton) {
        _productLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _productLocationButton.backgroundColor = [UIColor redColor];
        _productLocationButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _productLocationButton.frame = CGRectMake(110, 0, _width - 110 -10, _height);
        [_productLocationButton setTitle:@"请选择" forState:UIControlStateNormal];
        [_productLocationButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productLocationButton;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, MainScreenWidth - 60, MainScreenHeight -264)];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor   = [ UIColor clearColor];

    self.height = (MainScreenHeight -264)/8;
    self.width = MainScreenWidth - 60;
    
    [self.view addSubview:self.mainView];

    [self setUpView];
}

- (void)setUpView{
    
    [self setUpViewWith:0 textfield:self.productNameTextField button:nil];
    [self setUpViewWith:1 textfield:nil button:self.productLocationButton];
    [self setUpViewWith:2 textfield:self.detailLocationTextField button:nil];
    [self setUpViewWith:3 textfield:self.numberTextField button:nil];
    [self setUpViewWith:4 textfield:self.companyTextField button:nil];
    [self setUpViewWith:5 textfield:self.nameTextField button:nil];
    [self setUpViewWith:6 textfield:self.phoneTextField button:nil];
    [self setUpViewWith:7 textfield:nil button:self.timeButton];
}


- (void)setUpViewWith:(NSInteger)number textfield:(UITextField *)textfield button:(UIButton *)button{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _height*number, _width, _height)];
    if (number == 1 || number == 7) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, _height)];
        label.textColor = [UIColor redColor];
        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"    " string2:self.titleArray[number]]];
        [view addSubview:label];
        [view addSubview:button];
    }else{
        CGFloat w = 100;
        if (number == 3 || number == 5) {
            w = 140;
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, _height)];
        label.textColor = [UIColor redColor];
        [label setAttributedText:[self Color:[UIColor redColor] secondColor:[UIColor lightGrayColor] string:@"*  " string2:self.titleArray[number]]];
        [view addSubview:label];
        [view addSubview:textfield];
    }
    if (number != 7) {
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(10, _height- 1, _width - 20, 1)];
        lineView.backgroundColor = [ProgramColor huiseColor];
        [view addSubview:lineView];
    }
    [self.mainView addSubview:view];
}


- (void)tapAction:(UIButton *)button{
    
    
}



- (NSMutableAttributedString *)Color:(UIColor *)color
                         secondColor:(UIColor *)secondColor
                              string:(NSString *)string
                             string2:(NSString *)string2{
    NSString *str = [NSString stringWithFormat:@"%@%@",string,string2];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:string2].location, [[noteStr string] rangeOfString:string2].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:secondColor range:redRange];
    return noteStr;
    
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
