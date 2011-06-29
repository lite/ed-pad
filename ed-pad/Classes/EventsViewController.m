
#import "EventsViewController.h"

@implementation EventsViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  [super loadView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

- (void) createModel {
//  self.dataSource = ds;
}

- (id<TTTableViewDelegate>) createDelegate {
  
  TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];

  return [delegate autorelease];
}

@end

