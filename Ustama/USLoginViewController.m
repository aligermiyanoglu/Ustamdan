//
//  USLoginViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USLoginViewController.h"

@interface USLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation USLoginViewController

- (void)loadLocalizedStrings {
    self.usernameField.placeholder = @"e-posta";
    self.passwordField.placeholder = @"şifre";
}
- (IBAction)loginButtonDidPress:(id)sender {
    if (![self.usernameField.text isValidMail]) {
        [self alertWithTitle:NSLocalizedString(@"MAALERTVIEW_WARNING_HEADER", nil)
                 withMessage:NSLocalizedString(@"EMAIL_FORMAT_CHECK", nil)];
        
        return;
    }
    
    [self showBlackView:@"Giriş yapılıyor"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"LoginToProfile" sender:self];
    });
}

@end
