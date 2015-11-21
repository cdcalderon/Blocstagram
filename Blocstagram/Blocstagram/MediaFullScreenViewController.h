//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Carlos Calderon on 11/19/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

@end