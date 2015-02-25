//
//  BLCCameraToolbar.h
//  Blocstagram
//
//  Created by Peter Gow on 24/02/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCCameraToolbar;

@protocol BLCCameraToolbarDelegate <NSObject>

- (void) leftButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar;
- (void) rightButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar;
- (void) cameraButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar;

@end

@interface BLCCameraToolbar : UIView

- (instancetype) initWithImageNames:(NSArray *)imageNames;

@property (nonatomic, weak) NSObject <BLCCameraToolbarDelegate> *delegate;

@end
