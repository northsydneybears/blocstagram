//
//  BLCMediaTableViewCell.h
//  Blocstagram
//
//  Created by Peter Gow on 1/11/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;
@interface BLCMediaTableViewCell : UITableViewCell
@property (nonatomic, strong) BLCMedia *mediaItem;

+(CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

@end
