//
//  USBadgeView.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
	notHighlightedNoBadgeNoTitleNoShadow,
	notHighlightedNoBadgeNoTitleShadow,
	notHighlightedNoBadgeTitleNoShadow,
	
	highlightedNoBadgeNoTitleNoShadow,
	highlightedNoBadgeNoTitleShadow,
	highlightedNoBadgeTitleNoShadow,
	highlightedNotMovingbadgeTitleNoShadow,
	highlightedNotMovingbadgeNoTitleNoShadow,
	highlightedNotMovingbadgeTitleShadow,
	
	maskedCircleMovingBadgeNoTitleShadow,
} Mode;


typedef enum {
    badgeSmall,
    badgeMedium,
    badgeBig
} BadgeSize;

@class USBadgeView;

@protocol MenuButtonDelegate <NSObject>

- (void)buttonDidPress:(USBadgeView *)menuView;

@end

@interface USBadgeView : UIView

@property (nonatomic, strong) NSString *segueName;
@property (nonatomic, strong) NSString *counterTitle;

@property (nonatomic, weak) id <MenuButtonDelegate> delegate;


- (void)showCounterWithNumber:(NSUInteger)counterVal;
- (void)showCounterView;
- (void)hideCounterView;

- (void)updateLogoWithImage:(UIImage *)image;

- (void)setMode:(Mode)val;
- (void)setBadgeSize:(BadgeSize)size;
- (void)updateTitle:(NSString *)title;
- (void)updateTitleFontSize:(int)size;

- (void)showShadowView;
- (void)hideShadowView;

- (void)setTotalRotationValue:(CGFloat)value;
- (void)setReaminingGuaranteeDay:(int)value;
- (void)fillCircleWithLogoImage;
- (void)invalidateRotationTimer;
- (void)shiftTitleLabel;

@end
