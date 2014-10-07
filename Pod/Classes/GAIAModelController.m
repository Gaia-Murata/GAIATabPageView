//
//  GAIAModelController.m
//  GAIATabPageViewController
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//

#import "GAIAModelController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface GAIAModelController ()

@end

@implementation GAIAModelController

#pragma mark - View Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (GAIADataViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    if (([self.tabsArray count] == 0) || (index >= [self.tabsArray count])) {
        return nil;
    }
    
    //delegate return GAIADataViewController
    GAIADataViewController *dataViewController  = [self.delegate modelViewControllerAtIndex:index];
    dataViewController.dataObject = self.tabsArray[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(GAIADataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.tabsArray indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(GAIADataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        [self.delegate modelControllerDidSelectPage:0];

        return nil;
    }
    
    self.currentIndex = index;
    [self.delegate modelControllerDidSelectPage:index];
    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(GAIADataViewController *)viewController];

    if (index == NSNotFound) {
        return nil;
    }
    
    self.currentIndex = index;
    [self.delegate modelControllerDidSelectPage:index];

    index++;
    if (index == [self.tabsArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
