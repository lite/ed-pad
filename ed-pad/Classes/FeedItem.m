#import "FeedItem.h"

@implementation FeedItem

@synthesize title;
@synthesize date;
@synthesize link;
@synthesize category;
@synthesize description;
@synthesize imageURL;


#pragma mark --
#pragma mark Memory Management methods

- (void)dealloc {
	[title release];
	[date release];
	[link release];
	[category release];
	[description release];
	[imageURL release];
	
	[super dealloc];
}

@end
