#import "PartnersViewController.h"

#import "RSSFeedDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation PartnersViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
    [super loadView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

- (void) createModel {
    RSSFeedDataSource *feedDataSource = [[RSSFeedDataSource alloc] init];
    
	self.dataSource = feedDataSource;
	
	TT_RELEASE_SAFELY(feedDataSource);

   
}

- (id<TTTableViewDelegate>) createDelegate {
    
    TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
    
    return [delegate autorelease];
}

@end
