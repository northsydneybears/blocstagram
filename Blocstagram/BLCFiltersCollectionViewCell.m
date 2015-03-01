//
//  BLCFiltersCollectionViewCell.m
//  Blocstagram
//
//  Created by Peter Gow on 1/03/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "BLCFiltersCollectionViewCell.h"

@implementation BLCFiltersCollectionViewCell

-(id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	static NSInteger imageViewTag = 1000;
	static NSInteger labelTag = 1001;
	
	self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.thumbnailSize, self.thumbnailSize)];
	self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
	self.thumbnail.tag = imageViewTag;
	self.thumbnail.clipsToBounds = YES;
	
	[self.contentView addSubview:self.thumbnail];
	
	self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.thumbnailSize, self.thumbnailSize, 20)];
	self.label.textAlignment = NSTextAlignmentCenter;
	self.label.tag = labelTag;
	self.label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
	
	[self.contentView addSubview:self.label];
	
	return self;
}

@end
