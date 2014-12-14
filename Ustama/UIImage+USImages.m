//
//  USImages.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//


#import "UIImage+USImages.h"

@implementation UIImage (USCategory)

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    if (!strEncodeData) return nil;
    
	NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
	return [UIImage imageWithData:data];
}

+ (UIImage *)imageWithView:(UIView *)view {
    if (!view) return nil;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
	
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return img;
}

+ (UIImage *)resizeImageForUpload:(UIImage *)image {
    if (!image) return nil;
    
	UIImage *result = [[UIImage alloc]init];
	
	if (image.size.width < image.size.height) {
		if (image.size.width > 300) {
			double height = image.size.height/(image.size.width/300);
			result = [UIImage imageWithImage:image scaledToSize:CGSizeMake(300, height)];
		}else
			return image;
	} else {
		if (image.size.width > 300) {
			double width = image.size.width/(image.size.height/300);
			result = [UIImage imageWithImage:image scaledToSize:CGSizeMake(width, 300)];
		}else
			return image;
	}
	return result;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if (!image) return nil;
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)fixOrientation:(UIImage *)imageToFix {
	
    // No-op if the orientation is already correct
    if (imageToFix.imageOrientation == UIImageOrientationUp) return imageToFix;
	
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
	
    switch (imageToFix.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
        transform = CGAffineTransformTranslate(transform, imageToFix.size.width, imageToFix.size.height);
        transform = CGAffineTransformRotate(transform, M_PI);
        break;
        
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        transform = CGAffineTransformTranslate(transform, imageToFix.size.width, 0);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        break;
        
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        transform = CGAffineTransformTranslate(transform, 0, imageToFix.size.height);
        transform = CGAffineTransformRotate(transform, -M_PI_2);
        break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
        break;
    }
	
    switch (imageToFix.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
        transform = CGAffineTransformTranslate(transform, imageToFix.size.width, 0);
        transform = CGAffineTransformScale(transform, -1, 1);
        break;
        
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
        transform = CGAffineTransformTranslate(transform, imageToFix.size.height, 0);
        transform = CGAffineTransformScale(transform, -1, 1);
        break;
        case UIImageOrientationUp:
        case UIImageOrientationLeft:
        case UIImageOrientationDown:
        case UIImageOrientationRight:
        break;
    }
	
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, imageToFix.size.width, imageToFix.size.height,
                                             CGImageGetBitsPerComponent(imageToFix.CGImage), 0,
                                             CGImageGetColorSpace(imageToFix.CGImage),
                                             CGImageGetBitmapInfo(imageToFix.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (imageToFix.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        // Grr...
        CGContextDrawImage(ctx, CGRectMake(0,0,imageToFix.size.height,imageToFix.size.width), imageToFix.CGImage);
        break;
        
        default:
        CGContextDrawImage(ctx, CGRectMake(0,0,imageToFix.size.width,imageToFix.size.height), imageToFix.CGImage);
        break;
    }
	
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (NSString *)encodeToBase64 {
	return [UIImagePNGRepresentation(self) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
