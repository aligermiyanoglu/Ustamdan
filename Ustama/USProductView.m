
//
//  USProductView.m
//  Ustama
//
//  Created by Ali Germiyanoglu on 14/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import "USProductView.h"


@interface USProductView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation USProductView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)removeDidPress:(id)sender {
    [self removeFromSuperview];
    
    if ([[self delegate] respondsToSelector:@selector(onDelete:)]) {
        [[self delegate] onDelete:self.tag];
    }
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
