//
//  WYNEWsBaseNavigationViewController.m
//  test
//
//  Created by zzy on 16/12/27.
//  Copyright © 2016年 zzy. All rights reserved.
//

#import "WYNEWsBaseNavigationViewController.h"
#import "WrapViewController.h"



@interface WYNEWsBaseNavigationViewController ()

@end

@implementation WYNEWsBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init]) {
        ///*方法一
        UIView* backView = [UIView new];
        backView.backgroundColor = [UIColor redColor];
        [self.navigationBar setValue:backView forKey:@"backgroundView"];
        //*/
        /*方法二
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        UIView * backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        backView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.navigationBar insertSubview:backView1 atIndex:0];
        backView1.backgroundColor = [UIColor redColor];
        //*/
//        self.navigationBar.backgroundColor = [UIColor redColor];
//        self.navigationBar.tintColor = [UIColor redColor];
//        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        self.navigationBar.barStyle=UIBarStyleBlackTranslucent;
//        self.navigationBar.translucent = NO;
//        self.view.backgroundColor = [UIColor redColor];
//        rootViewController.navigationController.navigationBar.tintColor = [UIColor redColor];
//        rootViewController.navigationController.navigationBar.backgroundColor = [UIColor redColor];
        self.viewControllers = @[rootViewController];
    }
    return self;
}
-(void)pushViewController:(id)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        WrapViewController * wrapVC = [WrapViewController baseSetNavigation:viewController];
        [super pushViewController:wrapVC animated:YES];
    }
    else
    {
        [super pushViewController:viewController animated:YES];
    }
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
