//
//  USProfileViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USProfileViewController.h"
#import "USBadgeView.h"
#import "UstaRegister.h"

@interface USProfileViewController () <MenuButtonDelegate>

@property (weak, nonatomic) USBadgeView *imageButton;
@property (weak, nonatomic) USBadgeView *notificationsButton;
@property (weak, nonatomic) USBadgeView *productsButton;
@property (weak, nonatomic) USBadgeView *settingsButton;

@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *notificationsView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *productsView;


@property (nonatomic, strong) NSDictionary *userDic;
@end

@implementation USProfileViewController

- (void)internalInit {
    [super internalInit];
    self.userDic = [[USUserManager getInstance] loadCustomObject];
}

- (void)loadUIElements {
    [super loadUIElements];
    self.imageButton = [[[NSBundle mainBundle] loadNibNamed:@"USBadgeView"
                                                      owner:self
                                                    options:0] objectAtIndex:0];
    [self.imageButton fillCircleWithLogoImage];
    self.imageButton.delegate = self;
    self.imageButton.segueName = @"UnderConstructionSegue";
    self.imageButton.tag = 100;
    
    [self.imageButton setMode:notHighlightedNoBadgeNoTitleNoShadow];
    self.imageButton.center = CGPointMake(self.profileView.frame.size.width / 2, self.profileView.frame.size.height / 2);
    
    [self.profileView addSubview:self.imageButton];
    
//    NSString *user_name =  [self.userDic[USNameKey] stringByAppendingString:@" "];
#warning DEMO statik icerik
    self.nameLabel.text = [@"Husameddin Yivlik" capitalizedString];
    
    self.notificationsButton = [[[NSBundle mainBundle] loadNibNamed:@"USBadgeView" owner:self options:0] objectAtIndex:0];
    self.notificationsButton.delegate = self;
    self.notificationsButton.segueName = @"UnderConstructionSegue";
    self.notificationsButton.tag = 101;
    [self.notificationsButton setMode:notHighlightedNoBadgeTitleNoShadow];
    [self.notificationsButton updateLogoWithImage:[UIImage imageNamed:@"66.png"]];
    self.notificationsButton.frame = self.notificationsView.bounds;
    [self.notificationsButton updateTitle:@"HABERLER"];
    [self.notificationsButton updateTitleFontSize:10];
    [self.notificationsButton shiftTitleLabel];
    [self.notificationsView addSubview:self.notificationsButton];
    
    
    self.productsButton = [[[NSBundle mainBundle] loadNibNamed:@"USBadgeView" owner:self options:0] objectAtIndex:0];
    self.productsButton.delegate = self;
    self.productsButton.segueName = @"UnderConstructionSegue";
    self.productsButton.tag = 102;
    [self.productsButton setBadgeSize:badgeMedium];
    [self.productsButton updateLogoWithImage:[UIImage imageNamed:@"65.png"]];
    [self.productsButton setMode:notHighlightedNoBadgeTitleNoShadow];
    self.productsButton.frame = self.productsView.bounds;
    [self.productsButton updateTitle:@"ÜRÜNLERİM"];
    [self.productsButton updateTitleFontSize:10];
    [self.productsView addSubview:self.productsButton];
    
    
    self.settingsButton = [[[NSBundle mainBundle] loadNibNamed:@"USBadgeView" owner:self options:0] objectAtIndex:0];
    self.settingsButton.delegate = self;
    self.settingsButton.segueName = @"UnderConstructionSegue";
    self.settingsButton.tag = 103;
    [self.settingsButton updateLogoWithImage:[UIImage imageNamed:@"64.png"]];
    [self.settingsButton setMode:notHighlightedNoBadgeTitleNoShadow];
    self.settingsButton.frame = self.settingsView.bounds;
    [self.settingsButton updateTitle:@"AYARLAR"];
    [self.settingsButton updateTitleFontSize:10];
    [self.settingsView addSubview:self.settingsButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateProductsBadgeWithProductCount:17];
    [self updateNotificationsBadgeWithProductCount:4];
    
    [self updateProfileImage];
}

- (void)updateNotificationsBadgeWithProductCount:(NSInteger)notificationsCount {
    [self.notificationsButton setMode:highlightedNotMovingbadgeTitleNoShadow];
    [self.notificationsButton setTotalRotationValue:0];
    [self.notificationsButton showCounterWithNumber:notificationsCount];
    
    
    if (notificationsCount == 0){
        [self.notificationsButton setMode:notHighlightedNoBadgeTitleNoShadow];
        
    }
}

- (void)updateProductsBadgeWithProductCount:(NSInteger)productcount {
    
    [self.productsButton setMode:highlightedNotMovingbadgeTitleNoShadow];
    [self.productsButton setTotalRotationValue:0];
    [self.productsButton showCounterWithNumber:productcount];
    
    if (productcount == 0){
        [self.notificationsButton setMode:notHighlightedNoBadgeTitleNoShadow];
        
    }
}

- (void)updateProfileImage {
    UIImage *image = self.userDic[USImage];
#warning DEMO statik icerik
//    if (image) {
        [self.imageButton updateLogoWithImage:[UIImage imageNamed:@"hv.jpg"]];
//    }
}

- (void)buttonDidPress:(USBadgeView *)menuView {
    [self performSegueWithIdentifier:@"UnderConstructionSegue"
                              sender:self];
}
@end
