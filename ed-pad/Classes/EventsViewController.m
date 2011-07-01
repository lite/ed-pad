
#import "EventsViewController.h"
#import "RSSFeedDataSource.h"

@implementation EventsViewController

- (id)init {
	if (self = [super init]) {
		self.variableHeightRows = YES;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.navigationBarTintColor = [UIColor blackColor];
	self.title = @"iOS Guy RSS Feed";
}


#pragma mark --
#pragma mark TTModelViewController methods

- (void)createModel {
	RSSFeedDataSource *feedDataSource = [[RSSFeedDataSource alloc] init];

	self.dataSource = feedDataSource;
	
	TT_RELEASE_SAFELY(feedDataSource);
}

- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end

