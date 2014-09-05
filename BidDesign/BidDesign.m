//
//  BidDesign.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-13.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "BidDesign.h"
#import "ToDoView.h"
@interface BidDesign ()

@end

@implementation BidDesign

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl

- (void)viewDidLoad

{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    ToDoView *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (ToDoView *)viewControllerAtIndex:(NSUInteger)index {
    //*****manipulate what will happen
    ToDoView *childViewController = [[ToDoView alloc] initWithNibName:@"ToDoView" bundle:nil];
    childViewController.index = index;
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ToDoView *)viewController index];
    
    
    if (index == 0) {
        return nil;
    }
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ToDoView *)viewController index];
    
    index++;
    
    
    if (index == 2) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
