//
//  USBaseViewController.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+USFonts.h"
#import "NSString+USStrings.h"
#import "UIImage+USImages.h"
#import "USUserManager.h"
#import "USBottomMenuView.h"

@interface USBaseViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)internalInit;
- (void)loadLocalizedStrings;
- (void)loadUIElements;

- (void)closeKeyboard;
- (void)showBlackView:(NSString *)labelText;
- (void)removeBlackView;

- (void)openBottomMenuView;
- (void)closeBottomMenuView;

- (void)alertWithTitle:(NSString *)title
           withMessage:(NSString *)message;

- (BOOL)checkReachability;

- (void)registerForNetworkNotifications;
- (void)removeForNetworkNotifications;

@end
