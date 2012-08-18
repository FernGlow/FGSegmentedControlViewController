//
//  ExampleViewController.m
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

#import "ExampleViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#define USE_TOOLBAR_INSTEAD_OF_NAVIGATION_BAR_TITLE_VIEW 0

@implementation ExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
		
	// Create numbered view controllers to switch between
	FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
	SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
	ThirdViewController *thirdViewController = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:[NSBundle mainBundle]];

	// Set root view controllers
	[self setViewControllers:@[firstViewController,secondViewController,thirdViewController]];
	
	if (!USE_TOOLBAR_INSTEAD_OF_NAVIGATION_BAR_TITLE_VIEW) {
		// Add segmented control to the navigation controller's title view
		self.navigationItem.titleView = self.segmentedControl;
		[self.navigationController setNavigationBarHidden:NO animated:NO];
	}
	
	[self.navigationController setToolbarHidden:!USE_TOOLBAR_INSTEAD_OF_NAVIGATION_BAR_TITLE_VIEW animated:NO];

	if (USE_TOOLBAR_INSTEAD_OF_NAVIGATION_BAR_TITLE_VIEW) {
		UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
		UIBarButtonItem *segmentedControlItem = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
		[self setToolbarItems:@[flexibleSpace,segmentedControlItem,flexibleSpace] animated:NO];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
