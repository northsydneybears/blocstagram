//
//  BLCMediaTableViewCell.h
//  Blocstagram
//
//  Created by Peter Gow on 1/11/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCDataSource.h"

@class BLCMedia, BLCMediaTableViewCell, BLCDataSource;

@protocol BLCMediaTableViewCellDelegate <NSObject>

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

@end

@interface BLCMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) BLCMedia *mediaItem;
@property (nonatomic, weak) id <BLCMediaTableViewCellDelegate> delegate;

+(CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

@end
