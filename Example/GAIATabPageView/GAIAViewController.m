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

@property (strong, nonatomic) NSMutableArray *tabsArray;
@property (strong, nonatomic) GAIATabPageView *tabPageRootViewController;
@property float firstCellWidth;
@property float lastCellWidth;

@end

@implementation GAIAViewController

const int kTabViewCellHeigth = 44;
const int kTabViewWidthMargin = 12;
const int kCurrentViewMarkHeightMargin  = 5;
const int kCurrentViewMarkWidthMargin   = 10;
const float kLineWidth = 0.5f;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tabsArray = [@[@"FLAMINGO", @"HONY FLOWER", @"ROYAL", @"EUCALYPTUS", @"SAND STORM"] mutableCopy];
    self.tabPageRootViewController = [GAIATabPageView new];
    //Current Tab Color Setting
    
    self.tabPageRootViewController.delegate = self;
    [self.view addSubview:self.tabPageRootViewController.view];
    self.tabPageRootViewController.view.frame = self.view.bounds;
    [self.tabPageRootViewController drawTabview:self.tabsArray tabViewHeight:kTabViewCellHeigth];
}

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)drawTopLine:(CGRect)collectionViewFrame
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.view.frame.size.width,
                                                              kLineWidth)];
    
    border.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    border.layer.zPosition = 101;
    [self.view addSubview:border];
}

- (void)drawUnderLine:(CGRect)collectionViewFrame
{
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              collectionViewFrame.size.height - kLineWidth,
                                                              self.view.frame.size.width,
                                                              kLineWidth)];
    
    border.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    border.layer.zPosition = 101;
    [self.view addSubview:border];
}


#pragma mark - GAIATabPageViewDelegate
/////////////////PagingSetting
- (UIViewController *)tabViewPageUIViewControllerAtIndex:(NSUInteger)index
{
    if (([self.tabsArray count] == 0) || (index >= [self.tabsArray count])) {
        return nil;
    }
    GAIADemoPageViewController *vc;
    
    if (index == 0) {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController1"];
    } else if (index == 1) {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController2"];
    } else if (index == 2) {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController3"];
    } else if (index == 3) {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController4"];
    } else if (index == 4) {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController5"];
    } else {
        vc = (GAIADemoPageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GAIADemoPageViewController1"];
    }
    
    return vc;
}

////////////////Tab Setting
//TabCell
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                        cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  tabViewFrame:(CGRect)frame {
    
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
                             frame.size.height / 2 - label.frame.size.height / 2,
                             label.frame.size.width + (kTabViewWidthMargin * 2),
                             label.frame.size.height);
    label.layer.zPosition = 2;
    
    return cell;
}

//CurrentTabCell
- (UICollectionViewCell*)tabViewCollectionView:(UICollectionView *)collectionView
                selectedCellForItemAtIndexPath:(NSIndexPath *)indexPath
                                  tabViewFrame:(CGRect)frame {
    
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
                             frame.size.height / 2 - label.frame.size.height / 2,
                             label.frame.size.width + (kTabViewWidthMargin * 2),
                             label.frame.size.height);
    label.layer.zPosition = 2;
    
    UIView *currentView = [[UIView alloc] init];
    currentView.backgroundColor = [UIColor colorWithRed:149.0f / 255.0f green:165.0f / 255.0f blue:166.0f / 255.0f alpha:1.0f];
    [cell.contentView addSubview:currentView];
    currentView.frame = CGRectMake(kTabViewWidthMargin - kCurrentViewMarkWidthMargin,
                                   frame.size.height / 2 - (label.frame.size.height / 2 + kCurrentViewMarkHeightMargin),
                                   label.frame.size.width - (kTabViewWidthMargin * 2) + (kCurrentViewMarkWidthMargin * 2),
                                   label.frame.size.height + (kCurrentViewMarkHeightMargin * 2));
    currentView.layer.cornerRadius = currentView.frame.size.height / 2.0f;
    currentView.clipsToBounds = true;
    currentView.layer.zPosition = 1;
    label.textColor = [UIColor whiteColor];
    
    return cell;
}

//Tab Left(Header) Size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
                   tabViewFrame:(CGRect)frame {
    CGSize headerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.firstCellWidth / 2), frame.size.height);
    return headerSize;
    
}

//Tab Right(Footer) Size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
                   tabViewFrame:(CGRect)frame {
    CGSize footerSize = CGSizeMake((self.view.frame.size.width / 2) - (self.lastCellWidth / 2), frame.size.height);
    return footerSize;
    
}

//Tab Size
- (CGSize)tabViewCollectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         sizeForItemAtIndexPath:(NSIndexPath *)indexPath
                   tabViewFrame:(CGRect)frame {
    
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
    
    return CGSizeMake(label.frame.size.width + (kTabViewWidthMargin * 2), frame.size.height);
    
}

//TabCell Register
- (void)tabViewCollectionViewRegisterCell:(UICollectionView *)tabCollectionView {
    
    [tabCollectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [tabCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [tabCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
}

////TabBackGroundView
- (void)tabViewCollectionViewCustom:(UICollectionView *)collectionView
{
    collectionView.backgroundColor = [UIColor whiteColor];

    [self drawTopLine:collectionView.frame];
    [self drawUnderLine:collectionView.frame];\
    
}

- (IBAction)tabAdd:(id)sender {
    [self.tabPageRootViewController tabAdd:@"ADD TAB"];
}


@end
