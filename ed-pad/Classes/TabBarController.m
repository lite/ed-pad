#import "TabBarController.h"

@implementation TabBarController

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self setTabURLs:[NSArray arrayWithObjects:
                      @"tt://home",
                      @"tt://settings",
                      @"tt://about",
                      nil]];
    
    NSArray *tabs =  [self viewControllers];
    
    UIImage* img = [UIImage imageNamed:@"icon_home.png"];
    
    UIViewController *home = [tabs objectAtIndex:0];
    home.tabBarItem.image = img;

    UIViewController *settings = [tabs objectAtIndex:1];
    settings.tabBarItem.image = img;
    
    UIViewController *about = [tabs objectAtIndex:2];
    about.tabBarItem.image = img;
}
