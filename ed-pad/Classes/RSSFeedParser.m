#import "RSSFeedParser.h"
#import "FeedItem.h"

#define ITEM_KEY @"item"
#define TITLE_KEY @"title"
#define LINK_KEY @"link"
#define PUBLICATION_DATE_KEY @"pubDate"
#define CATEGORY_KEY @"category"
#define IMAGE_KEY @"media:content"
#define DESCRIPTION_KEY @"description"

@implementation RSSFeedParser

@synthesize delegate;

- (id)initWithContentsOfURL:(NSURL *)url {
	if (self = [super init]) {
		items = [[NSMutableArray alloc] init];

		xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
		[xmlParser setDelegate:self];
		[xmlParser setShouldProcessNamespaces:NO];
		[xmlParser setShouldReportNamespacePrefixes:NO];
		[xmlParser setShouldResolveExternalEntities:NO];
	}
	return self;
}

- (id)initWithContents:(NSData *)data {
	if (self = [super init]) {
		items = [[NSMutableArray alloc] init];

		xmlParser = [[NSXMLParser alloc] initWithData:data];
		[xmlParser setDelegate:self];
		[xmlParser setShouldProcessNamespaces:NO];
		[xmlParser setShouldReportNamespacePrefixes:NO];
		[xmlParser setShouldResolveExternalEntities:NO];
	}
	return self;
}

- (void)parse {
	[xmlParser parse];
}

- (NSArray *)feedItems {
	NSMutableArray *feedItems = [NSMutableArray arrayWithCapacity:items.count];

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss +0000"];

	for (NSDictionary *item in items) {
		FeedItem *feedItem = [[FeedItem alloc] init];
		feedItem.title = [item objectForKey:TITLE_KEY];

		NSString *date = [[item objectForKey:PUBLICATION_DATE_KEY]
						  stringByTrimmingCharactersInSet:
						  [NSCharacterSet whitespaceAndNewlineCharacterSet]];

		feedItem.date = [dateFormatter dateFromString:date];
		feedItem.link = [item objectForKey:LINK_KEY];
		feedItem.category = [item objectForKey:CATEGORY_KEY];
		feedItem.description = [item objectForKey:DESCRIPTION_KEY];
		feedItem.imageURL = [item objectForKey:IMAGE_KEY];

		[feedItems addObject:feedItem];

		[feedItem release];
	}

	[dateFormatter release];

	return feedItems;
}


#pragma mark --
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if (delegate && [delegate respondsToSelector:@selector(rssFeedParser:didFailWithError:)]) {
		[delegate rssFeedParser:self didFailWithError:parseError];
	}
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	[currentElement release];
	currentElement = [elementName copy];

	if ([currentElement isEqualToString:ITEM_KEY]) {
		currentItem = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
		currentCategory = [[NSMutableString alloc] init];
		currentDescription = [[NSMutableString alloc] init];
		currentImageURL = [[NSMutableString alloc] init];
	}

	if ([currentElement isEqualToString:IMAGE_KEY]) {
		[currentImageURL appendString:[attributeDict objectForKey:@"url"]];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if ([elementName isEqualToString:ITEM_KEY]) {
		[currentItem setObject:currentTitle forKey:TITLE_KEY];
		[currentItem setObject:[currentLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:LINK_KEY];
		[currentItem setObject:currentDate forKey:PUBLICATION_DATE_KEY];
		[currentItem setObject:currentCategory forKey:CATEGORY_KEY];
		[currentItem setObject:currentDescription forKey:DESCRIPTION_KEY];
		[currentItem setObject:currentImageURL forKey:IMAGE_KEY];

		[currentTitle release];
		[currentDate release];
		[currentLink release];
		[currentCategory release];
		[currentDescription release];
		[currentImageURL release];

		[items addObject:currentItem];

		[currentItem release];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:TITLE_KEY]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:LINK_KEY]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:PUBLICATION_DATE_KEY]) {
		[currentDate appendString:string];
	} else if ([currentElement isEqualToString:CATEGORY_KEY]) {
		[currentCategory appendString:string];
	} else if ([currentElement isEqualToString:DESCRIPTION_KEY]) {
		[currentDescription appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if (delegate && [delegate respondsToSelector:@selector(rssFeedParserDidFinishParsing:)]) {
		[delegate rssFeedParserDidFinishParsing:self];
	}
}


#pragma mark --
#pragma mark Memory Management methods

- (void)dealloc {
	[items release];
	[xmlParser release];
	[currentElement release];

	[super dealloc];
}

@end
