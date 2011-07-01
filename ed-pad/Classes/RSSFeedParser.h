#import <Foundation/Foundation.h>

@class RSSFeedParser;

@protocol RSSFeedParserDelegate<NSObject>

- (void)rssFeedParserDidFinishParsing:(RSSFeedParser *)rssFeedParser;
- (void)rssFeedParser:(RSSFeedParser *)rssFeedParser didFailWithError:(NSError *)error;

@end


@interface RSSFeedParser : NSObject<NSXMLParserDelegate> {
	NSMutableArray *items;
	
	NSMutableDictionary *currentItem;
	NSMutableString *currentTitle;
	NSMutableString *currentDate;
	NSMutableString *currentLink;
	NSMutableString *currentCategory;
	NSMutableString *currentDescription;
	NSMutableString *currentImageURL;
	NSString *currentElement;
	
	NSXMLParser *xmlParser;
	
	id<RSSFeedParserDelegate> delegate;
}

@property (nonatomic, assign) id<RSSFeedParserDelegate> delegate;

- (id)initWithContentsOfURL:(NSURL *)url;
- (id)initWithContents:(NSData *)data;
- (void)parse;
- (NSArray *)feedItems;

@end
