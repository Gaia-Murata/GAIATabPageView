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

@end

@implementation GAIAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tabsArray = @[@"Tab1", @"Tab2", @"Tab3"];
    
    self.tabPageRootViewController = [GAIATabPageView new];
    self.tabPageRootViewController.delegate = self;
    [self.view addSubview:self.tabPageRootViewController.view];
    self.tabPageRootViewController.view.frame = self.view.bounds;
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


@end
