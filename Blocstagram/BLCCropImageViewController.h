//
//  BLCCropImageViewController.h
//  Blocstagram
//
//  Created by Peter Gow on 27/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "BLCMediaFullScreenViewController.h"
#import <UIKit/UIKit.h>

@class BLCCropImageViewController;

@protocol BLCCropImageViewControllerDelegate <NSObject>

- (void) cropControllerFinishedWithImage:(UIImage *)croppedImage;

@end

@interface BLCCropImageViewController : BLCMediaFullScreenViewController

- (instancetype) initWithImage:(UIImage *)sourceImage;

@property (nonatomic, weak) NSObject <BLCCropImageViewControllerDelegate> *delegate;

@end
