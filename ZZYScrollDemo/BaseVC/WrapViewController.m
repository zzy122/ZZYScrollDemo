//
//  BaseViewController.m
//  test
//
//  Created by zzy on 16/12/28.
//  Copyright © 2016年 zzy. All rights reserved.
//

#import "WrapViewController.h"
#import "PopAnimationTrans.h"
#import "WYNEWsBaseNavigationViewController.h"
#import "BaseViewController.h"
@interface WrapViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
//    BOOL flag;
}

@property(nonatomic,strong)PopAnimationTrans* transition;
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition* interactive;//滑动百分比
@end

@implementation WrapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.delegate = self;
    
//    UINavigationController* Nvc = [[UINavigationController alloc] init];
//    [Nvc setViewControllers:@[self]];
//    [self.view addSubview:Nvc.view];
//    [self addChildViewController:Nvc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setbackBtn];
    self.transition = [[PopAnimationTrans alloc]init];

    
    
    self.pangester = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveTouched:)];
    
    [self.view addGestureRecognizer:self.pangester];
    
    
    // Do any additional setup after loading the view.
}

- (void)moveTouched:(UIPanGestureRecognizer*)pan
{
    CGPoint point = [pan translationInView:self.view];
    static BOOL flag = NO;
//    NSLog(@"=====%@",NSStringFromCGPoint(point));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
            flag = NO;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!flag && point.x >0) {
                [self.navigationController popViewControllerAnimated:YES];
//                NSLog(@"开始");
                flag = YES;
            }
            else if (point.x > 0 && flag) {
                CGFloat present = point.x / CGRectGetWidth(self.view.frame);
//                NSLog(@"百分比：%f",present);
                [self.interactive updateInteractiveTransition:present];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGPoint speed = [pan velocityInView:self.view];
            CGFloat distance = fabs(speed.x)* 0.15;//0.15秒滑动的距离  用于判断快速的手势swip
            if (distance > CGRectGetWidth(self.view.frame)* 0.8 || point.x > CGRectGetWidth(self.view.frame) * 0.5) {
                [self.interactive finishInteractiveTransition];
                NSLog(@"快速");
            }
            else
            {
                [self.interactive cancelInteractiveTransition];
            }
            self.interactive = nil;
        }
            break;
        default:
            break;
    }
}
//-(UIPercentDrivenInteractiveTransition *)interactive
//{
//    if (!_interactive) {
//        _interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
//    }
//    return _interactive;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC == self && operation == UINavigationControllerOperationPop ) {
//        [navigationController setViewControllers:@[toVC]];
//        [fromVC.view addSubview:navigationController.view];
//        [fromVC addChildViewController:navigationController];
//        NSLog(@"2222=======");
        return self.transition;
        
    }
    return nil;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
//    NSLog(@"3333=======");

    return self.interactive;
}

+(instancetype)baseSetNavigation:(BaseViewController*)BaseVC
{
    WrapViewController* wrap = [[WrapViewController alloc]init];
    WYNEWsBaseNavigationViewController* nvc = [[WYNEWsBaseNavigationViewController alloc]init];
    [nvc setViewControllers:@[BaseVC]];
    
    [wrap.view addSubview:nvc.view];
    [wrap addChildViewController:nvc];
    [BaseVC setbackBtn];
    return wrap;
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
