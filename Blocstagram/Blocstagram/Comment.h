//
//  Comment.h
//  Blocstagram
//
//  Created by Carlos Calderon on 11/10/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Comment : NSObject

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;

@end