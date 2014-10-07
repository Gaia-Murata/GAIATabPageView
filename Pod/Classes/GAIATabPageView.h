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
#import "GAIAModelController.h"
#import "GAIADataViewController.h"
#import "GAIATabCollectionViewController.h"

@class GAIATabPageView;

@protocol GAIATabPageViewDelegate <NSObject>

/**
 * rootViewControllerAtIndex
 * viewController of index return
 *
 * @param index Index of Page transition
 * @return GAIADataViewController
 */
- (GAIADataViewController *)rootViewControllerAtIndex:(NSUInteger)index;

/**
 * tabViewCollectionViewcellForItemIndexPath
 * tabViewCollectionViewcellForItemIndexPathCurrentTab
 *
 * cell make
 */
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath;
/**
 * Header Footer Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section;

/**
 * register cell
 */
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)tabCollectionView;

/**
 * cell Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface GAIATabPageView : UIViewController <UIPageViewControllerDelegate, GAIATabCollectionViewControllerDelegate, GAIAModelControllerDelegate>

@property (weak, nonatomic) id<GAIATabPageViewDelegate> delegate;
//NSArray Array for tabs make
@property (copy, nonatomic) NSArray *tabsArray;

/**
 * drawTabView
 *
 * @param tabs 
 */
- (void)drawTabview:(NSArray *)tabs;

/**
 * selectPage
 * The transition to the Page that you specify
 * 
 * @param row Page you want to view
 */
- (void)selectPage:(int)row;

@end

