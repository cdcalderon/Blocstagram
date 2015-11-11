//
//  DataSource.h
//  Blocstagram
//
//  Created by Carlos Calderon on 11/10/15.
//  Copyright (c) 2015 Carlos Calderon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;
@end