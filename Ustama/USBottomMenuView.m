//
//  MABottomMenuView.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//



#import "USBottomMenuView.h"
#import "UIFont+USFonts.h"

@interface USBottomMenuView () {
    struct {
        unsigned int bottomMenuViewDidCloseWithPressedButtonTag:1;
    }delegateRespondsTo;
	BottomMenuMode mode;
}
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *menu;

@property  (nonatomic) BOOL isMenuOpen;

@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
@property (strong, nonatomic) NSMutableArray *buttons;
- (IBAction)buttonDidPress:(id)sender;

@end

@implementation USBottomMenuView
- (BottomMenuMode)getMode{
	return mode;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.blackView.alpha = 0.0;
    self.isMenuOpen = NO;
	self.buttons = [[NSMutableArray alloc]init];
	[self.buttons addObject:self.firstButton];
	[self.buttons addObject:self.secondButton];
	[self.buttons addObject:self.thirdButton];
	[self.buttons addObject:self.fourthButton];
	[self.buttons addObject:self.fifthButton];
	
    [self loadLocalizedStrings];
	
}
- (void)customizeUIElements{
    self.firstButton.titleLabel.font = [UIFont mediumFont];
	self.secondButton.titleLabel.font = [UIFont mediumFont];
	self.thirdButton.titleLabel.font = [UIFont mediumFont];
	self.fourthButton.titleLabel.font = [UIFont mediumFont];
	self.fifthButton.titleLabel.font = [UIFont mediumFont];
	
}
- (void) setMode: (BottomMenuMode) modeIn{
	if (mode == twoRow) {
		[self addButton:2];
	}
	mode = modeIn;
	switch (modeIn) {
		case fourRow:
			;
			break;
		case threeRow:
			[self removeButton:3];
			break;
		case twoRow:
			[self removeButton:3];
			[self removeButton:2];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil)  forState:UIControlStateNormal];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil)  forState:UIControlStateHighlighted];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil) forState:UIControlStateSelected];
			break;
		case twoRowDeleteNotification:
			[self removeButton:3];
			[self removeButton:2];
			
			[self.firstButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_NOTIFICATION", nil) forState:UIControlStateNormal];
			[self.firstButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_NOTIFICATION", nil) forState:UIControlStateHighlighted];
			[self.firstButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_NOTIFICATION", nil) forState:UIControlStateSelected];
			
			[self.secondButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_ALL_NOTIFICATIONS", nil) forState:UIControlStateNormal];
			[self.secondButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_ALL_NOTIFICATIONS", nil) forState:UIControlStateHighlighted];
			[self.secondButton setTitle:NSLocalizedString(@"NOTIFICATIONS_DELETE_ALL_NOTIFICATIONS", nil) forState:UIControlStateSelected];
			break;
		case threeRowWithDeletePhoto:
			
			[self removeButton:3];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil)  forState:UIControlStateNormal];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil)  forState:UIControlStateHighlighted];
			[self.firstButton setTitle:NSLocalizedString(@"BUTTON_TAKE_PHOTO", nil) forState:UIControlStateSelected];
			[self.thirdButton setTitle:NSLocalizedString(@"PROFILE_EDIT_VC_REMOVE_PHOTO", nil) forState:UIControlStateNormal];
			[self.thirdButton setTitle:NSLocalizedString(@"PROFILE_EDIT_VC_REMOVE_PHOTO", nil) forState:UIControlStateSelected];
			[self.thirdButton setTitle:NSLocalizedString(@"PROFILE_EDIT_VC_REMOVE_PHOTO", nil) forState:UIControlStateHighlighted];
			break;
		default:
			break;
	}
}
- (void)setDelegate:(id<MenuButtonsDelegate>)a_delegate {
    if (a_delegate != _delegate) {
        _delegate = a_delegate;
        
        delegateRespondsTo.bottomMenuViewDidCloseWithPressedButtonTag = [[self delegate] respondsToSelector:@selector(bottomMenuView:didCloseWithPressedButtonTag:)];
    }
}

#pragma mark -

- (void)loadLocalizedStrings {
    [self.firstButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CAMERA", nil) forState:UIControlStateNormal];
    [self.firstButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CAMERA", nil) forState:UIControlStateHighlighted];
    [self.firstButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CAMERA", nil) forState:UIControlStateSelected];
    
    [self.secondButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_PHOTO", nil) forState:UIControlStateNormal];
    [self.secondButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_PHOTO", nil) forState:UIControlStateHighlighted];
    [self.secondButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_PHOTO", nil) forState:UIControlStateSelected];
    
    [self.thirdButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_VIDEO", nil) forState:UIControlStateNormal];
    [self.thirdButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_VIDEO", nil) forState:UIControlStateHighlighted];
    [self.thirdButton setTitle:NSLocalizedString(@"BUTTON_TITLE_PICK_VIDEO", nil) forState:UIControlStateSelected];
    
    [self.fourthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_SHARE_LOCATION", nil) forState:UIControlStateNormal];
    [self.fourthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_SHARE_LOCATION", nil) forState:UIControlStateHighlighted];
    [self.fourthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_SHARE_LOCATION", nil) forState:UIControlStateSelected];
    
    [self.fifthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CANCEL", nil) forState:UIControlStateNormal];
    [self.fifthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CANCEL", nil) forState:UIControlStateHighlighted];
    [self.fifthButton setTitle:NSLocalizedString(@"BUTTON_TITLE_CANCEL", nil) forState:UIControlStateSelected];
}


#pragma mark -

- (void)toggLeMenuView {
    if (self.blackView.alpha == 0.0) {
        [self openMenuView];
    }
    else {
        [self closeMenuView];
    }
    self.isMenuOpen = !self.isMenuOpen;
}

- (void)openMenuView {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    if (!self.isMenuOpen) {
        [UIView animateWithDuration:0.24
                         animations:^(){
                             self.menu.center = CGPointMake(self.menu.center.x, self.menu.center.y - self.menu.frame.size.height);
                             self.blackView.alpha = 0.6;
                         } completion:^(BOOL isFinished) {
                             self.isMenuOpen = YES;
                         }];
    }
}

- (void)closeMenuView {
    if (self.isMenuOpen) {
        [UIView animateWithDuration:0.24
                         animations:^(){
                             self.menu.center = CGPointMake(self.menu.center.x, self.menu.center.y + self.menu.frame.size.height);
                             self.blackView.alpha = 0.0;
                         } completion:^(BOOL isFinished) {
                             self.isMenuOpen = NO;
                             self.delegate = nil;
                             [self removeFromSuperview];
                         }];
        
    }
}

- (void)removeLocationButton {
    if ([self.fourthButton isDescendantOfView:self.menu]) {
        [self.fourthButton removeFromSuperview];
        CGFloat height = self.firstButton.frame.size.height;
        [UIView animateWithDuration:0.4
                         animations:^() {
                             self.firstButton.center = CGPointMake(self.firstButton.center.x, self.firstButton.center.y + height);
                             self.secondButton.center = CGPointMake(self.secondButton.center.x, self.secondButton.center.y + height);
                             self.thirdButton.center = CGPointMake(self.thirdButton.center.x, self.thirdButton.center.y + height);
                         }
                         completion:^(BOOL isFinished) {
                             
                         }];
        
    }
}

- (void)addLocationButton {
    if (![self.fourthButton isDescendantOfView:self.menu]) {
        [self.menu addSubview:self.fourthButton];
        CGFloat height = self.firstButton.frame.size.height;
        [UIView animateWithDuration:0.4
                         animations:^() {
                             self.firstButton.center = CGPointMake(self.firstButton.center.x, self.firstButton.center.y - height);
                             self.secondButton.center = CGPointMake(self.secondButton.center.x, self.secondButton.center.y - height);
                             self.thirdButton.center = CGPointMake(self.thirdButton.center.x, self.thirdButton.center.y - height);
                         }
                         completion:^(BOOL isFinished) {
                             
                         }];
    }
}

- (void)setIsLocationButtonEnabled:(BOOL)isButtonEnabled {
    if (isButtonEnabled) {
        [self addButton:0];
    }
    else
        [self removeButton:0];
}

- (void)removeButton: (int)buttonIndex {
	UIButton* button = self.buttons[buttonIndex];
    if ([button isDescendantOfView:self.menu]) {
        [button removeFromSuperview];
		if (buttonIndex > 0) {
			CGFloat height = button.frame.size.height;
			[UIView animateWithDuration:0.4
							 animations:^() {
								 for (int i = buttonIndex-1; i>=0; i--) {
									 UIButton* tempButton = self.buttons[i];
									 if ([tempButton isDescendantOfView:self.menu]) {
										 tempButton.center = CGPointMake(tempButton.center.x,tempButton.center.y + height);
									 }
								 }
							 }
							 completion:^(BOOL isFinished) {
								 
							 }];
		}
    }
}

- (void)addButton: (int) buttonIndex {
	UIButton* button = self.buttons[buttonIndex];
    if (![button isDescendantOfView:self.menu] && (buttonIndex>=0 && buttonIndex<self.buttons.count)) {
		[self.menu addSubview:button];
        CGFloat height = button.frame.size.height;
        [UIView animateWithDuration:0.4
                         animations:^() {
							 for (int i = buttonIndex-1; i>=0; i--) {
								 UIButton* tempButton = self.buttons[i];
								 if ([tempButton isDescendantOfView:self.menu]) {
									 tempButton.center = CGPointMake(tempButton.center.x,tempButton.center.y - height);
								 }
							 }
                         }
                         completion:^(BOOL isFinished) {
                             
                         }];
    }
}

#pragma mark -

- (IBAction)buttonDidPress:(id)sender {
    if (delegateRespondsTo.bottomMenuViewDidCloseWithPressedButtonTag) {
        UIButton *btn = (UIButton *)sender;
        if (btn.tag != 4){
			if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"PROFILE_EDIT_VC_REMOVE_PHOTO", nil)]) {
				[[self delegate] bottomMenuView:self didCloseWithPressedButtonTag:5];
			} else {
				[[self delegate] bottomMenuView:self didCloseWithPressedButtonTag:(int)btn.tag];
			}
		}
        [self closeMenuView];
    }
}

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    
    if (touch.view == self.blackView) {
        [self toggLeMenuView];
    }
}

@end
