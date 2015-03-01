//
//  BLCFiltersCollectionViewCell.h
//  Blocstagram
//
//  Created by Peter Gow on 1/03/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCFiltersCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat thumbnailSize;

@end
