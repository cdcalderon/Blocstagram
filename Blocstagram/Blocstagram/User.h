//
//  User.h
//  Blocstagram
//
//  Created by Carlos Calderon on 11/10/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject
    @property (nonatomic, strong) NSString *idNumber;
    @property (nonatomic, strong) NSString *userName;
    @property (nonatomic, strong) NSString *fullName;
    @property (nonatomic, strong) NSURL *profilePictureURL;
    @property (nonatomic, strong) UIImage *profilePicture;

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;
@end
