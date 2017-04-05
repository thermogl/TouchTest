//
//  UIColor+Additions.m
//  TouchTest
//
//  Created by Tom Irving on 10/11/2015.
//  Copyright © 2015 Tom Irving. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

- (UIColor *)colorByBlendingWithColor:(UIColor *)color2 alpha:(float)alpha2 {
	
	alpha2 = MIN( 1.0, MAX( 0.0, alpha2 ) );
	CGFloat beta = 1.0 - alpha2;
	CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
	[self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
	[color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
	CGFloat red     = r1 * beta + r2 * alpha2;
	CGFloat green   = g1 * beta + g2 * alpha2;
	CGFloat blue    = b1 * beta + b2 * alpha2;
	CGFloat alpha   = a1 * beta + a2 * alpha2;
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end