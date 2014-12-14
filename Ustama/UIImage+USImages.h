//
//  USImages.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (USImages)

+ (UIImage *)fixOrientation:(UIImage *)imageToFix;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)resizeImageForUpload:(UIImage *)image;

+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

- (NSString *)encodeToBase64;

@end
