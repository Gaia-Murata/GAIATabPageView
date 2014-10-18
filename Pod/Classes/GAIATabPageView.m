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

@property (strong, nonatomic) UIScrollView *pageScrollView;
@property (readonly, strong, nonatomic) GAIATabCollectionViewController *tabCollectionViewController;
@property NSInteger currentPage;
@property CGFloat tabViewHeight;
@property BOOL isTabSelectScroll;

@end

@implementation GAIATabPageView

//const

@synthesize tabCollectionViewController = _tabCollectionViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public Method
- (void)drawTabview:(NSMutableArray *)tabs tabViewHeight:(CGFloat)tabViewHeight;
{
    self.tabCollectionViewController.delegate = self;
    
    self.tabsArray = tabs;
    self.tabViewHeight = tabViewHeight;
    
    [self setupPageViewController];
    [self setupTabView];
}

- (void)selectPage:(int)index
{
    self.isTabSelectScroll = YES;
    self.currentPage = index;
    CGPoint offset;
    offset.x = self.view.frame.size.width * index;
    offset.y = 0;
    [self.pageScrollView setContentOffset:offset animated:YES];
}

- (void)tabAdd:(NSString *)newTabName
{
    [self.tabsArray addObject:newTabName];
    [self.tabCollectionViewController.tabCollectionViewController reloadData];
    
}

#pragma mark - Private Method

- (void)setupPageViewController
{
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.currentPage = 1;
    self.isTabSelectScroll = NO;
    
    
    CGSize s = self.view.frame.size;
    CGRect contentRect = CGRectMake(0,
                                    self.tabViewHeight,
                                    s.width * [self.tabsArray count],
                                    s.height);
    UIView *contentView = [[UIView alloc] initWithFrame:contentRect];
    
    NSInteger index;
    for (index = 0; index < [self.tabsArray count]; index++) {
        
        UIViewController *pageViewController = [self.delegate tabViewPageUIViewControllerAtIndex:index];
        
        [self addChildViewController:pageViewController];
        [contentView addSubview:pageViewController.view];
        [pageViewController didMoveToParentViewController:self];
        
        pageViewController.view.frame = CGRectMake(self.view.frame.size.width * index,
                                                   self.view.frame.origin.y,
                                                   self.view.frame.size.width,
                                                   self.view.frame.size.height);
        
        
    }
    
    [self.pageScrollView addSubview:contentView];
    self.pageScrollView.contentSize = contentView.frame.size;
    
    self.pageScrollView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:self.pageScrollView];
    
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

- (GAIATabCollectionViewController *)tabCollectionViewController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_tabCollectionViewController) {
        _tabCollectionViewController = [[GAIATabCollectionViewController alloc] init];
    }
    _tabCollectionViewController.tabsArray = [self tabsArray];
    
    return _tabCollectionViewController;
}

#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.isTabSelectScroll) {
        return;
    }
    
    CGPoint offset = self.pageScrollView.contentOffset;
    int page = (offset.x + self.view.frame.size.width / 2)/ self.view.frame.size.width;
    
    if (self.currentPage != page) {
        [self.tabCollectionViewController selectTab:[NSIndexPath indexPathForRow:page inSection:0] animation:YES];
        self.currentPage = page;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isTabSelectScroll = NO;
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

//register cell
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)collectionView {
    [self.delegate tabViewCollectionViewRegisterCell:collectionView];
}

//tabcollection view custom
- (void)tabViewCollectionViewCustom:(UICollectionView *)collectionView {
    [self.delegate tabViewCollectionViewCustom:collectionView];
}

@end
