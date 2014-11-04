//
//  BLCMedia.h
//  Blocstagram
//
//  Created by Peter Gow on 30/10/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLCUser;
@class BLCComment;

@interface BLCMedia : NSObject

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) BLCComment *caption;
@property (nonatomic, strong) NSArray *comments;

@end
