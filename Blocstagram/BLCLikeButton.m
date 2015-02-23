//
//  BLCLikeButton.m
//  Blocstagram
//
//  Created by Peter Gow on 21/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "BLCLikeButton.h"
#import "BLCCircleSpinnerView.h"

#define kLikedStateImage @"heart-full"
#define kUnlikedStateImage @"heart-empty"

@interface BLCLikeButton ()

@property (nonatomic, strong) BLCCircleSpinnerView *spinnerView;

@end

@implementation BLCLikeButton

- (instancetype) init {
	self = [super init];
	
	if (self) {
		self.spinnerView = [[BLCCircleSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		[self addSubview:self.spinnerView];
		
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		
		self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
		self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
		
		self.likeButtonState = BLCLikeStateNotLiked;
	}
	
	return self;
}

- (void) layoutSubviews {
	[super layoutSubviews];
	self.spinnerView.frame = self.imageView.frame;
}

- (void) setLikeButtonState:(BLCLikeState)likeState {
	_likeButtonState = likeState;
	
	NSString *imageName;
	
	switch (_likeButtonState) {
		case BLCLikeStateLiked:
		case BLCLikeStateUnliking:
			imageName = kLikedStateImage;
			break;
			
		case BLCLikeStateNotLiked:
		case BLCLikeStateLiking:
			imageName = kUnlikedStateImage;
	}
	
	switch (_likeButtonState) {
		case BLCLikeStateLiking:
		case BLCLikeStateUnliking:
			self.spinnerView.hidden = NO;
			self.userInteractionEnabled = NO;
			break;
			
		case BLCLikeStateLiked:
		case BLCLikeStateNotLiked:
			self.spinnerView.hidden = YES;
			self.userInteractionEnabled = YES;
	}
 
 
	[self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
 
	if (self) {
		self.likeButtonState = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(likeButtonState))];
	}
 
	return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInteger:self.likeButtonState forKey:NSStringFromSelector(@selector(likeButtonState))];
}

@end