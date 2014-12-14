//
//  USRegisterFinishViewController.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USRegisterFinishViewController.h"

#import "UstaRegisterContactInfoView.h"

@interface USRegisterFinishViewController () <CompletionDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView                *contentScroller;
@property (strong, nonatomic) UstaRegisterContactInfoView *registerView;

@end

@implementation USRegisterFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUIElements];
}

- (void)dealloc {
    self.contentScroller.delegate = nil;
}

- (void)loadUIElements {
    [super loadUIElements];
    self.registerView = [[[NSBundle mainBundle] loadNibNamed:@"UstaRegisterContactInfoView" owner:self options:nil] objectAtIndex:0];
    _registerView.delegate = self;

    _registerView.frame = CGRectMake(0, 0, self.view.frame.size.width, _registerView.frame.size.height);
    [self.contentScroller addSubview:_registerView];
    self.contentScroller.contentSize = CGSizeMake(_registerView.frame.size.width, _registerView.frame.size.height);
}

- (void)ustamDictionaryCompleted:(NSDictionary *)dic {
    [self showBlackView:@"Bilgileriniz yollanıyor"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (dic) {
            [self.infoDictionary setValuesForKeysWithDictionary:dic];
        }
        [[USUserManager getInstance] saveCustomObject:self.infoDictionary];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closeKeyboard];
}


- (void)pickPhoto {
    [self openBottomMenuView];
}



- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [super imagePickerController:picker didFinishPickingMediaWithInfo:info];
    UIImage *image = [UIImage fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
    
    [self.registerView ustaImageAdded:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [super imagePickerControllerDidCancel:picker];
}
@end
