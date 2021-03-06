//
//  GAIATabPageView.h
//  GAIATabPageView
//
//  This class manages and Tab Page.
//  I refer to the PagingSample of Apple.
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAIATabPageView;

@protocol GAIATabPageViewDelegate <NSObject>

/**
 * rootViewControllerAtIndex
 * viewController of index return
 *
 * @param index Index of Page transition
 * @return GAIADataViewController
 */
- (UIViewController *)tabViewPageUIViewControllerAtIndex:(NSUInteger)index;

/**
 * tabViewCollectionViewcellForItemIndexPath
 * tabViewCollectionViewcellForItemIndexPathCurrentTab
 *
 * cell make
 */
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  tabViewFrame:(CGRect)frame;

- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  tabViewFrame:(CGRect)frame;

/**
 * Header Footer Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
                   tabViewFrame:(CGRect)frame;
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
                   tabViewFrame:(CGRect)frame;

/**
 * cell Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath
                   tabViewFrame:(CGRect)frame;

/**
 * register cell
 */
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)collectionView;

/**
 * uicollectionview custom
 */
- (void)tabViewCollectionViewCustom:(UICollectionView *)collectionView;

@end


@interface GAIATabPageView : UIViewController <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id<GAIATabPageViewDelegate> delegate;
//NSArray Array for tabs make
@property (weak, nonatomic) NSMutableArray *tabsArray;

/**
 * drawTabView
 *
 * @param tabs 
 */
- (void)drawTabview:(NSMutableArray *)tabs tabViewHeight:(CGFloat)tabViewHeight;

/**
 * selectPage
 * The transition to the Page that you specify
 * 
 * @param row Page you want to view
 */
- (void)selectPage:(int)row;

/**
 * addTab
 * add tab 
 *
 */
- (void)tabAdd:(NSString *)newTabName;

@end

