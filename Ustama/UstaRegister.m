//
//  UstaRegister.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "UstaRegister.h"

#import "NSString+USStrings.h"


NSString *const USNameKey       = @"USNAME";
NSString *const USSurnameKey    = @"USSURNAME";
NSString *const USEmailKey      = @"USEMAIL";
NSString *const USAgeKey        = @"USAGE";
NSString *const USPhoneKey      = @"USPHONE";
NSString *const USAddressKey    = @"USADDRESS";
NSString *const USStoryKey      = @"USSTORY";
NSString *const USProfessionKey = @"USPROFESSION";
NSString *const USImage         = @"USIMAGE";


@interface UstaRegister () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *pickPhotoButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *surnameLabel;
@property (weak, nonatomic) IBOutlet UITextField *surnameField;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;
@property (weak, nonatomic) IBOutlet UITextView *storyField;
@property (weak, nonatomic) IBOutlet UILabel *professionLabel;
@property (weak, nonatomic) IBOutlet UITextField *professionField;

@property (nonatomic, strong) NSMutableDictionary *infoDictionary;

@end

@implementation UstaRegister

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.infoDictionary = [NSMutableDictionary dictionary];
    
    self.nameField.delegate = self;
    self.surnameField.delegate = self;
    self.emailField.delegate = self;
    self.ageField.delegate = self;
    self.phoneField.delegate = self;
    self.addressField.delegate = self;
    self.professionField.delegate = self;
    [self loadLocalizedStrings];
}

- (void)loadLocalizedStrings {
    self.ageField.placeholder = @"42";
    self.nameField.placeholder = @"Mehmet";
    self.surnameField.placeholder = @"Tekir";
    self.emailField.placeholder = @"mehmet_usta@hotmail.com";
    self.phoneField.placeholder = @"03122211880";
    self.addressField.placeholder = @"Tekyon Sokak No:3, AliPasa Mahallesi, Kadikoy/Istanbul";
    self.professionField.placeholder = @"Cam Ustasi";
}

- (void)ustaImageUpdated:(UIImage *)image {
    [self updateProfileImage:image];
}

- (void)updateProfileImage:(UIImage *)image {
    self.pickPhotoButton.layer.cornerRadius = self.pickPhotoButton.frame.size.width/2;
    self.pickPhotoButton.imageView.layer.cornerRadius = self.pickPhotoButton.frame.size.width/2;
    
    self.pickPhotoButton.backgroundColor = [UIColor clearColor];
    
    if (image == nil) {
        [self.pickPhotoButton setImage:[UIImage imageNamed:@"8_.png"]
                              forState:UIControlStateNormal];
        [self.pickPhotoButton setImage:[UIImage imageNamed:@"8_.png"]
                              forState:UIControlStateSelected];
        [self.pickPhotoButton setImage:[UIImage imageNamed:@"8_.png"]
                              forState:UIControlStateHighlighted];
    } else {
        [self.pickPhotoButton setImage:image
                              forState:UIControlStateNormal];
        [self.pickPhotoButton setImage:image
                              forState:UIControlStateSelected];
        [self.pickPhotoButton setImage:image
                              forState:UIControlStateHighlighted];
        
        [self.pickPhotoButton setBackgroundImage:[UIImage imageNamed:@"35.png"] forState:UIControlStateNormal];
        self.pickPhotoButton.imageView.layer.cornerRadius = self.pickPhotoButton.frame.size.width/2;
    }
}

#pragma mark -

- (IBAction)pickPhoto:(id)sender {
    if ([[self delegate] respondsToSelector:@selector(pickPhoto)]) {
        [[self delegate] pickPhoto];
    }
}

- (IBAction)nextButtonDidPress:(id)sender {
    BOOL isEverythinkOK = YES;
    if (_nameField.text.length <= 0) {
        [self configuremissingTextField:_nameField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_NAME_ERROR", @"")];
        isEverythinkOK = NO;
    }
    
    if (_surnameField.text.length <= 0) {
        [self configuremissingTextField:_surnameField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_SURNAME_ERROR", @"")];
        isEverythinkOK = NO;
    }
    
    if (_emailField.text.length <= 0) {
        [self configuremissingTextField:_emailField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_MAIL_ERROR", @"")];
        isEverythinkOK = NO;
    }
    
    if (_ageField.text.length <= 0) {
        [self configuremissingTextField:_ageField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_AGE", @"")];
        isEverythinkOK = NO;
    }
    
    if (_phoneField.text.length <= 0) {
        [self configuremissingTextField:_phoneField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_PHONE_ERROR", @"")];
        isEverythinkOK = NO;
    }
    
    if (_addressField.text.length <= 0) {
        [self configuremissingTextField:_addressField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_ADDRESS_ERROR", @"")];
        isEverythinkOK = NO;
    }
    
    if (_storyField.text.length <= 0) {
        [self alertWithTitle:NSLocalizedString(@"MAALERTVIEW_WARNING_HEADER", nil)
                 withMessage:NSLocalizedString(@"NEW_USER_VC_STORY", @"")];
        isEverythinkOK = NO;
    }
    
    if (_professionField.text.length <= 0) {
        [self configuremissingTextField:_professionField
                       withErrorMessage:NSLocalizedString(@"NEW_USER_VC_PROFESSION", @"")];
        isEverythinkOK = NO;
    }
    
    //Reguired fields are not filled
    if (!isEverythinkOK) return;
    
    if ([_emailField.text isValidMail] == NO) {
    
    [self alertWithTitle:NSLocalizedString(@"MAALERTVIEW_WARNING_HEADER", nil)
             withMessage:NSLocalizedString(@"EMAIL_FORMAT_CHECK", nil)];//
        return;
    }
    
    [self.infoDictionary setObject:self.nameField.text
                            forKey:USNameKey];
    [self.infoDictionary setObject:self.surnameField.text
                            forKey:USSurnameKey];
    [self.infoDictionary setObject:self.emailField.text
                            forKey:USEmailKey];
    [self.infoDictionary setObject:self.ageField.text
                            forKey:USAgeKey];
    [self.infoDictionary setObject:self.phoneField.text
                            forKey:USPhoneKey];
    [self.infoDictionary setObject:self.addressField.text
                            forKey:USAddressKey];
    [self.infoDictionary setObject:self.storyField.text
                            forKey:USStoryKey];
    [self.infoDictionary setObject:self.professionField.text
                            forKey:USProfessionKey];
    
    if ([[self delegate] respondsToSelector:@selector(ustamDictionary:)]) {
        [[self delegate] ustamDictionary:self.infoDictionary];
    }
}

#pragma mark -


- (void)alertWithTitle:(NSString *)title
           withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ACCEPT_BUTTON_TITLE", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)configuremissingTextField:(UITextField *)textField withErrorMessage:(NSString *)errorMessageKey {
    NSMutableAttributedString * errorText = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(errorMessageKey, @"")];
    [errorText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,errorText.length)];
    textField.attributedText = errorText;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
}

#pragma mark - 


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField.attributedText enumerateAttributesInRange:NSMakeRange(0, [textField.attributedText length])
                                                 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                              usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop)
     {
         BOOL isRed = [[attributes objectForKey:NSForegroundColorAttributeName] isEqual:
                       [UIColor redColor]];
         if (isRed) {
             textField.attributedText = nil;
             textField.text = nil;
             textField.textColor = [UIColor blackColor];
         }
         
     }];
}
@end
