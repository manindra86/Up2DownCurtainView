//
//  ViewController.h
//  ImageCombine
//
//  Created by Manindra on 14/05/15.
//  Copyright (c) 2015 10C Internet Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HidedViewController.h"
@interface ViewController : UIViewController
@property(nonatomic,weak)IBOutlet UIImageView *imageView;
@property(nonatomic,weak)IBOutlet UIButton *button;
@property(nonatomic,weak)IBOutlet UIView *slidingView;

@property (nonatomic,strong) HidedViewController *hiddenViewController;
- (IBAction)handleTapp:(id)sender;
- (IBAction)slideDown:(UIPanGestureRecognizer *)sender;
- (IBAction)buttonTapped:(id)sender;
@end

