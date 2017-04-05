//
//  ViewController.m
//  TouchTest
//
//  Created by Tom Irving on 02/11/2015.
//  Copyright © 2015 Tom Irving. All rights reserved.
//

#import "ViewController.h"
#import "TouchesView.h"
#import "ForceTouchButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//if (self.view.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
	
		/*
		TouchesView * touchesView = [[TouchesView alloc] initWithFrame:self.view.bounds];
		[touchesView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
		[self.view addSubview:touchesView];
		 */
		
		ForceTouchButton * forceTouchButton = [[ForceTouchButton alloc] initWithFrame:CGRectMake(0, 0, 200, 75)];
		[forceTouchButton setCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height * 1 / 4)];
		[forceTouchButton setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
											   UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)];
		[forceTouchButton setTintColor:[UIColor colorWithRed:0.380 green:0.733 blue:0.227 alpha:1.000]];
		[self.view addSubview:forceTouchButton];
		
		ForceTouchButton * forceTouchButton2 = [[ForceTouchButton alloc] initWithFrame:CGRectMake(0, 0, 200, 75)];
		[forceTouchButton2 setCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height * 2 / 4)];
		[forceTouchButton2 setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
											   UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)];
		[forceTouchButton2 setTintColor:[UIColor colorWithRed:0.000 green:0.628 blue:1.000 alpha:1.000]];
		[self.view addSubview:forceTouchButton2];
		
		ForceTouchButton * forceTouchButton3 = [[ForceTouchButton alloc] initWithFrame:CGRectMake(0, 0, 200, 75)];
		[forceTouchButton3 setCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height * 3 / 4)];
		[forceTouchButton3 setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin |
												UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin)];
		[forceTouchButton3 setTintColor:[UIColor colorWithRed:1.000 green:0.174 blue:0.165 alpha:1.000]];
		[self.view addSubview:forceTouchButton3];
	//}
	//else
	//{
		//UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"3D touch isn't available" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alertView show];
	//}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
