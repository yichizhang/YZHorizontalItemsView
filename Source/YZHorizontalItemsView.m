/*
 Copyright (c) 2014 Yichi Zhang
 https://github.com/yichizhang
 zhang-yi-chi@hotmail.com
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "YZHorizontalItemsView.h"

@interface YZHorizontalItemsView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation YZHorizontalItemsView

#pragma mark - Initialization

- (void)setUp{
	
	self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thisViewIsTapped:)];
	[self addGestureRecognizer:self.tapRecognizer];
	
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setUp];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUp];
	}
	return self;
}

#pragma mark - Layout

- (void)layoutSubviews{
 
	[super layoutSubviews];
	
	CGFloat currentX = 0;
	NSUInteger idx = 0;
	
    for (UIView *view in self.itemsArray) {
		
		CGSize currentViewSize = [self sizeForItemAtIndex:idx];
		view.frame =
		CGRectMake(
				   currentX,
				   0,
				   currentViewSize.width,
				   currentViewSize.height
				   );
		currentX += currentViewSize.width;
		idx++;
	}
	
}

- (CGSize)sizeForItemAtIndex:(NSUInteger)index{
	
	return
	CGSizeMake(
			   self.bounds.size.width / self.itemsArray.count,
			   self.bounds.size.height
			   );
	
}

#pragma mark - User Interaction

- (void)thisViewIsTapped:(UITapGestureRecognizer*)recognizer{
	
	CGPoint touchInView = [recognizer locationInView:self];
	CGRect touchRect = CGRectMake(touchInView.x, touchInView.y, 1, 1);
	NSUInteger idx = 0;
	
	for (UIView *view in self.itemsArray) {
		
		if (CGRectIntersectsRect(view.frame, touchRect)) {
			if (self.itemTappedBlock) {
				self.itemTappedBlock(idx, view);
			}
		}
		
		idx++;
	}
	
}

#pragma mark - Clean Up

- (void)removeFromSuperview{
	
	[self removeGestureRecognizer:self.tapRecognizer];
	[super removeFromSuperview];
	
}

#pragma mark - Loading Data (Public)

- (void)reloadItems{
	
	for (UIView *subview in self.subviews) {
		[subview removeFromSuperview];
	}
	
	for (UIView *item in self.itemsArray) {
		[self addSubview:item];
	}
	
	[self setNeedsLayout];
	
}

- (void)setItemsArray:(NSArray *)itemsArray{
	
	_itemsArray = itemsArray;
	
	[self reloadItems];
	
}

- (void)setItemsArrayWithItemAtIndexBlock:(id (^)(NSUInteger idx))itemAtIndexBlock itemsCount:(NSUInteger)itemsCount{
	
	if (!itemAtIndexBlock) {
		return;
	}
	
	NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:itemsCount];
	
	for (NSUInteger idx = 0; idx < itemsCount; idx++) {
		
		id obj = itemAtIndexBlock(idx);
		if (obj) {
			[mutableArray addObject:obj];
		}
	}
	
	self.itemsArray = [NSArray arrayWithArray:mutableArray];
	
}

@end
