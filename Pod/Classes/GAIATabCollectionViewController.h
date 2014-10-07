//
//  GAIATabCollectionViewController.h
//  GAIATabPageViewController
//
//  Class of Tab
//  I have been implemented in UICollectionViewController
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAIATabCollectionViewController;

@protocol GAIATabCollectionViewControllerDelegate <NSObject>

/**
 * tabCollectionViewControllerDidSelectTab
 * The Delegate when you Tap the Tab
 *
 * @param indexPath IndexPath of Tab that tap
 */
- (void)tabCollectionViewControllerDidSelectTab:(NSIndexPath *)indexPath;

//todo register cell

/**
 * tabViewCollectionViewcellForItemIndexPath
 * tabViewCollectionViewcellForItemIndexPathCurrentTab
 *
 * cell make
 */
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                 selfViewframe:(CGRect)frame;

- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath
                                 selfViewframe:(CGRect)frame;
/**
 * Header Footer Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
                  selfViewframe:(CGRect)frame;

- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
                  selfViewframe:(CGRect)frame;

/**
 * register cell
 */
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)tabCollectionView;

/**
 * cell Size Delegate
 */
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath
                  selfViewframe:(CGRect)frame;


@end

@interface GAIATabCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 * selectTabAnimation
 * to transition by selecting the tab
 *
 * @param indexPath IndexPath of Tab you want to transition
 */
- (void)selectTab:(NSIndexPath *)indexPath animation:(BOOL)animation;

//List of tab
@property (copy, nonatomic) NSArray *tabsArray;
@property (weak, nonatomic) id<GAIATabCollectionViewControllerDelegate> delegate;

@end
