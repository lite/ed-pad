#include <Three20/Three20.h>

#import "RSSFeedDataModel.h"

@implementation RSSFeedDataModel

- (NSArray *)modelItems {
	return [parser feedItems];
}


#pragma mark --
#pragma mark TTModel methods

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	done = NO;
	loading = YES;
	
	parser = [[RSSFeedParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://iosguy.com/feed/"]];
	parser.delegate = self;
	[parser parse];
}

- (BOOL)isLoaded {
	return done;
}

- (BOOL)isLoading {
	return loading;
}


#pragma mark --
#pragma mark RSSFeedParserDelegate methods

- (void)rssFeedParserDidFinishParsing:(RSSFeedParser *)rssFeedParser {
	done = YES;
	loading = NO;
	
	[self didFinishLoad];
}

- (void)rssFeedParser:(RSSFeedParser *)rssFeedParser didFailWithError:(NSError *)error {
	done = YES;
	loading = NO;
	
	[self didFailLoadWithError:error];
}

- (void)dealloc {
	[parser release];
	
	[super dealloc];
}

@end
