//
//  GAIAModelController.h
//  GAIATabPageViewController
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAIADataViewController.h"

@class GAIAModelController;

@protocol GAIAModelControllerDelegate <NSObject>

/**
 * modelControllerDidSelectPage
 * Page transition delegate
 *
 * @param index Index of Page transition
 */
- (void)modelControllerDidSelectPage:(NSInteger)index;

/**
 * modelViewControllerAtIndex
 * viewController of index return
 *
 * @param index Index of Page transition
 * @return GAIADataViewController
 */
- (GAIADataViewController *)modelViewControllerAtIndex:(NSUInteger)index;

@end

@class GAIADataViewController;

@interface GAIAModelController : NSObject <UIPageViewControllerDataSource>

@property (copy, nonatomic) NSArray *tabsArray;
@property (weak, nonatomic) id<GAIAModelControllerDelegate> delegate;
@property NSUInteger currentIndex;

- (GAIADataViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(GAIADataViewController *)viewController;

@end

