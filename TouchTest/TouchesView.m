//
//  TouchesView.m
//  TouchTest
//
//  Created by Tom Irving on 02/11/2015.
//  Copyright © 2015 Tom Irving. All rights reserved.
//

#import "TouchesView.h"

@implementation TouchesView {
	NSMutableDictionary<NSValue*,UIView*>* _touchDict;
}

- (instancetype)initWithFrame:(CGRect)frame {

	if ((self = [super initWithFrame:frame])){
		[self setUserInteractionEnabled:YES];
		[self setMultipleTouchEnabled:YES];
		_touchDict = [NSMutableDictionary new];
	}
	
	return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	[super touchesBegan:touches withEvent:event];
	[touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
		UIView * touchView = [UIView new];
		[_touchDict setObject:touchView forKey:[NSValue valueWithNonretainedObject:obj]];
		[self updateTouchView:touchView forTouch:obj];
		[self addSubview:touchView];
	}];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	[touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
		[self updateTouchView:[_touchDict objectForKey:[NSValue valueWithNonretainedObject:obj]] forTouch:obj];
	}];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	[touches enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, BOOL * _Nonnull stop) {
		NSValue * touchValue = [NSValue valueWithNonretainedObject:obj];
		UIView * touchView = [_touchDict objectForKey:touchValue];
		[self updateTouchView:touchView forTouch:obj];
		[UIView animateWithDuration:0.1 animations:^{
			[touchView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
		} completion:^(BOOL finished) {
			[touchView removeFromSuperview];
		}];
		[_touchDict removeObjectForKey:touchValue];
	}];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];
	[self touchesEnded:touches withEvent:event];
}

- (CGFloat)sizeForForce:(CGFloat)force {
	return 70.f + (force * 10.f);
}

- (void)updateTouchView:(UIView *)touchView forTouch:(UITouch *)touch {
	CGFloat size = [self sizeForForce:touch.force];
	[touchView setFrame:CGRectMake(0, 0, size, size)];
	[touchView setCenter:[touch locationInView:self]];
	UIColor * color = [UIColor grayColor];
	if (touch.force > 6.0f) color = [UIColor colorWithRed:1.000 green:0.174 blue:0.165 alpha:1.000];
	else if (touch.force > 1.0f) color = [UIColor colorWithRed:0.000 green:0.628 blue:1.000 alpha:1.000];
		[touchView setBackgroundColor:color];
	[touchView.layer setCornerRadius:(size / 2)];
}

@end