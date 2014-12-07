//
//  ViewController.m
//  YZHorizontalItemsViewDemo
//
//  Created by Yichi on 7/12/2014.
//  Copyright (c) 2014 Yichi Zhang. All rights reserved.
//

#import "ViewController.h"
#import "YZHorizontalItemsView.h"

@interface ViewController ()

@property (nonatomic, strong) YZHorizontalItemsView *itemsViewA;
@property (weak, nonatomic) IBOutlet YZHorizontalItemsView *itemsViewInStoryboardA;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	/*
	 Demostrates initializing a YZHorizontalItemsView with code,
	 then prepare the "itemsArray" with an Array.
	 */
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
	
	__weak typeof(self)weakSelf = self;
	[self.itemsViewA setItemTappedBlock:^(NSUInteger idx, id item) {
		UILabel *label = (UILabel*)item;
		[weakSelf showAlertInfoForSelectedOption:label.text];
	}];
	
	[self.view addSubview:self.itemsViewA];
	
	
	
	/*
	 Demostrates using YZHorizontalItemsView with storyboard,
	 then prepare the items with an "itemAtIndex" block.
	 */
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
	[self.itemsViewInStoryboardA setItemTappedBlock:^(NSUInteger idx, id item) {
		UILabel *label = (UILabel*)item;
		[weakSelf showAlertInfoForSelectedOption:label.text];
	}];
}

- (void)showAlertInfoForSelectedOption:(NSString*)string{
	
	NSString *message = [NSString stringWithFormat:@"The option is: '%@'.", string];
	UIAlertController *alertController =
	[UIAlertController alertControllerWithTitle:@"An option is selected." message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		
	}]];
	[self presentViewController:alertController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
