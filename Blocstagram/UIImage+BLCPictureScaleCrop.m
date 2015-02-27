//
//  UIImage+BLCPictureScaleCrop.m
//  Blocstagram
//
//  Created by Peter Gow on 25/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "UIImage+BLCPictureScaleCrop.h"
#import "UIImage+BLCImageUtilities.h"
#import <AVFoundation/AVFoundation.h>
#import "BLCCameraViewController.h"
#import "BLCCameraToolbar.h"

@implementation UIImage (BLCPictureScaleCrop)

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect {
	
	AVCaptureConnection *videoConnection;
	
	// Find the right connection object
	for (AVCaptureConnection *connection in self.stillImageOutputCategory.connections) {
		for (AVCaptureInputPort *port in connection.inputPorts) {
			if ([port.mediaType isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) { break; }
	}
	
	[self.stillImageOutputCategory captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
		if (imageSampleBuffer) {
			NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
			UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
			image = [image imageWithFixedOrientation];
			image = [image imageResizedToMatchAspectRatioOfSize:self.captureVideoPreviewLayerCategory.bounds.size];
			
			UIView *leftLine = self.verticalLines.firstObject;
			UIView *rightLine = self.verticalLines.lastObject;
			UIView *topLine = self.horizontalLines.firstObject;
			UIView *bottomLine = self.horizontalLines.lastObject;
			
			CGRect gridRect = CGRectMake(CGRectGetMinX(leftLine.frame),
																	 CGRectGetMinY(topLine.frame),
																	 CGRectGetMaxX(rightLine.frame) - CGRectGetMinX(leftLine.frame),
																	 CGRectGetMinY(bottomLine.frame) - CGRectGetMinY(topLine.frame));
			
			CGRect cropRect = gridRect;
			cropRect.origin.x = (CGRectGetMinX(gridRect) + (image.size.width - CGRectGetWidth(gridRect)) / 2);
			
			image = [image imageCroppedToRect:cropRect];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.delegate cameraViewController:self didCompleteWithImage:image];
			});
		} else {
			dispatch_async(dispatch_get_main_queue(), ^{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK button") otherButtonTitles:nil];
				[alert show];
			});
			
		}
	}];
	
}

@end
