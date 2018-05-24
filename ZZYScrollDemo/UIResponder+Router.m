//
//  UIResponder+Router.m
//  test
//
//  Created by zzy on 2018/5/18.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)
-(void)routerWithName:(NSString *)name withObjt:(id)obj
{
    [self.nextResponder routerWithName:name withObjt:obj];
}
@end
