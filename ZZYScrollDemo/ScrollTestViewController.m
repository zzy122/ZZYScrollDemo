//
//  ScrollTestViewController.m
//  test
//
//  Created by zzy on 2018/5/22.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "ScrollBaseTableView.h"
#import "BottomCollectonViewController.h"
#import "ZZYScrollDemo-Swift.h"
static NSString* identifier = @"cellIdentifier";
@interface ScrollTestViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,BottomCollectonViewControllerDelegate>
//@property(nonatomic,strong)UITableView* bottomTableView;
@property(nonatomic,strong)ScrollBaseTableView* topTableView;
//@property(nonatomic,strong)BottomTableViewController* bottvc;
@property(nonatomic,strong)UICollectionView* bottomCollectionView;
@property(nonatomic,strong)BottomCollectonViewController* bottomVC;

@property(nonatomic,strong)ITemScrollView* itemView;

@property(nonatomic,assign)BOOL canScroll;
@end

@implementation ScrollTestViewController

- (UICollectionView *)bottomCollectionView
{
    if (!_bottomCollectionView) {
        _bottomCollectionView = self.bottomVC.collectionView;
        
    }
    return _bottomCollectionView;
}
//- (BottomTableViewController *)bottvc
//{
//    if (!_bottvc) {
//        _bottvc = [BottomTableViewController new];
//        _bottvc.canScroll = NO;
//
//    }
//    return _bottvc;
//}
- (BottomCollectonViewController *)bottomVC
{
    if (!_bottomVC) {
        _bottomVC = [BottomCollectonViewController new];
        _bottomVC.delegate = self;
        _bottomVC.itemSize = CGSizeMake(CGRectGetWidth(self.topTableView.frame), ScreenHeight - 64-80);
       
    }
    return _bottomVC;
}

- (UITableView *)topTableView
{
    if (!_topTableView) {
        _topTableView = [[ScrollBaseTableView alloc]initWithFrame:self.view.bounds];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.alwaysBounceVertical = YES;
        [self.view addSubview:_topTableView];
    }
    return _topTableView;
}
- (void)viewDidLayoutSubviews
{
//    self.scrollView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view1 = [UIView new];
    view1.frame =CGRectMake(0, 0, CGRectGetWidth(self.topTableView.frame), 300);
    view1.backgroundColor = [UIColor greenColor];
    self.topTableView.tableHeaderView = view1;
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerTag) name:@"leaveTop" object:nil];
    // Do any additional setup after loading the view.
}
- (void)observerTag{
    self.canScroll = YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        self.bottomCollectionView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64-80);
        [cell.contentView addSubview:self.bottomCollectionView];
    }
//    cell.textLabel.text = @"测试";
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.itemView = [[ITemScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50) dataAry:@[@"SDK开发计算",@"思考贷款",@"惊世毒妃好看看",@"就安静点卡卡卡卡所说的"] back:^(NSInteger index) {
        [self.bottomVC setPageIndex:index];
        DebugLog(@"点击了%ld",(long)index);
    }];
    return self.itemView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DebugLog(@"baseScrollView%f",scrollView.contentOffset.y);
    CGFloat contentY = [_topTableView rectForSection:0].origin.y;
    if (scrollView.contentOffset.y >= 300) {
        if (self.canScroll) {
            self.canScroll = NO;
        }
        self.bottomVC.canScroll = YES;
    }
    else
    {
        if (!self.canScroll) {
            self.topTableView.contentOffset = CGPointMake(0, contentY);
        }
    }
}
- (void)collectionScrollWithType:(ScrollType)type withCount:(NSInteger)count
{
    
    switch (type) {
        case ScrollTypeStart:
            self.topTableView.scrollEnabled = NO;
            
            break;
        default:
            self.topTableView.scrollEnabled = YES;
            [self.itemView setItemtargetWithIndex:count];
            
            DebugLog(@"滑动collection位置%ld",(long)count);
            break;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
