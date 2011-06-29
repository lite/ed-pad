#import "NewsViewController.h"

#import "MockDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NewsViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    NSLog([NSString stringWithFormat:@"%@ initWithNibName", [self class]]);
    
    NSString* localImage = @"bundle://icon_ad.png";
    self.dataSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableImageItem itemWithText:@"Ad Here" imageURL:localImage
                                                  URL:nil],
                       [TTTableImageItem itemWithText:@"Home" imageURL:localImage
                                                  URL:@"tt://home"],
                       [TTTableImageItem itemWithText:@"News" imageURL:localImage
                                                  URL:@"tt://news"],
                       [TTTableImageItem itemWithText:@"Events" imageURL:localImage
                                                  URL:@"tt://events"],
                       
                       nil];

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
    self.dataSource =  [[[MockDataSource alloc] initWithSearchQuery:@"haha"] autorelease];
}

- (id<TTTableViewDelegate>) createDelegate {
    
    TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
    
    return [delegate autorelease];
}

@end
