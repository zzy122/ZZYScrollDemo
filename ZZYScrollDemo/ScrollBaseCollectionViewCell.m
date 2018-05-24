//
//  ScrollBaseCollectionViewCell.m
//  test
//
//  Created by zzy on 2018/5/22.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "ScrollBaseCollectionViewCell.h"
#import "ZZYScrollDemo-Swift.h"

@interface ScrollBaseCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@end


@implementation ScrollBaseCollectionViewCell

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (void)layoutSubviews
{
    self.tableView.hidden = NO;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.tableView.hidden = NO;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"subCell"];
    }
    
    cell.textLabel.text = @"collection测试";
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    DebugLog(@"subscrollView%f",scrollView.contentOffset.y);
    if (!_canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [self routerWithName:@"leaveTop" withObjt:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }
}
@end
