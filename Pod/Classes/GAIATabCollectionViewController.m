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

@property float firstCellWidth;
@property float lastCellWidth;
@property NSUInteger currentTab;

@end

#pragma mark - View Life Cycle
@implementation GAIATabCollectionViewController

const int kTabViewWidthMargin = 12;
const int kCollectionViewSection = 0;
const int kFirstSelectTab = 0;
const int kCurrentViewMarkHeightMargin = 5;
const int kCurrentViewMarkWidthMargin   = 10;

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
 
    //rayout Setting
    UICollectionViewFlowLayout *myLayout = [[UICollectionViewFlowLayout alloc] init];
    myLayout.itemSize = CGSizeMake(200, self.view.frame.size.height);
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

    
    [self.tabCollectionViewController registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.tabCollectionViewController registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.tabCollectionViewController registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];

    
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
- (void)cellSetup:(UICollectionViewCell *)cell {
}

#pragma mark - UICollectionView DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.tabsArray count];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    //todo CellClass
    NSString *cellId = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
    label.text = self.tabsArray[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];

    //todo CellClass
    cell.backgroundColor = [UIColor whiteColor];

    
    [self cellSetup:cell];
    [cell.contentView addSubview:label];
    label.frame = CGRectMake(label.frame.origin.x,
                             self.view.frame.size.height / 2 - label.frame.size.height / 2,
                             label.frame.size.width + (kTabViewWidthMargin * 2),
                             label.frame.size.height);
    label.layer.zPosition = 2;
    
    if (indexPath.row == self.currentTab) {
        UIView *currentView = [[UIView alloc] init];
        currentView.backgroundColor = [UIColor blueColor];
        [cell.contentView addSubview:currentView];
        currentView.frame = CGRectMake(kTabViewWidthMargin - kCurrentViewMarkWidthMargin,
                                       self.view.frame.size.height / 2 - (label.frame.size.height / 2 + kCurrentViewMarkHeightMargin),
                                       label.frame.size.width - (kTabViewWidthMargin * 2) + (kCurrentViewMarkWidthMargin * 2),
                                       label.frame.size.height + (kCurrentViewMarkHeightMargin * 2));
        currentView.layer.cornerRadius = currentView.frame.size.height / 2.0f;
        currentView.clipsToBounds = true;
        currentView.layer.zPosition = 1;
        label.textColor = [UIColor whiteColor];
        
    }
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)aCollectionView
                        layout:(UICollectionViewFlowLayout *)aCollectionViewLayout
        insetForSectionAtIndex:(NSInteger)aSection
{
    CGFloat margin = (aCollectionViewLayout.minimumLineSpacing / 2);
    // top, left, bottom, right
    UIEdgeInsets myInsets = UIEdgeInsetsMake(0, margin, 0, margin);
    
    return myInsets;
}

#pragma mark - UICollectionView Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.firstCellWidth / 2), 44);
    return headerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize footerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.lastCellWidth / 2), 44);
    return footerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
    label.text = self.tabsArray[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    if (indexPath.row == 0) {
        self.firstCellWidth = label.frame.size.width + kTabViewWidthMargin * 2;
    }
    
    if (indexPath.row == [self.tabsArray count] - 1) {
        self.lastCellWidth  = label.frame.size.width + kTabViewWidthMargin * 2;
    }
    
    return CGSizeMake(label.frame.size.width + (kTabViewWidthMargin * 2), self.view.frame.size.height);
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

