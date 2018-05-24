//
//  BottomCollectonViewController.m
//  test
//
//  Created by zzy on 2018/5/22.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "BottomCollectonViewController.h"
#import "ScrollBaseCollectionViewCell.h"
#import "ZZYScrollDemo-Swift.h"
static NSString* headerStr = @"headerIdentifier";
static NSString* cellStr = @"collectionCell";
@interface BottomCollectonViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation BottomCollectonViewController
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.itemSize;
        layout.minimumLineSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0.0;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerStr];//collectionView的sectionHeader
        [_collectionView registerClass:[ScrollBaseCollectionViewCell class] forCellWithReuseIdentifier:cellStr];
        
    }
    return _collectionView;
}
- (void)setCanScroll:(BOOL)canScroll
{
    _canScroll = canScroll;
    NSArray* cells = [self.collectionView visibleCells];
    
    for (ScrollBaseCollectionViewCell* cell in cells) {
        cell.canScroll = _canScroll;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScrollBaseCollectionViewCell* cell = (ScrollBaseCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    if (!cell) {
        cell = [[ScrollBaseCollectionViewCell alloc]init];
    }
    cell.canScroll = NO;
    return cell;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView* resuview = (UICollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerStr forIndexPath:indexPath];
//    resuview.backgroundColor = [UIColor blueColor];
//    resuview.frame = CGRectMake(0, 0, ScreenWidth, 80);
//    return resuview;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return  CGSizeMake(ScreenWidth, 80);
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger interg = [self getCurrentCount:scrollView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionScrollWithType:withCount:)]) {//collection开始华东时主tableview不能滑动
        [self.delegate collectionScrollWithType:ScrollTypeStart withCount:interg];
    }
}

- (NSInteger)getCurrentCount:(UIScrollView*)scrollView
{
   
    
    CGFloat x = scrollView.contentOffset.x;
    
   
    
    NSInteger interg = x / ScreenWidth;
    NSInteger yushu = (NSInteger)x % (NSInteger)ScreenWidth;
    if (yushu > ScreenWidth / 2.0) {
        interg ++;
    }

    return interg;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger interg = [self getCurrentCount:scrollView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionScrollWithType:withCount:)]) {//collection结束滑动时候主tableview能滑动
        [self.delegate collectionScrollWithType:ScrollTypeEnd withCount:interg];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger interg = [self getCurrentCount:scrollView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionScrollWithType:withCount:)]) {//collection结束滑动时候主tableview能滑动
        [self.delegate collectionScrollWithType:ScrollTypeEnd withCount:interg];
    }
}
- (void)setPageIndex:(NSInteger)count
{
    [self.collectionView setContentOffset:CGPointMake(self.itemSize.width * count, 0) animated:YES];
    ScrollBaseCollectionViewCell* cell = (ScrollBaseCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0]];
    [cell setCanScroll:YES];
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
