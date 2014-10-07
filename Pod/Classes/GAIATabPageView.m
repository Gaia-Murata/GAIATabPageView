//
//  GAIATabPageView.m
//  GAIATabPageView
//
//  This class manages and Tab Page.
//  I refer to the PagingSample of Apple.
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//

#import "GAIATabPageView.h"

@interface GAIATabPageView ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) GAIAModelController *modelController;
@property (readonly, strong, nonatomic) GAIATabCollectionViewController *tabCollectionViewController;
@property CGFloat tabViewHeight;

@end

@implementation GAIATabPageView

//const

@synthesize modelController = _modelController;
@synthesize tabCollectionViewController = _tabCollectionViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public Method
- (void)drawTabview:(NSArray *)tabs tabViewHeight:(CGFloat)tabViewHeight;
{
    self.tabCollectionViewController.delegate = self;
    self.modelController.delegate = self;
    
    self.tabsArray = tabs;
    self.tabViewHeight = tabViewHeight;
    
    [self setupPageViewController];
    [self setupTabView];
}

- (void)selectPage:(int)index
{
    //If Reverse number of pages is less than the CurrentIndex
    if (self.modelController.currentIndex > index) {
        self.modelController.currentIndex = index;
        GAIADataViewController *selectViewController = [self.modelController viewControllerAtIndex:index];
        NSArray *viewControllers = @[selectViewController];
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:nil];
        
        //If Forword number of pages is greater than CurrentIndex
    } else if(self.modelController.currentIndex < index) {
        self.modelController.currentIndex = index;
        GAIADataViewController *selectViewController = [self.modelController viewControllerAtIndex:index];
        
        NSArray *viewControllers = @[selectViewController];
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
    }
}

#pragma mark - Private Method

- (void)setupPageViewController
{
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    
    self.pageViewController.delegate = self;
    
    GAIADataViewController *startingViewController = [self.modelController viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)setupTabView
{
    
    self.tabCollectionViewController.view.frame = CGRectMake(0, 0,
                                                             self.view.frame.size.width,
                                                             self.tabViewHeight);
    
    [self addChildViewController:self.tabCollectionViewController];
    self.tabCollectionViewController.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tabCollectionViewController.view];
    
}

- (GAIAModelController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[GAIAModelController alloc] init];
    }
    _modelController.tabsArray = [self tabsArray];
    
    return _modelController;
}

- (GAIATabCollectionViewController *)tabCollectionViewController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_tabCollectionViewController) {
        _tabCollectionViewController = [[GAIATabCollectionViewController alloc] init];
    }
    _tabCollectionViewController.tabsArray = [self tabsArray];
    
    return _tabCollectionViewController;
}

#pragma mark - ModelController Delegate Methods
- (void)modelControllerDidSelectPage:(NSInteger)index
{
    [self.tabCollectionViewController selectTab:[NSIndexPath indexPathForRow:index inSection:0]
                                      animation:YES];
}

- (GAIADataViewController *)modelViewControllerAtIndex:(NSUInteger)index
{
    return [self.delegate rootViewControllerAtIndex:index];
}


#pragma mark - TabCollectionView Delegate Methods
- (void)tabCollectionViewControllerDidSelectTab:(NSIndexPath *)indexPath
{
    [self selectPage:(int)indexPath.row];
}

//cell
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath selfViewframe:(CGRect)frame
{
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                         cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                   tabViewFrame:frame];
    
}

//select cell
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath selfViewframe:(CGRect)frame {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                 selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath
                                   tabViewFrame:frame];
}

//header size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section selfViewframe:(CGRect)frame {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForHeaderInSection:(NSInteger)section
                                   tabViewFrame:frame];
}

//footer size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section selfViewframe:(CGRect)frame {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForFooterInSection:(NSInteger)section
                                   tabViewFrame:frame];
}

//cell size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath selfViewframe:(CGRect)frame {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout *)collectionViewLayout
                         sizeForItemAtIndexPath:(NSIndexPath *)indexPath
                                   tabViewFrame:frame];
    
}

- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)tabCollectionView {
    [self.delegate tabViewCollectionViewRegisterCell:tabCollectionView];
}


#pragma mark - UIPageViewController Delegate Methods
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (completed) {
        [self.tabCollectionViewController selectTab:[NSIndexPath indexPathForRow:self.modelController.currentIndex inSection:0] animation:YES];
    }
    
}


- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    GAIADataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    return UIPageViewControllerSpineLocationMid;
}

@end
