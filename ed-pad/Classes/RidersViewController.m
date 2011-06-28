#import "RidersViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation RidersViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
//    CGRect labelRect = CGRectMake(0, 0, TTNavigationFrame().size.width, TTNavigationFrame().size.height);
//    UILabel *label = [[[UILabel alloc] initWithFrame:labelRect] autorelease];
//    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
//    [label setText:[NSString stringWithFormat:@"%@", [self description]]];
//    [label setTextColor:[UIColor colorWithHue:(CFAbsoluteTimeGetCurrent() - (int)CFAbsoluteTimeGetCurrent())
//                                   saturation:(CFAbsoluteTimeGetCurrent() - (int)CFAbsoluteTimeGetCurrent())
//                                   brightness:(CFAbsoluteTimeGetCurrent() - (int)CFAbsoluteTimeGetCurrent())
//                                        alpha:1.0]];
//    [label setTextAlignment:UITextAlignmentCenter];
//    [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//    
//    TTView *view = [[TTView alloc] initWithFrame:TTScreenBounds()];
//    [view addSubview:label];
    
    [self setTitle:[NSString stringWithFormat:@"%@", [self class]]];
//    [self setView:view];
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
    //  MockDataSource *ds = [[MockDataSource alloc] init];
    //  ds.addressBook.fakeLoadingDuration = 1.0;
    //  self.dataSource = ds;
    //  [ds release];
}

- (id<TTTableViewDelegate>) createDelegate {
    
    TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
    
    return [delegate autorelease];
}

@end
