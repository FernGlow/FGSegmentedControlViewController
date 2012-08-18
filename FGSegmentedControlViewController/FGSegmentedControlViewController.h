//
//  FGSegmentedControlViewController.h
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

#import <UIKit/UIKit.h>

@class FGSegmentedControlViewController;

@protocol FGSegmentedControlViewControllerDelegate <NSObject>
@optional
/**
 Tells the delegate that a segment in the segmented control was selected and that the controller
 will switch controllers.
 
 @param segmentedControlViewController The segmented control controller containing the viewControllers.
 @param fromViewController The view controller that is currently selected
 @param fromIndex The index of the view controller that is currently selected
 @param toViewController The view controller that will be selected
 @param toIndex The index of the view controller that will be selected selected
 
 Immediately after control flow returns to the segmented control controller, the view controllers will be
 switched.  This is trigged via a user interacting with the segmented control or by programmatically selecting
 a segment in the segmented control using -(void)setSelectedIndex:
 
 */
- (void)segmentedViewController:(FGSegmentedControlViewController *)segmentedControlViewController
   willSwitchFromViewController:(UIViewController *)fromViewController
						atIndex:(NSInteger)fromIndex
			   toViewController:(UIViewController *)toViewController
						atIndex:(NSInteger)toIndex;


/**
 Tells the delegate that a segment in the segmented control was selected and that the controller
 has switched controllers.
 
 @param segmentedControlViewController The segmented control controller containing the viewControllers.
 @param fromViewController The view controller that was previously selected
 @param fromIndex The index of the view controller that was previously selected
 @param toViewController The view controller currently selected
 @param toIndex The index of the view controller that is currently selected
 
 This is trigged via a user interacting with the segmented control or by programmatically selecting
 a segment in the segmented control using -(void)setSelectedIndex:
 */
- (void)segmentedViewController:(FGSegmentedControlViewController *)segmentedControlViewController
   didSwitchFromViewController:(UIViewController *)fromViewController
						atIndex:(NSInteger)fromIndex
			   toViewController:(UIViewController *)toViewController
						atIndex:(NSInteger)toIndex;

@end

@interface FGSegmentedControlViewController : UIViewController

/**
 @name Accessing the Segmented Control Controller Properties
 */

/**
 The segmented control controller’s delegate object.
 
 @see FGSegmentedControlViewControllerDelegate
 */
@property (nonatomic, weak) id<FGSegmentedControlViewControllerDelegate>delegate;


/**
 The segmented control associated with this controller. (read-only)
 */
@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;

/**
 @name Managing the View Controllers
 */

/**
 An array of the root view controllers displayed by the segmented control.
 
 When configuring a segmented control controller, you can use this property to specify the content for
 each segment of the segmented controller. The order of the view controllers in the array corresponds
 to the display order in the segmented control. Thus, the controller at index 0 corresponds to the left-most
 segment, the controller at index 1 the next segment to the right, and so on. The default value of this property is nil.
 */
@property(nonatomic, copy) NSArray *viewControllers;


/**
 @name Manging the Selected Segment
 */

/**
 The view controller associated with the currently selected segment.
 
 Changing the view controller also updates the selectedIndex property accordingly. The default value of this property is nil.
 */
@property(nonatomic, assign) UIViewController *selectedViewController;


/**
 The index of the view controller associated with the currently selected segment.
 
 Setting this property changes the selected view controller to the one at the designated index in the viewControllers array.
 The default value of this property is 0.
 */
@property (nonatomic, assign) NSUInteger selectedIndex;


/**
 @name Testing for View Controller Transition
 */

/**
 Returns YES if the controller is in the process of switching view controllers, otherwise returns NO.
 */
- (BOOL)isSwitchingViewControllers;


@end


