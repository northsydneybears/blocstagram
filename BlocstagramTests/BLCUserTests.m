//
//  BLCUserTests.m
//  Blocstagram
//
//  Created by Peter Gow on 2/03/2015.
//  Copyright (c) 2015 Peter Gow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BLCUser.h"
#import "BLCComment.h"
#import "BLCMedia.h"
#import "BLCComposeCommentView.h"
#import "BLCMediaTableViewCell.h"

@interface BLCUserTests : XCTestCase

@end

@implementation BLCUserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testThatBLCUserInitializationWorks
{
	NSDictionary *sourceDictionary = @{@"id": @"8675309",
																		 @"username" : @"d'oh",
																		 @"full_name" : @"Homer Simpson",
																		 @"profile_picture" : @"http://www.example.com/example.jpg"};
	BLCUser *testUser = [[BLCUser alloc] initWithDictionary:sourceDictionary];
	
	XCTAssertEqualObjects(testUser.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
	XCTAssertEqualObjects(testUser.userName, sourceDictionary[@"username"], @"The username should be equal");
	XCTAssertEqualObjects(testUser.fullName, sourceDictionary[@"full_name"], @"The full name should be equal");
	XCTAssertEqualObjects(testUser.profilePictureURL, [NSURL URLWithString:sourceDictionary[@"profile_picture"]], @"The profile picture should be equal");
}

- (void)testThatBLCCommentInitializationWorks
{
	NSDictionary *sourceDictionary = @{@"id": @"8675309",
																		 @"text" : @"Stand Aside, Here Come The Mighty Bears"};
 
	BLCComment *testComment = [[BLCComment alloc] initWithDictionary:sourceDictionary];
	
	XCTAssertEqualObjects(testComment.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
	XCTAssertEqualObjects(testComment.text, sourceDictionary[@"text"], @"The text should be equal");
}

- (void)testThatBLCMediaInitializationWorks
{
	NSDictionary *captionDictionary = @{@"text":@"Florimo"};
	NSDictionary *imageURLDictionary =@{@"url": @"http://www.northsydneybears.com.au"};
	NSDictionary *resolutionDictionary = @{@"standard_resolution": imageURLDictionary};
	
	
	NSDictionary *sourceDictionary = @{@"id": @"8675309",
																		 @"caption": captionDictionary,
																		 @"images": resolutionDictionary};
	
	
	
	BLCMedia *testMedia = [[BLCMedia alloc] initWithDictionary:sourceDictionary];
	
	XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
	XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"caption"][@"text"], @"The caption should be equal");
	XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"images"][@"standard_resolution"][@"url"]], @"The URL should be equal");
	
}

- (void) testThatIsWritingCommentSetsCorrectlyYes
{
	NSString *testString = @"Since 1908";
	BLCComposeCommentView *testView = [[BLCComposeCommentView alloc] init];
	[testView setText:testString];
	
	XCTAssertTrue(testView.isWritingComment == YES, @"isWritingComment should be set to YES");
}

- (void) testThatIsWritingCommentSetsCorrectlyNo
{
	NSString *noTextString = @"";
	BLCComposeCommentView *testView = [[BLCComposeCommentView alloc] init];
	[testView setText:noTextString];
	
	XCTAssertTrue(testView.isWritingComment == NO, @"isWritingComment should be set to NO");
}

- (void) testThatHeightForMediaItemGivesAccurateHeights
{
	NSDictionary *captionDictionary = @{@"text":@"Florimo"};
	NSDictionary *imageURLDictionary =@{@"url": @"http://www.northsydneybears.com.au"};
	NSDictionary *resolutionDictionary = @{@"standard_resolution": imageURLDictionary};
	
	
	NSDictionary *sourceDictionary = @{@"id": @"8675309",
																		 @"caption": captionDictionary,
																		 @"images": resolutionDictionary};
	
	BLCMediaTableViewCell *testCell = [[BLCMediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
	BLCMedia *testMedia = [[BLCMedia alloc] initWithDictionary:sourceDictionary];
	testCell.mediaItem = testMedia;
	
	XCTAssertEqual([BLCMediaTableViewCell heightForMediaItem:testMedia width:300], 300);
	
	
}

@end
