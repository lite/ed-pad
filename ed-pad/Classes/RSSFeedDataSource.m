#import "RSSFeedDataSource.h"
#import "FeedItem.h"

@implementation RSSFeedDataSource

- (id)init {
	if (self = [super init]) {
		dataModel = [[RSSFeedDataModel alloc] init];
	}
	return self;
}

#pragma mark -
#pragma mark TTTableViewDataSource methods

- (id<TTModel>)model {
	return dataModel;
}

- (void)tableViewDidLoadModel:(UITableView *)tableView {
	NSArray *modelItems = [dataModel modelItems];

	NSMutableArray *updatedItems = [NSMutableArray arrayWithCapacity:modelItems.count];

	for (FeedItem *feedItem in modelItems) {
		TTTableMessageItem *item = [TTTableMessageItem itemWithTitle:feedItem.title caption:feedItem.category text:feedItem.description timestamp:feedItem.date imageURL:feedItem.imageURL URL:feedItem.link];
		[updatedItems addObject:item];
	}

	self.items = updatedItems;
}


#pragma mark -
#pragma mark Error Handling methods

- (NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading...";
}

- (NSString *)titleForEmpty {
	return @"No feed";
}

- (NSString *)titleForError:(NSError *)error {
	return @"Oops";
}

- (NSString *)subtitleForError:(NSError *)error {
	return @"The requested feed is not available.";
}


#pragma mark --
#pragma mark Memory Management methods

- (void)dealloc {
	[dataModel release];

	[super dealloc];
}

@end



