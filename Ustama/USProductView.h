//
//  USProductView.h
//  Ustama
//
//  Created by Ali Germiyanoglu on 14/12/14.
//  Copyright (c) 2014 Ali Germiyanoglu. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol DeletionDelegate  <NSObject>

- (void)onDelete:(NSInteger)tag;

@end

@interface USProductView : UIView

@property (nonatomic, weak) id <DeletionDelegate> delegate;

- (void)setImage:(UIImage *)image;


@end
