//
//  GAIATabCollectionViewController.m
//  GAIATabPageViewController
//
//  Created by 村田 宗一朗 on 2014/10/02.
//  Copyright (c) 2014年 murataGaia. All rights reserved.
//


#import "GAIATabCollectionViewController.h"

@interface GAIATabCollectionViewController ()

@property (strong, nonatomic) UICollectionView *tabCollectionViewController;

@property NSUInteger currentTab;

@end

#pragma mark - View Life Cycle
@implementation GAIATabCollectionViewController

const int kCollectionViewSection = 0;
const int kFirstSelectTab = 0;
const float kLineWidth = 0.5f;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTab = kFirstSelectTab;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self drawTopLine];
    [self drawUnderLine];
    //rayout Setting
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    //margin = 0
    myLayout.minimumLineSpacing = 0;
    myLayout.minimumInteritemSpacing = 0;
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.tabCollectionViewController setCollectionViewLayout:myLayout];
    
    self.tabCollectionViewController = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:myLayout];
    self.tabCollectionViewController.delegate = self;
    self.tabCollectionViewController.dataSource = self;
    [self.tabCollectionViewController setShowsHorizontalScrollIndicator:NO];
    [self.tabCollectionViewController setShowsVerticalScrollIndicator:NO];
    self.tabCollectionViewController.backgroundColor = [UIColor whiteColor];
    
    [self.delegate tabViewCollectionViewRegisterCell:self.tabCollectionViewController];
    
    [self.view addSubview:self.tabCollectionViewController];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.tabCollectionViewController scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:kFirstSelectTab inSection:kCollectionViewSection]
                                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public Method

- (void)selectTab:(NSIndexPath *)indexPath animation:(BOOL)animation
{
    [self.tabCollectionViewController scrollToItemAtIndexPath:indexPath
                                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                     animated:animation];
    self.currentTab = indexPath.row;
    
    [self.tabCollectionViewController reloadData];
}

#pragma mark - Private Method
- (void)drawTopLine
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.view.frame.size.width,
                                                              kLineWidth)];
    
    border.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    border.layer.zPosition = 101;
    [self.view addSubview:border];
}

- (void)drawUnderLine
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              self.view.frame.size.height - kLineWidth,
                                                              self.view.bounds.size.width,
                                                              kLineWidth)];
    
    border.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    border.layer.zPosition = 101;
    [self.view addSubview:border];
}




#pragma mark - UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.tabsArray count];
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.currentTab) {
        return [self.delegate tabViewCollectionView:collectionView
                     selectedCellForItemAtIndexPath:indexPath];
    }
    
    return [self.delegate tabViewCollectionView:collectionView
                         cellForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionView Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForHeaderInSection:(NSInteger)section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return [self.delegate tabViewCollectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                referenceSizeForFooterInSection:(NSInteger)section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate tabViewCollectionView:collectionView
                                         layout:collectionViewLayout
                         sizeForItemAtIndexPath:indexPath];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //tab cell center
    [self.tabCollectionViewController scrollToItemAtIndexPath:indexPath
                                             atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                     animated:YES];
    self.currentTab = indexPath.row;
    
    //Delegate select tab Index
    [self.delegate tabCollectionViewControllerDidSelectTab:indexPath];
    [self.tabCollectionViewController reloadData];
}

@end

