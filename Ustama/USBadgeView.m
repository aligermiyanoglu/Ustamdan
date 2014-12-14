//
//  USBadgeView.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USBadgeView.h"
#import "UIFont+USFonts.h"

#import <QuartzCore/QuartzCore.h>

typedef enum {
    kCircle,
    kRectangle,
    kOblateSpheroid
} ShapeType;

@interface USBadgeView () {
    struct {
        unsigned int buttonDidPress:1;
    }delegateRespondsTo;
    
    CGFloat totalRotationValue;
    int remainingRotationDay;
    NSTimer *countTimer;
	Mode mode;
    
    
    double animationTime;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIButton *menuButtonView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;

- (IBAction)menuButtonDidPress:(id)sender;

@end

@implementation USBadgeView

CGFloat degreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}


#pragma mark -

- (void)setDelegate:(id<MenuButtonDelegate>)a_delegate {
    if (_delegate != a_delegate) {
        _delegate = a_delegate;
        delegateRespondsTo.buttonDidPress = [[self delegate] respondsToSelector:@selector(buttonDidPress:)];
    }
}

- (void)layoutSubviews{
	[super layoutSubviews];
	self.countView.layer.cornerRadius = self.countView.frame.size.width/2;
    self.countView.backgroundColor = [UIColor redColor];
    self.countLabel.font = [UIFont smallFont];
}

- (void)showCounterView {
    self.countView.alpha = 1.0;
}

- (void)hideCounterView {
    self.countView.alpha = 0.0;
}

- (void)showShadowView {
    self.shadowView.alpha = 1.0;
}

- (void)hideShadowView {
    self.shadowView.alpha = 0.0;
}

- (void)showTitleView {
    self.titleLabel.alpha = 1.0;
	self.titleLabel.textColor = [UIColor blackColor];
    
	self.logoImageView.center = CGPointMake(self.backgroundView.center.x, self.backgroundView.center.y*8.5/10);

}

- (void)hideTitleView {
	self.logoImageView.center = CGPointMake(self.backgroundView.center.x, self.backgroundView.center.y);
    self.titleLabel.alpha = 0.0;
}

- (void)updateLogoWithImage:(UIImage *)image {
    self.logoImageView.image = image;
    if (!image || [image isEqual:[UIImage imageNamed:@"Default-Product.png"]])
        self.shadowView.alpha = 0.0;
}

- (void)setBGImages {
	switch (mode) {
		case maskedCircleMovingBadgeNoTitleShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			self.backgroundView.image = [UIImage imageNamed:@"21_on.png"];
			
            self.frontImageView.alpha = 0.0;
            self.backgroundView.alpha = 0.0;
			break;
			
		case highlightedNoBadgeNoTitleShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			break;
			
		case highlightedNoBadgeTitleNoShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			break;
			
		case highlightedNotMovingbadgeTitleNoShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			break;
			
		case highlightedNotMovingbadgeTitleShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			break;
		case highlightedNotMovingbadgeNoTitleNoShadow:
			self.frontImageView.image = [UIImage imageNamed:@"21_off.png"];
			break;
		default:
			self.frontImageView.image = [UIImage imageNamed:@"21_on.png"];
			break;
	}
	self.shadowView.image = [UIImage imageNamed:@"27.png"];
}

- (void)updateTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)updateTitleFontSize:(int)size {
	self.titleLabel.font = [UIFont fontWithSize:size];
}

- (void)shiftTitleLabel{
	[self.titleLabel setFrame:CGRectMake(self.titleLabel.frame.origin.x+1, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
}


#pragma mark -

- (IBAction)menuButtonDidPress:(id)sender {
	
    if (delegateRespondsTo.buttonDidPress)
        [[self delegate] buttonDidPress:self];
}


#pragma mark - Rotation animation

- (void)animateToAngle:(CGFloat)angle
             withLabel:(CGFloat)daysPassed {
	CGFloat radius = self.menuButtonView.frame.size.width/2;
	CGPoint center = CGPointMake(self.menuButtonView.center.x, self.menuButtonView.center.y);
    NSInteger startValue = totalRotationValue;
    NSInteger currentValue = totalRotationValue;
    if (startValue == 0) {
        startValue = daysPassed * 360/45;
        currentValue = 0;
    }
    
    
    [self setupTimerWithAnimationDictionary:[NSMutableDictionary dictionaryWithDictionary:@{@"startValue":[NSNumber numberWithInteger:startValue],
                                                                                            @"targetValue":[NSNumber numberWithInteger:daysPassed],
                                                                                            @"currentValue":[NSNumber numberWithInteger:currentValue],
                                                                                            @"runUntilDate":[NSDate dateWithTimeIntervalSinceNow:animationTime]}]];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = animationTime;
    pathAnimation.repeatCount = 1;
    
    
    UIBezierPath *ballPath = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:3 * M_PI / 2
                                                          endAngle:degreesToRadians(angle)
                                                         clockwise:YES];
    pathAnimation.path = [ballPath CGPath];
    
    if (mode == maskedCircleMovingBadgeNoTitleShadow) {
		self.backgroundView.alpha = 1.0;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:3 * M_PI / 2
                                                              endAngle:degreesToRadians(angle)
                                                             clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        
        shapeLayer.path = [maskPath CGPath];
		shapeLayer.strokeColor = [[UIColor redColor] CGColor];
		shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        shapeLayer.lineWidth = 15.f;
        
       	
		[self.frontImageView.layer setMask:shapeLayer];
		self.frontImageView.alpha = 1.0;
		[self.frontImageView.layer setMasksToBounds:YES];
        
        CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animateStrokeEnd.duration  = animationTime - 0.05;
        animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
        animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
        
        
        [shapeLayer addAnimation:animateStrokeEnd forKey:@"strokeEndAnimation"];
	}
    [self.countView.layer addAnimation:pathAnimation forKey:@"ballRotate"];
}

- (void)setupTimerWithAnimationDictionary:(NSMutableDictionary *)animationDictionary {
    NSInteger targetValue = [(NSNumber *)[animationDictionary objectForKey:@"targetValue"] integerValue];
    NSInteger currentValue = [(NSNumber *)[animationDictionary objectForKey:@"currentValue"] integerValue];
//    NSDate *toDate = [animationDictionary objectForKey:@"runUntilDate"];
    
    SEL animationMethod = nil;
    
    
    if (currentValue <= targetValue) {
        //incrementing timer
        animationMethod = NSSelectorFromString(@"incrementalRotate:");
    }
    else if (currentValue > targetValue){
        //decrementing timer
        animationMethod = NSSelectorFromString(@"decrementalRotate:");
    }
    
    //Should never return!!!!
    if (!animationMethod){
        NSLog(@"************************* WARNINNGGG****************************");
        return;
    }
    CGFloat time = animationTime/(CGFloat)currentValue;
    CGFloat floatVal = [[NSString stringWithFormat:@"%.3f", time] floatValue];
    countTimer = [NSTimer scheduledTimerWithTimeInterval:floatVal
                                                  target:self
                                                selector:animationMethod
                                                userInfo:animationDictionary
                                                 repeats:YES];
}

- (void)decrementalRotate:(NSTimer *)timer {
    NSMutableDictionary *animationDictionary = timer.userInfo;
    NSInteger targetValue = [(NSNumber *)[animationDictionary objectForKey:@"targetValue"] integerValue];
    NSInteger currentValue = [(NSNumber *)[animationDictionary objectForKey:@"currentValue"] integerValue];
    
    self.countLabel.text = [NSString stringWithFormat:@"%i %@",(int)currentValue,(!self.counterTitle ? @"" : self.counterTitle)];
    
    if (currentValue != targetValue) {
        //decrementing timer
        NSInteger dif = [self animationValueForDifValue:abs((int)targetValue - (int)currentValue)];
        currentValue = currentValue - dif;
        
        [animationDictionary setObject:[NSNumber numberWithInteger:currentValue] forKey:@"currentValue"];
    }
    else {
        [self invalidateRotationTimer];
        [timer invalidate];
    }
}

- (void)incrementalRotate:(NSTimer *)timer {
    NSMutableDictionary *animationDictionary = timer.userInfo;
    NSInteger targetValue = [(NSNumber *)[animationDictionary objectForKey:@"targetValue"] integerValue];
    NSInteger currentValue = [(NSNumber *)[animationDictionary objectForKey:@"currentValue"] integerValue];
    self.countLabel.text = [NSString stringWithFormat:@"%i %@",(int)currentValue,(!self.counterTitle ? @"" : self.counterTitle)];
    
    if (currentValue != targetValue) {
        //incrementing timer
        NSInteger dif = [self animationValueForDifValue:abs((int)targetValue - (int)currentValue)];
        currentValue = currentValue + dif;
        
        [animationDictionary setObject:[NSNumber numberWithInteger:currentValue] forKey:@"currentValue"];
    }
    else {
        [self invalidateRotationTimer];
        [timer invalidate];
    }
}

- (NSInteger)animationValueForDifValue:(NSInteger)dif {
    //for fast animation we decrement fastly
    NSInteger x;
    if (dif > 300) x = dif / 20;
    else if (dif > 200) x = dif / 15;
    else if (dif > 100) x = dif / 10;
    else if (dif > 10) x = dif / 9;
    else if (dif > 5) x = dif / 2;
    else x = 1;
    return x;
}

- (void)invalidateRotationTimer {
	[countTimer invalidate], countTimer = nil;
}


#pragma mark -

- (void)showCounterWithNumber:(NSUInteger)counterVal {
    self.countView.alpha = 1.0;
    int remainGuaranteeDay = (totalRotationValue - counterVal);
	CGFloat angle = 360.*(remainGuaranteeDay/totalRotationValue);
    
    if (totalRotationValue == 0) {
        CGFloat totalRotateValue = counterVal * 360/45;
        angle =  360.*(counterVal/totalRotateValue);
    }
    angle = (angle < 90) ? 270 + angle : angle - 90;
    
    animationTime = 0.7;
    
    [self animateToAngle:angle
               withLabel:counterVal];
    [self showCounterView];
}

- (void)setBadgeSize:(BadgeSize)size {
    CGPoint center = self.countView.center;
    switch (size) {
        case badgeSmall:
        {
            self.countView.frame = CGRectMake(0, 0, 26, 26);
            self.countLabel.font = [UIFont smallFont];
            break;
        }
        case badgeMedium:
        {
            self.countView.frame = CGRectMake(0, 0, 30, 30);
            self.countLabel.font = [UIFont smallFont];
            break;
        }
        case badgeBig:
        {
            self.countView.frame = CGRectMake(0, 0, 34, 34);
            self.countLabel.font = [UIFont mediumFont];
            break;
        }
        default:
            break;
    }
    self.countView.center = center;
}

- (void)setMode:(Mode)configuration{
	mode = configuration;
	[self setBGImages];
	
	switch (mode) {
		case notHighlightedNoBadgeNoTitleNoShadow:
			[self hideCounterView];
			[self hideShadowView];
			[self hideTitleView];
			//			[self showShadowView];
			break;
			
		case notHighlightedNoBadgeNoTitleShadow:
			[self hideCounterView];
			[self showShadowView];
			[self.logoImageView setFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width*100/240, self.backgroundView.frame.size.width*100/240)];
			[self hideTitleView];
			break;
			
		case notHighlightedNoBadgeTitleNoShadow:
			[self hideCounterView];
			[self hideShadowView];
			[self showTitleView];
			break;
			
		case highlightedNoBadgeNoTitleShadow:
			[self hideCounterView];
			[self showShadowView];
			[self hideTitleView];
			break;
		case highlightedNoBadgeNoTitleNoShadow:
			[self hideCounterView];
			[self hideShadowView];
			[self hideTitleView];
			break;
		case highlightedNoBadgeTitleNoShadow:
			[self hideCounterView];
			[self hideShadowView];
			[self.logoImageView setFrame:CGRectMake(0, 0, 30, 30)];
			[self showTitleView];
			break;
			
		case highlightedNotMovingbadgeTitleNoShadow:
			[self showCounterView];
			[self hideShadowView];
			[self showTitleView];
			break;
		case highlightedNotMovingbadgeNoTitleNoShadow:
			[self showCounterView];
			[self hideShadowView];
			[self hideTitleView];
			break;
		case highlightedNotMovingbadgeTitleShadow:
			[self showCounterView];
			[self showShadowView];
			[self showTitleView];
			break;
		case maskedCircleMovingBadgeNoTitleShadow:
			[self showShadowView];
			
			[self.logoImageView setFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width*100/240, self.backgroundView.frame.size.width*100/240)];
			[self hideTitleView];
			[self showCounterWithNumber:remainingRotationDay];
			break;
		default:
			break;
	}
}

- (void)setTotalRotationValue:(CGFloat)value{
    [self invalidateRotationTimer];
	totalRotationValue = value;
}

- (void)setReaminingGuaranteeDay:(int)value{
    [self invalidateRotationTimer];
	remainingRotationDay = value;
}

- (void)fillCircleWithLogoImage{
	[self.logoImageView setFrame:CGRectMake(self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y, self.menuButtonView.frame.size.width-5, self.menuButtonView.frame.size.width-5)];
	
	self.logoImageView.layer.cornerRadius = (self.logoImageView.frame.size.width)/2;
	[self.logoImageView.layer setMasksToBounds:YES];
}


@end
