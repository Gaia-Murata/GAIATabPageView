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
- (void)drawTabview:(NSArray *)tabs tabViewHeight:(CGFloat)tabViewHeight;
{
    self.tabCollectionViewController.delegate = self;
    
    self.tabsArray = tabs;
    self.tabViewHeight = tabViewHeight;
    
    [self setupPageViewController];
    [self setupTabView];
}

//- (void)selectPage:(int)index
//{
//    //If Reverse number of pages is less than the CurrentIndex
//    if (self.modelController.currentIndex > index) {
//        self.modelController.currentIndex = index;
//        GAIADataViewController *selectViewController = [self.modelController viewControllerAtIndex:index];
//        NSArray *viewControllers = @[selectViewController];
//        [self.pageScrollView setViewControllers:viewControllers
//                                          direction:UIPageViewControllerNavigationDirectionReverse
//                                           animated:YES
//                                         completion:nil];
//
//        //If Forword number of pages is greater than CurrentIndex
//    } else if(self.modelController.currentIndex < index) {
//        self.modelController.currentIndex = index;
//        GAIADataViewController *selectViewController = [self.modelController viewControllerAtIndex:index];
//
//        NSArray *viewControllers = @[selectViewController];
//        [self.pageViewController setViewControllers:viewControllers
//                                          direction:UIPageViewControllerNavigationDirectionForward
//                                           animated:YES
//                                         completion:nil];
//    }
//}

#pragma mark - Private Method

- (void)setupPageViewController
{
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    
    CGSize s = self.pageScrollView.frame.size;
    CGRect contentRect = CGRectMake(0,
                                    self.tabViewHeight,
                                    s.width * [self.tabsArray count],
                                    s.height);
    UIView *contentView = [[UIView alloc] initWithFrame:contentRect];

    NSInteger index;
    for (index = 0; index < [self.tabsArray count]; index++) {
        UIView *subContent1View = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * index,
                                                                           0,
                                                                           s.width,
                                                                           s.height)];
        subContent1View.backgroundColor = [UIColor greenColor];
        [contentView addSubview:subContent1View];
    }

    // スクロールViewにコンテンツViewを追加する。
    [self.pageScrollView addSubview:contentView];
    self.pageScrollView.contentSize = contentView.frame.size;
    
    // 初期表示するコンテンツViewの場所を指定します。
    self.pageScrollView.contentOffset = CGPointMake(0, 0);
    self.currentPage = 1;
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
    
    CGPoint offset = self.pageScrollView.contentOffset;
    int page = (offset.x + self.view.frame.size.width / 2)/ self.view.frame.size.width;
    
    if (self.currentPage != page) {
        [self.tabCollectionViewController selectTab:[NSIndexPath indexPathForRow:page inSection:0] animation:YES];
        self.currentPage = page;
    }
}


#pragma mark - TabCollectionView Delegate Methods
- (void)tabCollectionViewControllerDidSelectTab:(NSIndexPath *)indexPath
{
    //[self selectPage:(int)indexPath.row];
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

@end
