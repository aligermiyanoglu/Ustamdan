//
//  NSString+USStrings.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "NSString+USStrings.h"

@implementation NSString (USStrings)


- (BOOL)isValidMail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
 
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidNumeric {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:self];
    
    return (number != nil); // If the string is not numeric, number will be nil
}

- (BOOL)isValidPhoneNumber {
    return YES;
}

@end
