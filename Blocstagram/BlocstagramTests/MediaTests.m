//
//  MediaTests.m
//  
//
//  Created by Lorena Calderon on 12/21/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Media.h"
#import "User.h"
#import "MediaTableViewCell.h"
#import "ComposeCommentView.h"

@interface MediaTests : XCTestCase
@property (nonatomic, strong) MediaTableViewCell *cell;
@property (nonatomic, strong) UITraitCollection *overrideTraitCollection;
@property (nonatomic) CGFloat offsetPoint;
@property (nonatomic, strong) NSDictionary *mediaSourceDictionary;
@end

@implementation MediaTests

- (void)setUp {
    [super setUp];
    _mediaSourceDictionary = @{@"caption": @{@"created_time":[NSNumber numberWithInt:1447865981],
                                             @"from":@{
                                                     @"full_name":@"carlos calderon",
                                                     @"id": [NSNumber numberWithInt:2277208236],
                                                     @"profile_picture":@"https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg",
                                                     @"username": @"cdcalderon1979"}},
                               @"comments": @{@"count": [NSNumber numberWithInt:1],
                                              @"data":@[@{@"created_time": @"1401358234",
                                                          @"id": @"730968308560302306",
                                                          @"text":@"Test message",
                                                          @"from":@{@"username": @"lorena313",
                                                                    @"profile_picture": @"http:\/\/images.ak.instagram.com\/profiles\/profile_582637650_75sq_1399534296.jpg",
                                                                    @"id":@"582637650",
                                                                    @"full_name":@"Lorena Calderon"
                                                                    }
                                                          }]
                                              
                                              },
                               @"created_time": [NSNumber numberWithInt:1447865981],
                               @"user": @{@"full_name":@"carlos calderon",
                                          @"id":[NSNumber numberWithInt:(2277208236)],
                                          @"profile_picture": @"https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg",
                                          @"username": @"cdcalderon1979"
                                          }
                               };


}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatInitializationWorks
{
    
    Media *testMedia = [[Media alloc] initWithDictionary:_mediaSourceDictionary];
    
    XCTAssertEqualObjects(testMedia.user.fullName, _mediaSourceDictionary[@"user"][@"full_name"], @"The ID number should be equal");
    XCTAssertEqualObjects([[testMedia.comments firstObject] idNumber], [_mediaSourceDictionary[@"comments"][@"data"] firstObject][@"id"], @"The ID number should be equal");

}

- (void)testCarlos {
    NSDictionary *mediaSourceDictionary = @{@"caption": @{@"created_time":[NSNumber numberWithInt:1447865981],
                                                          @"from":@{
                                                                  @"full_name":@"carlos calderon",
                                                                  @"id": [NSNumber numberWithInt:2277208236],
                                                                  @"profile_picture":@"https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg",
                                                                  @"username": @"cdcalderon1979"}},
                                            @"comments": @{@"count": [NSNumber numberWithInt:1],
                                                           @"data":@[@{@"created_time": @"1401358234",
                                                                       @"id": @"730968308560302306",
                                                                       @"text":@"Test message",
                                                                       @"from":@{@"username": @"lorena313",
                                                                                 @"profile_picture": @"http:\/\/images.ak.instagram.com\/profiles\/profile_582637650_75sq_1399534296.jpg",
                                                                                 @"id":@"582637650",
                                                                                 @"full_name":@"Lorena Calderon"
                                                                               }
                                                                       }]
                                                           
                                                           },
                                            @"created_time": [NSNumber numberWithInt:1447865981],
                                            @"user": @{@"full_name":@"carlos calderon",
                                                       @"id":[NSNumber numberWithInt:(2277208236)],
                                                       @"profile_picture": @"https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg",
                                                       @"username": @"cdcalderon1979"
                                                       }
                                            };
    
    Media *testMedia = [[Media alloc] initWithDictionary:mediaSourceDictionary];
    CGRect frame = CGRectMake(0, 0, 768, 1024);
    CGRect frameCell = CGRectMake(0, 0, 768, 190);
    CGFloat height = [MediaTableViewCell heightForMediaItem:testMedia width: CGRectGetWidth(frame) traitCollection: nil];
    
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    layoutCell.mediaItem = testMedia;
    // Give it the media item
    layoutCell.frame = CGRectMake(0, 0, frame.size.width, CGRectGetHeight(layoutCell.frame));
    layoutCell.commentView.frame = frameCell;
    XCTAssertEqual(height, CGRectGetMaxY(layoutCell.commentView.frame));

}

@end
