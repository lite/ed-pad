#import <Foundation/Foundation.h>

@interface FeedItem : NSObject {
	NSString *title;
	NSDate *date;
	NSString *link;
	NSString *description;
	NSString *category;
	NSString *imageURL;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *imageURL;

@end
