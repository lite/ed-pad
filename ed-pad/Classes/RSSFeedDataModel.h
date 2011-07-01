#import <Three20/Three20.h>

#import "RSSFeedParser.h"

@interface RSSFeedDataModel : TTModel<RSSFeedParserDelegate> {
	RSSFeedParser *parser;
	
	BOOL done;
	BOOL loading;
}

- (NSArray *)modelItems;

@end
