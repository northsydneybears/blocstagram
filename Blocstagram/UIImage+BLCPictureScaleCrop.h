//
//  UIImage+BLCPictureScaleCrop.h
//  Blocstagram
//
//  Created by Peter Gow on 25/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (BLCPictureScaleCrop)

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutputCategory;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayerCategory;


@end
