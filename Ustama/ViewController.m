//
//  ViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic) NSInteger index;

@property (nonatomic) CGPoint targetPoint;
@property (nonatomic) CGPoint startPoint;

@end

@implementation ViewController

- (void)internalInit {
    [super internalInit];
    
    self.index = 0;
    self.imagesArray = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"a.jpg"],
                        [UIImage imageNamed:@"b.jpg"],
                        [UIImage imageNamed:@"c.jpg"],
                        [UIImage imageNamed:@"d.jpg"],
                        [UIImage imageNamed:@"e.jpg"],nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.targetPoint = CGPointMake(self.firstImageView.center.x - 160, self.firstImageView.center.y);
    self.startPoint = self.secondImageView.center;
    self.firstImageView.image = self.imagesArray[self.index];
    [self animate];
}

- (void)animate {
    self.index = self.index + 1;
    if (self.index == self.imagesArray.count) {
        self.index = 0;
    }
    
    self.firstImageView.image = self.imagesArray[self.index];
    CATransition *animation = [CATransition animation];
    [animation setDuration:3.0]; //Animate for a duration of 1.0 seconds
    [animation setType:kCATransitionPush]; //New image will push the old image off
    [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [[self.firstImageView layer] addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4. * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self animate];
    });
}

- (IBAction)openWeb:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ustamdan.com"]];
}

@end
