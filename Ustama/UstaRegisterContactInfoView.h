//
//  UstaRegisterContactInfoView.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const USLocationKey;
extern NSString *const USHandmadeKey;
extern NSString *const USuseCarierKey;
extern NSString *const USOnlineSellKey;
extern NSString *const USisMemberKey;
extern NSString *const USSingleStcKey;

@protocol CompletionDelegate  <NSObject>

- (void)pickPhoto;
- (void)ustamDictionaryCompleted:(NSDictionary *)dic;

@end


@interface UstaRegisterContactInfoView : UIView

@property (nonatomic, weak) id <CompletionDelegate>delegate;

- (void)ustaImageAdded:(UIImage *)image;

@end
