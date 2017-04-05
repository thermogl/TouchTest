//
//  ForceTouchButton.m
//  TouchTest
//
//  Created by Tom Irving on 10/11/2015.
//  Copyright © 2015 Tom Irving. All rights reserved.
//

#import "ForceTouchButton.h"
#import "UIColor+Additions.h"

@interface ForceTouchButton ()
@property (nonatomic, assign) CGFloat displayedForce;
@end

@implementation ForceTouchButton {
	UIColor * _topColor;
	UIColor * _bottomColor;
	UIColor * _shadowColor;
	UITouch * _currentTouch;
	BOOL _currentTouchInsideBounds;
}

- (instancetype)initWithFrame:(CGRect)frame {
	
	if ((self = [super initWithFrame:frame])){
		[self setMultipleTouchEnabled:NO];
		[self setTintColor:[UIColor colorWithWhite:0.75 alpha:1.000]];
	}
	
	return self;
}

- (void)setTintColor:(UIColor *)tintColor {
	[super setTintColor:tintColor];
	_bottomColor = tintColor;
	_topColor = [_bottomColor colorByBlendingWithColor:[UIColor whiteColor] alpha:0.5];
	_shadowColor = [_bottomColor colorByBlendingWithColor:[UIColor blackColor] alpha:0.5];
	[self.layer setBorderColor:[[_bottomColor colorByBlendingWithColor:[UIColor blackColor] alpha:0.2] CGColor]];
	[self.layer setBorderWidth:1.0];
}

- (void)setDisplayedForce:(CGFloat)displayedForce {
	_displayedForce = displayedForce;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect forNormalizedForce:(CGFloat)normalizedForce {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locationList[]  = {0.0f, 1.0f};

	UIColor * topColor = [_topColor colorByBlendingWithColor:_bottomColor alpha:(normalizedForce)];
	UIColor * bottomColor = [_bottomColor colorByBlendingWithColor:_topColor alpha:(normalizedForce)];
	
	NSArray * colors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
	CGGradientRef myGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locationList);
	CGContextDrawLinearGradient(context, myGradient, CGPointZero,
								CGPointMake(0, rect.size.height), 0);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(myGradient);
	
	if (normalizedForce >= 0.5){
		CGPathRef visiblePath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathAddRect(path, NULL, CGRectInset(self.bounds, -5, -5));
		CGPathAddPath(path, NULL, visiblePath);
		CGPathCloseSubpath(path);
		CGContextAddPath(context, visiblePath);
		CGContextClip(context);
		
		// Now setup the shadow properties on the context
		CGFloat shadowRadius = normalizedForce * 8.0;
		UIColor * shadowColor = [_shadowColor colorWithAlphaComponent:normalizedForce];
		CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), shadowRadius, shadowColor.CGColor);
		
		CGContextAddPath(context, path);
		CGContextEOFillPath(context);
		CGPathRelease(path);
	}
}

- (void)drawRect:(CGRect)rect {
	
	CGFloat normalizedForce = _displayedForce;
	if (self.state == UIControlStateSelected) normalizedForce = 1.0;
	[self drawRect:rect forNormalizedForce:normalizedForce];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch * touch = touches.anyObject;
	_currentTouch = touch;
	_currentTouchInsideBounds = CGRectContainsPoint(self.bounds, [touch locationInView:self]);
	[self setSelected:NO];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch * touch = touches.anyObject;
	_currentTouch = touch;
	_currentTouchInsideBounds = CGRectContainsPoint(self.bounds, [touch locationInView:self]);
	
	[self setDisplayedForce:(_currentTouch.maximumPossibleForce > 1.0 ? _currentTouch.force / _currentTouch.maximumPossibleForce : 1.0)];
	
	/*
	if (_currentTouchInsideBounds && _currentTouch.force >= 6.6){
		[self setSelected:YES];
		[self setUserInteractionEnabled:NO];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[UIView animateWithDuration:0.5 animations:^{
				[self setDisplayedForce:0.0];
			} completion:^(BOOL finished) {
				[self setUserInteractionEnabled:YES];
				[self setSelected:NO];
			}];
		});
	}
	 */
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self setNeedsDisplay];
	
	UITouch * touch = touches.anyObject;
	_currentTouch = touch;
	_currentTouchInsideBounds = CGRectContainsPoint(self.bounds, [touch locationInView:self]);
	
	if (!self.selected) _displayedForce = 0.0;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self touchesEnded:touches withEvent:event];
}

@end
