//
//  Media.h
//  Blocstagram
//
//  Created by Carlos Calderon on 11/6/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class User;

@interface Media : NSObject

@property (nonatomic,strong) NSString *idNumber;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) NSURL *mediaURL;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *caption;
@property (nonatomic,strong) NSArray *comments;

@end
