#import "PartnersViewController.h"

#import "RSSFeedDataSource.h"

#import <extThree20XML/extThree20XML.h>

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation PartnersViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    NSLog([NSString stringWithFormat:@"%@ initWithNibName", [self class]]);

    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"feeds" ofType:@"xml"];
    NSData* xmlData = [NSData dataWithContentsOfFile:filePath];
    NSString* localImage = @"bundle://icon_ad.png";

    if(xmlData){
        TTXMLParser* parser = [[TTXMLParser alloc] initWithData:xmlData];
        parser.treatDuplicateKeysAsArrayItems = TRUE;
        [parser parse];
        NSDictionary* rootObject = parser.rootObject;
        NSDictionary *channel = [rootObject objectForKey:@"channel"];
        NSArray *items = [channel objectForKey:@"item"];

        NSMutableArray* objects = [NSMutableArray arrayWithCapacity:items.count];
        for(NSDictionary* item in items){
            NSString* title = [[item objectForKey:@"title"] objectForXMLNode];
            NSString* link = [[item objectForKey:@"link"] objectForXMLNode];
            [objects addObject:[TTTableImageItem itemWithText:title imageURL:localImage URL:link]];
        }

        self.dataSource = [TTListDataSource dataSourceWithItems:objects];

        TT_RELEASE_SAFELY(parser);
    }

    return self;
}

- (void)dealloc {
  [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

@end
