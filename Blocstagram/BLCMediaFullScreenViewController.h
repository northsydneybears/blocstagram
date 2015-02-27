//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Peter Gow on 24/11/2014.
//  Copyright (c) 2014 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) BLCMedia *media;

- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;
- (void) recalculateZoomScale;

@end