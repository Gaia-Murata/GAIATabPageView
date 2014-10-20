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
@property (strong, nonatomic) UICollectionView *tabCollectionViewController;

@property NSInteger currentPage;
@property CGFloat tabViewHeight;
//Tab And Page Scroll ManageFlag
@property BOOL isTabSelectScroll;
//PageView
@property UIView *contentView;

@end

@implementation GAIATabPageView

const int kCollectionViewSection = 0;
const int kFirstSelectTab = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public Method
/**
 * drawTabView
 *
 * @param tabs
 * @param tabViewHeight
 */
- (void)drawTabview:(NSMutableArray *)tabs tabViewHeight:(CGFloat)tabViewHeight;
{
    self.tabsArray = tabs;
    self.tabViewHeight = tabViewHeight;
    self.currentPage = kFirstSelectTab;
    
    [self setupPageViewController];
    [self setupTabView];
}

/**
 * selectPage
 * The transition to the Page that you specify
 *
 * @param row Page you want to view
 */
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
    NSInteger index = [self.tabsArray count];
    [self.tabsArray addObject:newTabName];
    [self.tabCollectionViewController reloadData];
    
    [self addPageViewController:index];
    
}

#pragma mark - Private Method

- (void)setupPageViewController
{
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.isTabSelectScroll = NO;
    
    
    CGSize s = self.view.frame.size;
    CGRect contentRect = CGRectMake(0,
                                    self.tabViewHeight,
                                    s.width * [self.tabsArray count],
                                    s.height);
    self.contentView = [[UIView alloc] initWithFrame:contentRect];
    
    NSInteger index;
    for (index = 0; index < [self.tabsArray count]; index++) {
        
        UIViewController *pageViewController = [self.delegate tabViewPageUIViewControllerAtIndex:index];
        
        [self addChildViewController:pageViewController];
        [self.contentView addSubview:pageViewController.view];
        [pageViewController didMoveToParentViewController:self];
        
        pageViewController.view.frame = CGRectMake(self.view.frame.size.width * index,
                                                   self.view.frame.origin.y,
                                                   self.view.frame.size.width,
                                                   self.view.frame.size.height);
        
        
    }
    
    [self.pageScrollView addSubview:self.contentView];
    self.pageScrollView.contentSize = self.contentView.frame.size;
    
    self.pageScrollView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:self.pageScrollView];
    
}


- (void)addPageViewController:(NSInteger)index
{
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x,
                              self.contentView.frame.origin.y,
                              self.view.frame.size.width * [self.tabsArray count],
                              self.contentView.frame.size.height);
    
    UIViewController *pageViewController = [self.delegate tabViewPageUIViewControllerAtIndex:index];
    
    [self addChildViewController:pageViewController];
    [self.contentView addSubview:pageViewController.view];
    [pageViewController didMoveToParentViewController:self];
    
    pageViewController.view.frame = CGRectMake(self.view.frame.size.width * index,
                                               self.view.frame.origin.y,
                                               self.view.frame.size.width,
                                               self.view.frame.size.height);
    self.pageScrollView.contentSize = self.contentView.frame.size;
}


- (void)setupTabView
{
    CGRect tabViewRect = CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.tabViewHeight);

    //rayout Setting
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    //margin = 0
    myLayout.minimumLineSpacing = 0;
    myLayout.minimumInteritemSpacing = 0;
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.tabCollectionViewController = [[UICollectionView alloc] initWithFrame:tabViewRect collectionViewLayout:myLayout];
    self.tabCollectionViewController.delegate = self;
    self.tabCollectionViewController.dataSource = self;
    [self.tabCollectionViewController setShowsHorizontalScrollIndicator:NO];
    [self.tabCollectionViewController setShowsVerticalScrollIndicator:NO];
    self.tabCollectionViewController.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tabCollectionViewController];
    
    [self.delegate tabViewCollectionViewRegisterCell:self.tabCollectionViewController];
    [self.delegate tabViewCollectionViewCustom:self.tabCollectionViewController];    
}

#pragma mark - Public Method
- (void)selectTab:(NSIndexPath *)indexPath animation:(BOOL)animation
{
    [self.tabCollectionViewController scrollToItemAtIndexPath:indexPath
     
                                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                     animated:animation];
    self.currentPage = indexPath.row;
    
    [self.tabCollectionViewController reloadData];
}

#pragma mark - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.isTabSelectScroll) {
        return;
    }
    
    CGPoint offset = self.pageScrollView.contentOffset;
    int page = (offset.x + self.view.frame.size.width / 2)/ self.view.frame.size.width;
    
    if (self.currentPage != page) {
        [self selectTab:[NSIndexPath indexPathForRow:page inSection:kCollectionViewSection] animation:YES];
        self.currentPage = page;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isTabSelectScroll = NO;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.tabsArray count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect tabViewRect = CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.tabViewHeight);
    //Current Cell
    if (indexPath.row == self.currentPage) {
        return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                     selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath
                                       tabViewFrame:tabViewRect];
    }
    
    //Cell
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                         cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                   tabViewFrame:tabViewRect];
}

#pragma mark - UICollectionView Delegate
//Header Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGRect tabViewRect = CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.tabViewHeight);
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForHeaderInSection:(NSInteger)section
                                   tabViewFrame:tabViewRect];
}

//Footer Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    CGRect tabViewRect = CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.tabViewHeight);
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForFooterInSection:(NSInteger)section
                                   tabViewFrame:tabViewRect];
}

//Cell Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect tabViewRect = CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.tabViewHeight);
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout *)collectionViewLayout
                         sizeForItemAtIndexPath:(NSIndexPath *)indexPath
                                   tabViewFrame:tabViewRect];
    
}

//Select Tab
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self selectPage:(int)indexPath.row];
    //tab cell center
    [self.tabCollectionViewController scrollToItemAtIndexPath:indexPath
                                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                     animated:YES];
    self.currentPage = indexPath.row;
    
    //Delegate select tab Index
    [self.tabCollectionViewController reloadData];
}

@end
