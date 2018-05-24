//
//  BottomCollectonViewController.h
//  test
//
//  Created by zzy on 2018/5/22.
//  Copyright © 2018年 zzy. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, ScrollType) {
    ScrollTypeStart = 0,
    ScrollTypeEnd = 1
};

@class BottomCollectonViewController;
@protocol BottomCollectonViewControllerDelegate<NSObject>
@optional
- (void)collectionScrollWithType:(ScrollType)type withCount:(NSInteger)count;

@end



@interface BottomCollectonViewController : BaseViewController
@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,assign)CGSize itemSize;
@property(nonatomic,assign)BOOL canScroll;
@property(nonatomic,weak)id<BottomCollectonViewControllerDelegate> delegate;

- (void)setPageIndex:(NSInteger)count;
@end
