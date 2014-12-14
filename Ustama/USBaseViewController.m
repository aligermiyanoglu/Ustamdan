//
//  USBaseViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USBaseViewController.h"
#import "Reachability.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface USBaseViewController () <MenuButtonsDelegate>

@property (nonatomic, strong) UIView           *blackView;
@property (nonatomic, strong) UILabel          *blackViewLabel;
@property (nonatomic, strong) USBottomMenuView *bottomMenuView;

@property (nonatomic) UIImagePickerController *imagePickerController;



@property (nonatomic, weak) UITextField *activeField;

@property (nonatomic, weak) IBOutlet UITextField *mailField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;

@end

@implementation USBaseViewController

- (NSString *)description {
    return NSStringFromClass([self class]);
}

- (void)internalInit {
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self internalInit];
    }
    return self;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad",self);
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:119/255. green:192/255. blue:213/155. alpha:1.0];
    [self loadLocalizedStrings];
    [self loadUIElements];
}

- (void)loadUIElements {
    if (!self.bottomMenuView) {
        self.bottomMenuView = [[[NSBundle mainBundle] loadNibNamed:@"USBottomMenuView" owner:self options:0] objectAtIndex:0];
        self.bottomMenuView.delegate = self;
        self.bottomMenuView.frame = self.view.bounds;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear",self);
    
    [self registerForKeyboardNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear",self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear",self);
    
    [self removeForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear",self);
}


#pragma mark -

- (void)loadLocalizedStrings {
    
}


#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self closeKeyboard];
}


#pragma mark -

- (void)closeKeyboard {
    [self.view endEditing:YES];
}

- (void)showBlackView:(NSString *)labelText {
    //50 is the height for refreshButton Label
    //added to close title Bar with BlackView
    self.view.userInteractionEnabled = NO;
    if (_blackView == nil) {
        self.blackView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.blackView.backgroundColor = [UIColor clearColor];
        self.blackView.center = self.view.center;
        
        UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.3;
        backView.center = self.view.center;
        [self.blackView addSubview:backView];
        
        UIView *rectView= [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
        rectView.center = self.view.center;
        rectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        rectView.clipsToBounds = YES;
        rectView.layer.cornerRadius = 10.0;
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.frame = CGRectMake(65, 40, activityIndicator.bounds.size.width, activityIndicator.bounds.size.height);
        [activityIndicator startAnimating];
        if (labelText.length <= 0)
            activityIndicator.center = CGPointMake(rectView.frame.size.width/2, rectView.frame.size.height/2);
        
        [rectView addSubview:activityIndicator];
        
        self.blackViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 140, 44)];
        self.blackViewLabel.backgroundColor = [UIColor clearColor];
        self.blackViewLabel.textColor = [UIColor whiteColor];
        self.blackViewLabel.minimumScaleFactor = 0.6;
        self.blackViewLabel.numberOfLines = 0;
        self.blackViewLabel.adjustsFontSizeToFitWidth = YES;
        self.blackViewLabel.textAlignment = NSTextAlignmentCenter;
        self.blackViewLabel.center = CGPointMake(rectView.frame.size.width/2, self.blackViewLabel.center.y);
        [self.blackViewLabel setFont:[UIFont mediumFont]];
        [rectView addSubview:self.blackViewLabel];
        
        [self.blackView addSubview:rectView];
    }
    self.blackViewLabel.text = labelText;
    [self.view addSubview:self.blackView];
    
    
    //For demo purposes
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self removeBlackView];
    });
}

- (void)removeBlackView {
    [self.blackView removeFromSuperview];
    self.blackView = nil;
    self.view.userInteractionEnabled = YES;
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


#pragma mark - Reachability

- (BOOL)checkReachability {
    //    Reachability *networkCheck = [Reachability reachabilityForLocalWiFi];
    //    if (networkCheck.currentReachabilityStatus != ReachableViaWiFi) {
    //        return FALSE;
    //    }
    //
    //    return TRUE;
    Reachability*wifiReach = [Reachability reachabilityForLocalWiFi];
    Reachability*threeGReach = [Reachability reachabilityForInternetConnection];
    if (wifiReach == NULL)
        return NO;
    
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    NetworkStatus threeGStatus = [threeGReach currentReachabilityStatus];
    
    if (netStatus!=ReachableViaWiFi && threeGStatus != ReachableViaWWAN)
    {
        return NO;
    }
    return YES;
}


#pragma mark - Keyboard Notification Methods

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)removeForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint activeFieldBottomLeftCorner = CGPointMake(self.activeField.frame.origin.x, self.activeField.frame.origin.y+self.activeField.frame.size.height);
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         
                         if (!CGRectContainsPoint(aRect, activeFieldBottomLeftCorner) ) {
                             CGFloat heightExceptKeyboard= (self.view.frame.size.height - kbSize.height);
                             CGFloat dif = self.activeField.frame.origin.y - heightExceptKeyboard;
                             CGFloat shiftAmount = dif + self.activeField.frame.size.height;
                             self.view.center = CGPointMake(self.view.center.x, self.view.center.y-shiftAmount);
                         }
                     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.2
                     animations:^(void) {
                         self.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
                     }];
}


#pragma mark -
#pragma mark - Network Notification Methods

- (void)networkStatusChanged:(NSNotification *)notificationNote {
    Reachability *reachability = [notificationNote object];
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == ReachableViaWWAN) {
        NSLog(@"ReachableViaWWAN");
    }
    else if (status == ReachableViaWiFi) {
        NSLog(@"ReachableViaWiFi");
        
    }
    else if (status == NotReachable) {
        NSLog(@"NotReachable");
    }
}

- (void)registerForNetworkNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkStatusChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
}

- (void)removeForNetworkNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
}

#pragma mark - Bottom Menu Methods

- (void)openBottomMenuView {
    self.bottomMenuView.delegate = self;
    [self setMode:twoRow];
    
    [self.bottomMenuView openMenuView];
}

- (void)closeBottomMenuView {
    [self.bottomMenuView closeMenuView];
}

//- (void)setEnabledBottomMenuLocationButton:(BOOL)isEnabled {
//    [self.bottomMenuView setIsLocationButtonEnabled:isEnabled];
//}
- (void)setMode:(BottomMenuMode)mode {
    [self.bottomMenuView setMode:mode];
}

- (void)removeProfilePhoto{
    
}


#pragma mark - Bottom Menu Delegate Methods
//openCamera = 0,
//pickPhoto = 1,
//pickVideo = 2,
//shareLoc = 3,
//cancel = 4
- (void)bottomMenuView:(USBottomMenuView *)menuView didCloseWithPressedButtonTag:(MenuButtonValues)buttonVal {
    NSLog(@"val:%i",buttonVal);
    
    switch (buttonVal) {
        case openCamera: {
            [self openCameraShootViewController];
            break;
        }
        case pickVideo: {
            [self openVideoPickerViewController];
            break;
        }
        case pickPhoto: {
            [self openImagePickerViewController];
            break;
        }
        case removePhoto: {
            [self removeProfilePhoto];
            break;
        }
        case shareLoc: {
            
            break;
        }
        default:
            break;
    }
}


#pragma mark - Pickers

- (void)showPickerForContent:(NSString *)contentStr {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.mediaTypes = @[contentStr];
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)openImagePickerViewController {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    //[self showPickerForContent:(NSString *)kUTTypeImage];
}

- (void)openVideoPickerViewController {
#pragma dikkat
    [self showPickerForContent:(NSString *)kUTTypeMovie];
}

- (void)openCameraShootViewController {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    [imagePickerController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = YES;
        if ([self.bottomMenuView getMode] == twoRow) {
            imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage];
            if ([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront ]) {
                imagePickerController.cameraDevice =  UIImagePickerControllerCameraDeviceFront;
            }
        }
        else{
            imagePickerController.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeImage];
        }
        //		imagePickerController.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeImage];
        [imagePickerController setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //    self.profileImage = [UIImage fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
    //    self.user.photoData = UIImagePNGRepresentation(self.profileImage);
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

@end
