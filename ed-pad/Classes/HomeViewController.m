#import "HomeViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation HomeViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Home";
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
    [super loadView];
    [self setNavigationBarTintColor:[UIColor grayColor]];
	[self setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
	[self.navigationController setNavigationBarHidden:NO];
    
    _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
    _launcherView.backgroundColor = [UIColor blackColor];
    _launcherView.delegate = self;
    _launcherView.columnCount = 3;
    _launcherView.pages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"News"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://news" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Map Screen"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://mapscreen"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Events"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://events"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Schedule"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://schedule" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Riders"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://riders"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Partners"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://partners"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Photos/Videos"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://videos" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Social"
                                                             image:@"bundle://dashboard_button_default.png"
                                                               URL:@"tt://social"  
                                                         canDelete:NO] autorelease],
                            nil],
                           nil
                           ];
    
    TTLauncherItem* item = [_launcherView itemWithURL:@"tt://news"];
    item.badgeNumber = 3;
    [self.view addSubview:_launcherView];
    [_launcherView release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:item.URL]];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                 target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end
