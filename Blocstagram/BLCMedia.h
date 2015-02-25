//
//  BLCMedia.h
//  Blocstagram
//
//  Created by Peter Gow on 30/10/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLCLikeButton.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BLCMediaDownloadState) {
	BLCMediaDownloadStateNeedsImage             = 0,
	BLCMediaDownloadStateDownloadInProgress     = 1,
	BLCMediaDownloadStateNonRecoverableError    = 2,
	BLCMediaDownloadStateHasImage               = 3
};


@class BLCUser;
@class BLCComment;

@interface BLCMedia : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BLCMediaDownloadState downloadState;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) BLCLikeState likeState;
@property (nonatomic, strong) NSString *temporaryComment;

 - (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;

@end
