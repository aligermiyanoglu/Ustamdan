//
//  UstaRegister.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//


#import <UIKit/UIKit.h>

@class USBottomMenuView;

typedef enum {
    openCamera = 0,
    pickPhoto = 1,
    pickVideo = 2,
    shareLoc = 3,
    cancel = 4,
	removePhoto = 5
} MenuButtonValues;

typedef enum {
    fourRow = 0,
    threeRow = 1,
    twoRow = 2,
	threeRowWithDeletePhoto,
	twoRowDeleteNotification
} BottomMenuMode;

@protocol MenuButtonsDelegate <NSObject>

- (void)bottomMenuView:(USBottomMenuView *)menuView didCloseWithPressedButtonTag:(MenuButtonValues)buttonVal;

@end

@interface USBottomMenuView : UIView

@property (nonatomic, weak) id <MenuButtonsDelegate> delegate;

- (void)openMenuView;
- (void)closeMenuView;
- (void)toggLeMenuView;
- (BottomMenuMode)getMode;
- (void)setIsLocationButtonEnabled:(BOOL)isButtonEnabled;
- (void)setMode:(BottomMenuMode)modeIn;
@end
