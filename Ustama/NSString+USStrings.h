//
//  NSString+USStrings.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (USStrings)

- (BOOL)isValidNumeric;
- (BOOL)isValidMail;
- (BOOL)isValidPhoneNumber;

@end
