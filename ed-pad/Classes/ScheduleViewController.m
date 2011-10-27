#import "ScheduleViewController.h"
#import "MockDataSource.h"

@implementation ScheduleViewController

@synthesize delegate = _delegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _delegate = nil;

        self.title = @"Schedule";
        self.dataSource = [[[MockDataSource alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc {
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)loadView {
    [super loadView];

    TTTableViewController* searchController = [[[TTTableViewController alloc] init] autorelease];
    searchController.dataSource = [[[MockSearchDataSource alloc] initWithDuration:1.5] autorelease];
    self.searchViewController = searchController;
    self.tableView.tableHeaderView = _searchController.searchBar;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewController

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    [_delegate search:self didSelectObject:object];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTSearchTextFieldDelegate

- (void)textField:(TTSearchTextField*)textField didSelectObject:(id)object {
    [_delegate search:self didSelectObject:object];
}

@end
