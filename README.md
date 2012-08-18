[FGSegmentedControlViewController](http://fernglow.github.com/FGSegmentedControlViewController/Documentation/html/Classes/FGSegmentedControlViewController.html) is a container view controller that manages view controllers through a [UISegmentedControl](http://developer.apple.com/library/ios/#DOCUMENTATION/UIKit/Reference/UISegmentedControl_Class/Reference/UISegmentedControl.html).

## FGSegmentedControlViewController In Action


![FGSegmentedControlViewController](http://fernglow.github.com/FGSegmentedControlViewController/images/FGSegmentedControlViewController.gif)


## Getting Started

### 1. Subclass the controller and optionally adopt the delegate protocol

```objective-c
@interface ExampleViewController : FGSegmentedControlViewController <FGSegmentedControlViewControllerDelegate>
```

### 2. Set the view controllers you want to manage with a segmented control

```objective-c
	// Create view controllers to switch between
	FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
	SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
	ThirdViewController *thirdViewController = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:[NSBundle mainBundle]];
	
	// Set root view controllers
	[self setViewControllers:@[firstViewController,secondViewController,thirdViewController]];
```

### 3. Insert the segmented control into the desired view (e.g. UINavigationController's titleView, UIToolbar item, as a subview of another UIView, etc.)

```objective-c
	self.navigationItem.titleView = self.segmentedControl;
```


## Documentation

Read the [full documentation](http://fernglow.github.com/FGSegmentedControlViewController/Documentation/html/index.html)

## Requirements

- iOS 5.1.1
- Apple LLVM 4.0+ (ARC, auto-synthesize, literals and subscripting)

## Contributions

Feel free to fork and submit pull requests. This project is very early in development and I'm open to any improvements.

## License

FGSegmentedControlViewController is available under the MIT license. See the LICENSE file for more info.