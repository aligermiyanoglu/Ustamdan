//
//  UstaRegister.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const USNameKey;
extern NSString *const USSurnameKey;
extern NSString *const USEmailKey;
extern NSString *const USAgeKey;
extern NSString *const USPhoneKey;
extern NSString *const USAddressKey;
extern NSString *const USStoryKey;
extern NSString *const USProfessionKey;
extern NSString *const USImage;

@protocol DoneDelegate  <NSObject>

- (void)pickPhoto;
- (void)ustamDictionary:(NSMutableDictionary *)dic;

@end

@interface UstaRegister : UIView

@property (nonatomic, weak) id <DoneDelegate>delegate;

- (void)ustaImageUpdated:(UIImage *)image;

@end
