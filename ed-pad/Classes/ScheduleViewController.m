#import "ScheduleViewController.h"

#import "MockDataSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation ScheduleViewController

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
    self.dataSource = [[[MockDataSource alloc] initWithSearchQuery:@"haha"] autorelease];
}

- (id<TTTableViewDelegate>) createDelegate {
    
    TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
    
    return [delegate autorelease];
}

@end
