//
//  BaseViewController.m
//  test
//
//  Created by zzy on 17/1/4.
//  Copyright © 2017年 zzy. All rights reserved.
// zzy 利用wrap作为容器装一个navigationcontroller（有个根视图即想展现的试图）的view，wrap的navigationcotroller隐藏， 每次push用容器的隐藏导航栏push pop也是    这样就使得导航栏跟着动的效果

#import "BaseViewController.h"
#import "WrapViewController.h"
@interface BaseViewController ()
@property(nonatomic,strong)WrapViewController* wrapVC;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIButton* but = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    
//    but.center =  self.view.center;
    
    [but setTitle:@"下一个" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:but];
//    [but mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(30);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
////        make.center.mas_equalTo(0);
//    }];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)setbackBtn
{
    UIButton* backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"fanhui" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}
- (WrapViewController *)wrapVC
{
    if (!_wrapVC) {
        if ([self.navigationController.parentViewController isKindOfClass:[WrapViewController class]]) {
            _wrapVC = (WrapViewController*)self.navigationController.parentViewController;
        }
    }
    return _wrapVC;
}
-(void)clickBack
{//用容器wrap的隐藏导航栏pop
    [self.wrapVC.navigationController popViewControllerAnimated:YES];
//    if ([self.navigationController.parentViewController isKindOfClass:[WrapViewController class]]) {
//        WrapViewController* wrapVC = (WrapViewController*)self.navigationController.parentViewController;
//        [wrapVC.navigationController popViewControllerAnimated:YES];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickNext
{
//用容器wrap的隐藏导航栏push
    
    BaseViewController * baseVC = [[BaseViewController alloc]init];
    [self.wrapVC.navigationController pushViewController:baseVC animated:YES];
//    if ([self.navigationController.parentViewController isKindOfClass:[WrapViewController class]]) {
//        WrapViewController* wrapVC = (WrapViewController*)self.navigationController.parentViewController;
//        [wrapVC.navigationController pushViewController:baseVC animated:YES];
//    }
}
- (void)closeGester
{
    [self.wrapVC.view removeGestureRecognizer:self.wrapVC.pangester];
    
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
