//
//  FGSegmentedControlViewController.m
//  FGSegmentedControlViewController
//
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "FGSegmentedControlViewController.h"

#define ASSERT_INDEX_IS_WITHIN_BOUNDS(idx,array) NSAssert2(idx >= 0 && idx <= (self.array.count-1), @"index %d beyond bounds [0 .. %d]", idx, (self.array.count-1))

@interface FGSegmentedControlViewController ()
@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSMutableArray *childViewControllers;
@property (nonatomic, assign) NSInteger previouslySelectedIndex;
@property (nonatomic, assign, getter = isSwitchingViewControllers) BOOL switchingViewControllers;
@end

@implementation FGSegmentedControlViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
	self.childViewControllers = [NSMutableArray array];
	self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[@[ @"" ] mutableCopy]];
	self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	[self.segmentedControl sizeToFit];
	[self.segmentedControl addTarget:self action:@selector(viewControllerSelectionDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self setSelectedIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View Controller Management

- (void)setViewControllers:(NSArray *)viewControllers
{
	NSAssert(viewControllers != nil, @"viewControllers cannot be nil");
	for (UIViewController *viewController in viewControllers) {
		[self addChild:viewController];
	}
}

- (NSArray *)viewControllers
{
	return (NSArray *)self.childViewControllers;
}

#pragma mark - View Controller Selection

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
	NSAssert(selectedViewController != nil, @"selectedViewController cannot be nil");
	[self setSelectedIndex:[self.childViewControllers indexOfObject:selectedViewController]];
}

- (UIViewController *)selectedViewController
{
	return [self childViewControllerAtIndex:self.segmentedControl.selectedSegmentIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
	ASSERT_INDEX_IS_WITHIN_BOUNDS(selectedIndex,self.childViewControllers);
	self.segmentedControl.selectedSegmentIndex = selectedIndex;
	[self viewControllerSelectionDidChange:self];
}

- (NSUInteger)selectedIndex
{
	return self.segmentedControl.selectedSegmentIndex;
}

#pragma mark - Child View Controller Management

- (void)addChild:(UIViewController *)childViewController
{
	NSAssert(childViewController != nil, @"childViewController cannot be nil");
	// Remove placeholder empty segment if the segment being added is the first non-empty segment
	BOOL segmentedControlIsEmpty = ([[self.segmentedControl titleForSegmentAtIndex:0] isEqualToString:@""] && (self.segmentedControl.numberOfSegments == 1));
	if  (segmentedControlIsEmpty) {
		[self.segmentedControl removeAllSegments];
	}
	[self.segmentedControl insertSegmentWithTitle:childViewController.title atIndex:self.segmentedControl.numberOfSegments animated:NO];
	[self.childViewControllers addObject:childViewController];
}

- (void)insertChild:(UIViewController *)childViewController atIndex:(NSInteger)index
{
	NSAssert(childViewController != nil, @"childViewController cannot be nil");
	ASSERT_INDEX_IS_WITHIN_BOUNDS(index,self.childViewControllers);
	[self.childViewControllers insertObject:childViewController atIndex:index];
}

- (void)removeChildViewControllerAtIndex:(NSInteger)index
{
	ASSERT_INDEX_IS_WITHIN_BOUNDS(index,self.childViewControllers);
	[self.segmentedControl removeSegmentAtIndex:index animated:NO];
	[self.childViewControllers removeObjectAtIndex:index];
}

- (UIViewController *)childViewControllerAtIndex:(NSInteger)index
{
	ASSERT_INDEX_IS_WITHIN_BOUNDS(index,self.childViewControllers);
	UIViewController *childViewController = self.childViewControllers[index];
	return (childViewController != nil) ? childViewController : nil;
}

#pragma mark - View Controller Visibility

- (void)showChildViewControllerAtIndex:(NSInteger)index
{
	ASSERT_INDEX_IS_WITHIN_BOUNDS(index,self.childViewControllers);
	UIViewController *fromViewController = [self childViewControllerAtIndex:self.previouslySelectedIndex];
	UIViewController *toViewController = [self childViewControllerAtIndex:index];
	
	if ([self.delegate respondsToSelector:@selector(segmentedViewController:willSwitchFromViewController:atIndex:toViewController:atIndex:)]) {
		[self.delegate segmentedViewController:self
				  willSwitchFromViewController:fromViewController
									   atIndex:self.previouslySelectedIndex
							  toViewController:toViewController
									   atIndex:index];
	}
	
	[self addChildViewController:toViewController];
	if (![self.view.subviews containsObject:toViewController.view]) {
		[self.view addSubview:toViewController.view];
	}
	[toViewController didMoveToParentViewController:self];
	
	if ([self.delegate respondsToSelector:@selector(segmentedViewController:didSwitchFromViewController:atIndex:toViewController:atIndex:)]) {
		[self.delegate segmentedViewController:self
				   didSwitchFromViewController:fromViewController
									   atIndex:self.previouslySelectedIndex
							  toViewController:toViewController
									   atIndex:index];
	}
}

- (void)hideChildViewControllerAtIndex:(NSInteger)index
{
	ASSERT_INDEX_IS_WITHIN_BOUNDS(index,self.childViewControllers);
	UIViewController *childViewController = [self childViewControllerAtIndex:index];
	[childViewController willMoveToParentViewController:self];
	[childViewController.view removeFromSuperview];
	[childViewController removeFromParentViewController];
}

#pragma mark - Target/Action

- (void)viewControllerSelectionDidChange:(id)sender
{
	self.switchingViewControllers = YES;
	[self hideChildViewControllerAtIndex:self.previouslySelectedIndex];
	[self showChildViewControllerAtIndex:self.segmentedControl.selectedSegmentIndex];
	self.previouslySelectedIndex = self.segmentedControl.selectedSegmentIndex;
	self.switchingViewControllers = NO;
}

@end
