//
//  GAIAViewController.m
//  GAIATabPageView
//
//  Created by Gaia-Murata on 10/07/2014.
//  Copyright (c) 2014 Gaia-Murata. All rights reserved.
//

#import "GAIAViewController.h"
#import "GAIADemoPageViewController.h"

@interface GAIAViewController ()

@property (copy, nonatomic) NSArray *tabsArray;
@property (strong, nonatomic) GAIATabPageView *tabPageRootViewController;
@property float firstCellWidth;
@property float lastCellWidth;

@end

@implementation GAIAViewController

const int kTabViewWidthMargin = 12;
const int kCurrentViewMarkHeightMargin  = 5;
const int kCurrentViewMarkWidthMargin   = 10;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tabsArray = @[@"Tab1", @"Tab2", @"Tab3"];
    self.tabPageRootViewController = [GAIATabPageView new];
    //Current Tab Color Setting
    
    self.tabPageRootViewController.delegate = self;
    [self.view addSubview:self.tabPageRootViewController.view];
    self.tabPageRootViewController.view.frame = self.view.bounds;
    //Draw TabView
    [self.tabPageRootViewController drawTabview:self.tabsArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GAIATabPageViewDelegate
- (GAIADataViewController *)rootViewControllerAtIndex:(NSUInteger)index
{
    if (([self.tabsArray count] == 0) || (index >= [self.tabsArray count])) {
        return nil;
    }
    
    GAIADemoPageViewController *vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController"];
    return vc;
}

//通常のCEllを返す
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath {
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
    
    
    [cell.contentView addSubview:label];
    label.frame = CGRectMake(label.frame.origin.x,
                             self.view.frame.size.height / 2 - label.frame.size.height / 2,
                             label.frame.size.width + (kTabViewWidthMargin * 2),
                             label.frame.size.height);
    label.layer.zPosition = 2;
    
    return cell;
}

//選択済みのCEllを返す
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    [cell.contentView addSubview:label];
    label.frame = CGRectMake(label.frame.origin.x,
                             self.view.frame.size.height / 2 - label.frame.size.height / 2,
                             label.frame.size.width + (kTabViewWidthMargin * 2),
                             label.frame.size.height);
    label.layer.zPosition = 2;
    
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
    
    return cell;
}

//Header のサイズを返す
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.firstCellWidth / 2), 44);
    return headerSize;

}

//Footerのサイズを返す
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
    CGSize footerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.lastCellWidth / 2), 44);
    return footerSize;

}

//Cellを登録する
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)tabCollectionView {

    [tabCollectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [tabCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [tabCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
}

//Cellのサイズを返す
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
