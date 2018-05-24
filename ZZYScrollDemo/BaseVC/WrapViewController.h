//
//  BaseViewController.h
//  test
//
//  Created by zzy on 16/12/28.
//  Copyright © 2016年 zzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WrapViewController : UIViewController
+(instancetype)baseSetNavigation:(UIViewController*)BaseVC;
@property(nonatomic,strong)UIPanGestureRecognizer* pangester;
@end
