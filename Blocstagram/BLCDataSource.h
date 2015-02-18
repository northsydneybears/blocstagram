//
//  BLCDataSource.h
//  Blocstagram
//
//  Created by Peter Gow on 30/10/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDataSource : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

- (void) deleteMediaItem:(BLCMedia *)item;
- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;

+(NSString *) instagramClientID;

@end
