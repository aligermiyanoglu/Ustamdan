//
//  USRegisterUstaViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USRegisterUstaViewController.h"
#import "UstaRegister.h"
#import "UstaRegisterContactInfoView.h"
#import "USRegisterFinishViewController.h"

@interface USRegisterUstaViewController () <DoneDelegate, CompletionDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroller;


@property (strong, nonatomic) UIImage             *ustaImage;
@property (strong, nonatomic) NSMutableDictionary *infoDictionary;
@property (strong, nonatomic) UstaRegister        *registerView;

@end

@implementation USRegisterUstaViewController

- (void)dealloc {
    self.contentScroller.delegate = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController class] == [USRegisterFinishViewController class]) {
        USRegisterFinishViewController *destinationController = segue.destinationViewController;
        
        if (self.ustaImage) {
            [self.infoDictionary setObject:self.ustaImage
                                    forKey:USImage];
        }
        destinationController.infoDictionary = self.infoDictionary;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadUIElements];
}

- (void)loadUIElements {
    [super loadUIElements];
    
    self.registerView = [[[NSBundle mainBundle] loadNibNamed:@"UstaRegister" owner:self options:nil] objectAtIndex:0];
    _registerView.delegate = self;
    self.registerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.registerView.frame.size.height);
    [self.contentScroller addSubview:_registerView];
    self.contentScroller.contentSize = CGSizeMake(_registerView.frame.size.width, _registerView.frame.size.height);
}

- (void)ustamDictionary:(NSMutableDictionary *)dic {
    self.infoDictionary = dic;
    [self performSegueWithIdentifier:@"ContinueSegue"
                              sender:self];
}

- (void)pickPhoto {
    [self openBottomMenuView];
}

- (void)ustamDictionaryCompleted:(NSDictionary *)dic {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closeKeyboard];
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [super imagePickerController:picker didFinishPickingMediaWithInfo:info];
    self.ustaImage = [UIImage fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
    
    [self.registerView ustaImageUpdated:self.ustaImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [super imagePickerControllerDidCancel:picker];
}
@end
