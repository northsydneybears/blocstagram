//
//  BLCImageLibraryViewController.m
//  Blocstagram
//
//  Created by Peter Gow on 27/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import "BLCImageLibraryViewController.h"
#import "BLCCropImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface BLCImageLibraryViewController () <BLCCropImageViewControllerDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ALAssetsLibrary *library;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *arraysOfAssets;

@end

@implementation BLCImageLibraryViewController

- (instancetype) init {
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(100, 100);
 
	self = [super initWithCollectionViewLayout:layout];
	
	if (self) {
		self.library = [[ALAssetsLibrary alloc] init];
		self.groups = [NSMutableArray array];
		self.arraysOfAssets = [NSMutableArray array];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	
	//"Supplementary views" are the header and footer that Apple allows you to optionally add into groups in a Collection View
	[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusable view"];
	
	self.collectionView.backgroundColor = [UIColor whiteColor];
	
	UIImage *cancelImage = [UIImage imageNamed:@"x"];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:cancelImage style:UIBarButtonItemStyleDone target:self action:@selector(cancelPressed:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void) cancelPressed:(UIBarButtonItem *)sender {
	[self.delegate imageLibraryViewController:self didCompleteWithImage:nil];
}

- (void) viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	
	CGFloat width = CGRectGetWidth(self.view.frame);
	//CGFloat minWidth = 100;
	//NSInteger divisor = width / minWidth;
	//CGFloat cellSize = width / divisor;
	
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
	//flowLayout.itemSize = CGSizeMake(cellSize, cellSize);
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;
	flowLayout.headerReferenceSize = CGSizeMake(width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
			sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	return CGSizeMake(88,80);
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.groups removeAllObjects];
	[self.arraysOfAssets removeAllObjects];
	
	[self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos | ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
		if (group) {
			[self.groups addObject:group];
			NSMutableArray *assets = [NSMutableArray array];
			[self.arraysOfAssets addObject:assets];
			
			[group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
				if (result) {
					[assets addObject:result];
				}
			}];
			
			[self.collectionView reloadData];
		}
	} failureBlock:^(NSError *error) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK button") otherButtonTitles:nil];
		[alert show];
		
		[self.collectionView reloadData];
	}];
}

	//Clear the images off the screen when they're no longer being displayed in order to save memory
- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self.groups removeAllObjects];
	[self.arraysOfAssets removeAllObjects];
	[self.collectionView reloadData];
}

	//Just like UITableView, you need to tell the collection view how many sections there are...
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return self.groups.count;
}

	//...as well as how many items are in each section
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSArray *imagesArray = self.arraysOfAssets[section];
	
	if (imagesArray) {
		return imagesArray.count;
	}
	
	return 0;
}

	//Given a section and a row (in the form of an NSIndexPath), produce a UICollectionViewCell for the collection view to display on the screen
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	static NSInteger imageViewTag = 54321;
	
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	
	UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
	
	if (!imageView) {
		imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
		imageView.tag = imageViewTag;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		[cell.contentView addSubview:imageView];
	}
	
	//Our cell will contain one simple image view, which takes up the entire cell and contains the image's thumbnail
	ALAsset *asset = self.arraysOfAssets[indexPath.section][indexPath.row];
	CGImageRef imageRef = asset.thumbnail;
	
	UIImage *image;
	
	if (imageRef) {
		image = [UIImage imageWithCGImage:imageRef];
	}
	
	imageView.image = image;
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusable view" forIndexPath:indexPath];
 
	if ([kind isEqual:UICollectionElementKindSectionHeader]) {
		static NSInteger headerLabelTag = 2468;
		
		UILabel *label = (UILabel *)[view viewWithTag:headerLabelTag];
		
		if (!label) {
			label = [[UILabel alloc] initWithFrame:view.bounds];
			label.tag = headerLabelTag;
			label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
			label.textAlignment = NSTextAlignmentCenter;
			
			label.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:235/255.0f alpha:1.0f];
			
			[view addSubview:label];
		}
		
		ALAssetsGroup *group = self.groups[indexPath.section];
		
		//Use any color you want or skip defining it
		UIColor* textColor = [UIColor colorWithWhite:0.35 alpha:1];
		
		NSDictionary *textAttributes = @{NSForegroundColorAttributeName : textColor,
																		 NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:14],
																		 NSTextEffectAttributeName : NSTextEffectLetterpressStyle};
		
		NSAttributedString* attributedString;
		
		
		NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
		
		if (groupName) {
			attributedString = [[NSAttributedString alloc] initWithString:groupName attributes:textAttributes];
		}
		
		label.attributedText = attributedString;
	}
	
	return view;
}

	//When the user taps a thumbnail, get the full resolution image and pass it to the crop controller
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	ALAsset *asset = self.arraysOfAssets[indexPath.section][indexPath.row];
	ALAssetRepresentation *representation = asset.defaultRepresentation;
	CGImageRef imageRef = representation.fullResolutionImage;
	
	UIImage *imageToCrop;
	
	if (imageRef) {
		imageToCrop = [UIImage imageWithCGImage:imageRef scale:representation.scale orientation:(UIImageOrientation)representation.orientation];
	}
 
	BLCCropImageViewController *cropVC = [[BLCCropImageViewController alloc] initWithImage:imageToCrop];
	cropVC.delegate = self;
	[self.navigationController pushViewController:cropVC animated:YES];
}

#pragma mark - BLCCropImageViewControllerDelegate

	//If the user crops an image, inform the image library controller's delegate
- (void) cropControllerFinishedWithImage:(UIImage *)croppedImage {
	[self.delegate imageLibraryViewController:self didCompleteWithImage:croppedImage];
}

@end
