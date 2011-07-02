#import "HomeViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation HomeViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title = @"Home";
    
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
    
    NSString* img_path = @"bundle://dashboard_button_default.png";
    
    _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
    _launcherView.backgroundColor = [UIColor blackColor];
    _launcherView.delegate = self;
    _launcherView.columnCount = 4;
    _launcherView.pages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"News"
                                                             image:img_path
                                                               URL:@"tt://home/news" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Map Screen"
                                                             image:img_path
                                                               URL:@"tt://home/mapscreen"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Events"
                                                             image:img_path 
                                                               URL:@"tt://home/events"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Schedule"
                                                             image:img_path
                                                               URL:@"tt://home/schedule" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Riders"
                                                             image:img_path
                                                               URL:@"tt://home/riders"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Partners"
                                                             image:img_path
                                                               URL:@"tt://home/partners"
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Photos/Videos"
                                                             image:img_path
                                                               URL:@"tt://home/videos" 
                                                         canDelete:NO] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Social"
                                                             image:img_path
                                                               URL:@"tt://home/social"  
                                                         canDelete:NO] autorelease],
                            nil],
                           nil
                           ];
    
    TTLauncherItem* item = [_launcherView itemWithURL:@"tt://home/news"];
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
