//
//  ViewController.m
//  ImageCombine
//
//  Created by Manindra on 14/05/15.
//  Copyright (c) 2015 10C Internet Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
	CGPoint startPosition;
	CGPoint startSlidingViewPosition;
	UIDynamicAnimator* _animator;
	UIGravityBehavior* _gravity;
	UICollisionBehavior* _collision;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	//self.imageView.image = [self imageOfSize];
	//self.imageView.backgroundColor = [UIColor grayColor];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	
	
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	self.hiddenViewController = (HidedViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HiddenViewController"];
	
	self.slidingView = self.hiddenViewController.view;
	[self.view addSubview:self.slidingView];
	
	self.slidingView.frame = CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
	
}
- (BOOL)prefersStatusBarHidden{
	return YES;
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender{
//	_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//	_gravity = [[UIGravityBehavior alloc] initWithItems:@[self.slidingView]];
//	[_animator addBehavior:_gravity];
//	
//	
//	_collision = [[UICollisionBehavior alloc]
//		      initWithItems:@[self.slidingView,self.imageView]];
//	_collision.translatesReferenceBoundsIntoBoundary = NO;
//	[_animator addBehavior:_collision];

}


- (UIImage *)imageOfSize{
	
	UIImage *card1Image = [UIImage imageNamed:@"1"];
	UIImage *card2Image = [UIImage imageNamed:@"2"];
	UIImage *card3Image = [UIImage imageNamed:@"3"];
	
	UIGraphicsBeginImageContext(self.imageView.bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextTranslateCTM(context, 0, self.imageView.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	
	// get a reference to that context we created
	
	CGContextDrawImage(context, CGRectMake(0, 0, 30, 45), card1Image.CGImage);
	CGContextDrawImage(context, CGRectMake(20, 0, 30, 45), card2Image.CGImage);
	CGContextDrawImage(context, CGRectMake(40, 0, 30, 45), card3Image.CGImage);
	
	
	// generate a new UIImage from the graphics context we drew onto
	UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//return the color-burned image
	return coloredImg;
	
	
	
}


- (IBAction)handleTapp:(UIPanGestureRecognizer *)sender {
	CGPoint netTranslation;
	CGPoint translation = [sender translationInView:self.imageView];
	
	NSLog(@"translation = %@",NSStringFromCGPoint(translation));
	
	
	
	if(sender.state == UIGestureRecognizerStateBegan){
		NSLog(@"ended........");
		startPosition = self.imageView.center;
	}
	if(sender.state == UIGestureRecognizerStateChanged){
		NSLog(@"ended........");
		sender.view.center = CGPointMake(startPosition.x + translation.x, startPosition.y + translation.y);
	}
	
	
	
	
	
	
	
}

- (IBAction)slideDown:(UIPanGestureRecognizer *)sender {
	CGPoint translation = [sender translationInView:self.imageView];
	
	if(sender.state == UIGestureRecognizerStateBegan){
		
		startPosition = self.button.center;
		startSlidingViewPosition = self.slidingView.center;
		
	}
	if(sender.state == UIGestureRecognizerStateChanged){
		NSLog(@"translation=%@",NSStringFromCGPoint(translation));
		
		
		
		if(translation.y < 0){
			if((startPosition.y + translation.y) < 40)
				return;
			
		
		}else{
			
			
		}
		
		sender.view.center = CGPointMake(self.button.center.x, startPosition.y + translation.y);
		
		self.slidingView.center = CGPointMake(self.slidingView.center.x, startSlidingViewPosition.y + translation.y);
		

		if(self.slidingView.frame.origin.y > 0){
			CGRect slidingRect = self.slidingView.frame;
			slidingRect.origin.y = 0;
			self.slidingView.frame = slidingRect;
		}
			
	}
	
	if(sender.state == UIGestureRecognizerStateEnded){
		[self dropSliderView];
	
	}
	
	
	
	
}

- (void)dropSliderView{
	CGRect sliderRect = self.slidingView.frame;
	
	CGRect buttonRect = self.button.frame;
	
	if(self.button.frame.origin.y > self.view.frame.size.height/2){
		sliderRect.origin = CGPointMake(0, -50);
		buttonRect.origin = CGPointMake(buttonRect.origin.x, self.view.frame.size.height - 40);
		
	}else{
		sliderRect.origin = CGPointMake(0, - self.view.frame.size.height);
		buttonRect.origin = CGPointMake(buttonRect.origin.x,  10);
	
	
	}
	
	
	
	
	
	
	[UIView animateWithDuration:0.5 animations:^{
		self.slidingView.frame = sliderRect;
		self.button.frame = buttonRect;

	}];
	
	
}




@end
