//
//  UstaRegisterContactInfoView.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "UstaRegisterContactInfoView.h"

#import "USProductView.h"



NSString *const USLocationKey   = @"USLOCATIONKEY";
NSString *const USHandmadeKey   = @"USHANDMADEKEY";
NSString *const USuseCarierKey  = @"USUSECARIEERKEY";
NSString *const USOnlineSellKey = @"USONLINESELLKEY";
NSString *const USisMemberKey   = @"USMEMBERKEY";
NSString *const USSingleStcKey  = @"USSINGLESTCKEY";

@interface UstaRegisterContactInfoView () <DeletionDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionFromWhereLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionFromWhereField;
@property (weak, nonatomic) IBOutlet UILabel *questionIsHandMadeLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionIsHandMadeField;
@property (weak, nonatomic) IBOutlet UILabel *questionUseCarrierLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionUseCarrierField;
@property (weak, nonatomic) IBOutlet UILabel *questionOnlineSellLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionOnlineSellField;
@property (weak, nonatomic) IBOutlet UILabel *questionMemberOfLabel;
@property (weak, nonatomic) IBOutlet UITextField *questionMemberOfField;
@property (weak, nonatomic) IBOutlet UILabel *singleSntcLabel;
@property (weak, nonatomic) IBOutlet UITextField *singleSntcField;

@property (nonatomic, strong) NSMutableDictionary *infoDictionary;

@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIButton *aggreePolicyButton;

@end

@implementation UstaRegisterContactInfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.questionMemberOfField.delegate = self;
    self.questionIsHandMadeField.delegate = self;
    self.questionUseCarrierField.delegate = self;
    self.questionOnlineSellField.delegate = self;
    self.singleSntcField.delegate = self;
    self.questionFromWhereField.delegate = self;
    
    self.infoDictionary = [NSMutableDictionary dictionary];
    self.imagesArray = [NSMutableArray array];
    [self loadLocalizedStrings];
}

- (void)loadLocalizedStrings {
    
}

- (IBAction)addProductImage:(id)sender {
    if ([[self delegate] respondsToSelector:@selector(pickPhoto)]) {
        [[self delegate] pickPhoto];
    }
}

- (IBAction)readUserAggrement:(id)sender {
}

- (IBAction)agreeUserAggrement:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (IBAction)commButtonsDidPress:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (IBAction)doneButtonDidPress:(id)sender {
    
    BOOL isEverythinkOK = YES;
    if (_questionFromWhereField.text.length <= 0) {
        [self configuremissingTextField:_questionFromWhereField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (_questionMemberOfField.text.length <= 0) {
        [self configuremissingTextField:_questionMemberOfField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (_questionIsHandMadeField.text.length <= 0) {
        [self configuremissingTextField:_questionIsHandMadeField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (_questionOnlineSellField.text.length <= 0) {
        [self configuremissingTextField:_questionOnlineSellField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (_questionUseCarrierField.text.length <= 0) {
        [self configuremissingTextField:_questionUseCarrierField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (_singleSntcField.text.length <= 0) {
        [self configuremissingTextField:_singleSntcField
                       withErrorMessage:NSLocalizedString(@"MAALERTVIEW_NOINTERNET_MISSING_INPUT", @"")];
        isEverythinkOK = NO;
    }
    
    if (!isEverythinkOK) return;
    
    if (!self.aggreePolicyButton.selected) {
        
        [self alertWithTitle:NSLocalizedString(@"MAALERTVIEW_WARNING_HEADER", nil)
                 withMessage:@"Kullanım koşullarını kabul etmelisiniz"];//
        return;
    }
    
    [self.infoDictionary setObject:self.questionMemberOfField.text
                            forKey:USisMemberKey];
    [self.infoDictionary setObject:self.singleSntcField.text
                            forKey:USSingleStcKey];
    [self.infoDictionary setObject:self.questionFromWhereField.text
                            forKey:USLocationKey];
    [self.infoDictionary setObject:self.questionIsHandMadeField.text
                            forKey:USHandmadeKey];
    [self.infoDictionary setObject:self.questionOnlineSellField.text
                            forKey:USOnlineSellKey];
    [self.infoDictionary setObject:self.questionUseCarrierField.text
                            forKey:USuseCarierKey];
    
    
    if ([[self delegate] respondsToSelector:@selector(ustamDictionaryCompleted:)]) {
        
        [[self delegate] ustamDictionaryCompleted:self.infoDictionary];
    }
}

- (void)ustaImageAdded:(UIImage *)image {
    USProductView *productView = [[[NSBundle mainBundle] loadNibNamed:@"USProductView" owner:self options:nil] objectAtIndex:0];
    [productView setImage:image];
    productView.delegate = self;
    productView.tag = self.imagesArray.count;
    
    [self.imagesArray addObject:productView];
    
    productView.center = CGPointMake(self.imagesArray.count * 75, self.scroller.frame.size.height/2);
    [self.scroller addSubview:productView];
}

- (void)onDelete:(NSInteger)tag {
    //    [self.imagesArray removeObjectAtIndex:tag];
    //
    //    if (tag < self.imagesArray.count) {
    //        for (NSInteger i = tag ; i < self.imagesArray.count; i++) {
    //            UIView *subview = self.imagesArray[i];
    //            subview.center = CGPointMake((i+1) * 75, self.scroller.frame.size.height/2);
    //        }
    //    }
}

- (void)configuremissingTextField:(UITextField *)textField withErrorMessage:(NSString *)errorMessageKey {
    NSMutableAttributedString * errorText = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(errorMessageKey, @"")];
    [errorText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,errorText.length)];
    textField.attributedText = errorText;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
}

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

- (void)alertWithTitle:(NSString *)title
           withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ACCEPT_BUTTON_TITLE", nil)
                                          otherButtonTitles:nil];
    [alert show];
}
@end
