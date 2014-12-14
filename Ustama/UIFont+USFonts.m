//
//  UIFont+USFonts.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 13/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "UIFont+USFonts.h"

@implementation UIFont (USFonts)

+ (UIFont *)smallFont {
    return [UIFont fontWithName:@"Helvetica" size:14];
}

+ (UIFont *)mediumFont {
    return [UIFont fontWithName:@"Helvetica" size:16];
}

+ (UIFont *)bigFont {
    return [UIFont fontWithName:@"Helvetica" size:18];
}

+ (UIFont *)fontWithSize:(NSInteger)fontSize {
    return [UIFont fontWithName:@"Helvetica" size:fontSize];
};

@end
