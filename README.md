YZHorizontalItemsView
=====================

A view made up of a few views. Think of it as an 'unscrollable' horizontal collection view.

##How to integrate it into my project?

Use cocoapods to add YZHorizontalItemsView.
If you've never used CocoaPods, [check out their page](http://cocoapods.org/):

```
# Your pod file
  pod 'YZHorizontalItemsView'
```

Then run this command

```
pod update
```

##How do I use it?

Firstly, import the header file.

```objc
#import <YZHorizontalItemsView/YZHorizontalItemsView.h>
```

You can initializie a YZHorizontalItemsView in your code (with initWithFrame:), then set its "itemsArray" with an Array.

```objc

@property (nonatomic, strong) YZHorizontalItemsView *itemsViewA;
...

	self.itemsViewA =
	[[YZHorizontalItemsView alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
	
	NSMutableArray *itemsArrayA = [NSMutableArray array];
	
	for (NSUInteger idx = 0; idx < 6; idx++) {
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		[label setText:[NSString stringWithFormat:@"%lu", (unsigned long)idx]];
		[label setTextColor:[UIColor blackColor]];
		[label setTextAlignment:NSTextAlignmentCenter];
		[label setShadowColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
		[label setBackgroundColor:[UIColor colorWithHue:idx*0.1 saturation:1 brightness:1 alpha:1]];
		
		[itemsArrayA addObject:label];
	}
	
	self.itemsViewA.itemsArray = [NSArray arrayWithArray:itemsArrayA];
	
	[self.view addSubview:self.itemsViewA];

```


You can also use YZHorizontalItemsView with storyboard. A more convenient way to set its "itemsArray" is to use an "itemAtIndex" block.

```objc

@property (weak, nonatomic) IBOutlet YZHorizontalItemsView *itemsViewInStoryboardA;
...

	[self.itemsViewInStoryboardA
	 setItemsArrayWithItemAtIndexBlock:^id(NSUInteger idx) {
		 UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		 [label setText:[NSString stringWithFormat:@"%c", (char)idx + 'A']];
		 [label setTextAlignment:NSTextAlignmentCenter];
		 [label setBackgroundColor:[UIColor colorWithWhite:1-0.05*idx alpha:1]];
		 return label;
	 }
	 itemsCount:8
	 ];
```

The "itemTappedBlock" gets called when the user taps on an item.

```objc
...
	__weak typeof(self)weakSelf = self;
	[self.itemsViewA setItemTappedBlock:^(NSUInteger idx, id item) {
		UILabel *label = (UILabel*)item;
		[weakSelf showAlertInfoForSelectedOption:label.text];
	}];
...
	
- (void)showAlertInfoForSelectedOption:(NSString*)string{
	
	NSString *message = [NSString stringWithFormat:@"The option is: '%@'.", string];
	UIAlertController *alertController =
	[UIAlertController alertControllerWithTitle:@"An option is selected." message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		
	}]];
	[self presentViewController:alertController animated:NO completion:nil];
}
```