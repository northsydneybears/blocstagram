//
//  BLCCropImageViewController.m
//  Blocstagram
//
//  Created by Peter Gow on 27/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "BLCCropImageViewController.h"
#import "BLCMedia.h"
#import "BLCCropBox.h"
#import "UIImage+BLCImageUtilities.h"

@interface BLCCropImageViewController ()

@property (nonatomic, strong) BLCCropBox *cropBox;
@property (nonatomic, assign) BOOL hasLoadedOnce;
@property (nonatomic, strong) UIToolbar *topView;
@property (nonatomic, strong) UIToolbar *bottomView;

@end

@implementation BLCCropImageViewController

- (instancetype) initWithImage:(UIImage *)sourceImage {
	self = [super init];
	
	if (self) {
		self.media = [[BLCMedia alloc] init];
		self.media.image = sourceImage;
		
		self.cropBox = [BLCCropBox new];
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.clipsToBounds = YES;
	
	[self.view addSubview:self.cropBox];
	
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Crop", @"Crop command") style:UIBarButtonItemStyleDone target:self action:@selector(cropPressed:)];
	
	self.navigationItem.title = NSLocalizedString(@"Crop Image", nil]);
	self.navigationItem.rightBarButtonItem = rightButton;
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
	
	self.topView = [UIToolbar new];
	self.bottomView = [UIToolbar new];
	UIColor *redBG = [UIColor redColor];
	self.topView.barTintColor = redBG;
	self.bottomView.barTintColor = redBG;
	self.topView.alpha = 0.5;
	self.bottomView.alpha = 0.5;
	
	[self.view addSubview:self.topView];
	[self.view addSubview:self.bottomView];
}

- (void) viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
 
	CGRect cropRect = CGRectZero;
 
	CGFloat edgeSize = MIN(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
	cropRect.size = CGSizeMake(edgeSize, edgeSize);
	
	CGSize size = self.view.frame.size;
	
	self.cropBox.frame = cropRect;
	self.cropBox.center = CGPointMake(size.width / 2, size.height / 2);
	self.scrollView.frame = self.cropBox.frame;
	self.scrollView.clipsToBounds = NO;
	
	[self recalculateZoomScale];
	
	CGFloat width = CGRectGetWidth(self.view.bounds);
	self.topView.frame = CGRectMake(0, self.topLayoutGuide.length, width, 44);
	
	CGFloat yOriginOfBottomView = CGRectGetMaxY(self.topView.frame) + width;
	CGFloat heightOfBottomView = CGRectGetHeight(self.view.frame) - yOriginOfBottomView;
	self.bottomView.frame = CGRectMake(0, yOriginOfBottomView, width, heightOfBottomView);
	
	if (self.hasLoadedOnce == NO) {
		self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
		self.hasLoadedOnce = YES;
	}
}

- (void) cropPressed:(UIBarButtonItem *)sender {
	CGRect visibleRect;
	float scale = 1.0f / self.scrollView.zoomScale / self.media.image.scale;
	visibleRect.origin.x = self.scrollView.contentOffset.x * scale;
	visibleRect.origin.y = self.scrollView.contentOffset.y * scale;
	visibleRect.size.width = self.scrollView.bounds.size.width * scale;
	visibleRect.size.height = self.scrollView.bounds.size.height * scale;
	
	UIImage *scrollViewCrop = [self.media.image imageWithFixedOrientation];
	scrollViewCrop = [scrollViewCrop imageCroppedToRect:visibleRect];
	
	[self.delegate cropControllerFinishedWithImage:scrollViewCrop];
}

@end
