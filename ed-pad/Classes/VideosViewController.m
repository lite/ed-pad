#import "VideosViewController.h"

#import <iAd/ADBannerView.h> 

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation VideosViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    ADBannerView *banner = [[ADBannerView alloc] init];
    banner.delegate = self;
    banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    CGSize bannerSize = [ADBannerView sizeFromBannerContentSizeIdentifier:ADBannerContentSizeIdentifier320x50];
    banner.frame = CGRectOffset(banner.frame, 0, self.view.bounds.size.height - bannerSize.height);
    banner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:banner];
    [banner release];
    
    return self;
}

- (void)dealloc {
//    adView.delegate=nil;
//    [adView release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

-(void)loadView;
{
    [super loadView];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { 
    return (interfaceOrientation == UIInterfaceOrientationPortrait|UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
//        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier480x32;
//    else
//        adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
//    if (!self.bannerIsVisible)
//    {
//        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
//        // banner is invisible now and moved out of the screen on 50 px
//        banner.frame = CGRectOffset(banner.frame, 0, 50);
//        [UIView commitAnimations];
//        self.bannerIsVisible = YES;
//    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
//    if (self.bannerIsVisible)
//    {
//        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
//        // banner is visible and we move it out of the screen, due to connection issue
//        banner.frame = CGRectOffset(banner.frame, 0, -50);
//        [UIView commitAnimations];
//        self.bannerIsVisible = NO;
//    }
}

//- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
//{
//    NSLog(@"Banner view is beginning an ad action");
//    BOOL shouldExecuteAction = YES;
//    if (!willLeave && shouldExecuteAction)
//    {
//        // stop all interactive processes in the app
//        // [video pause];
//        // [audio pause];
//    }
//    return shouldExecuteAction;
//}
//
//- (void)bannerViewActionDidFinish:(ADBannerView *)banner
//{
//    // resume everything you've stopped
//    // [video resume];
//    // [audio resume];
//}

@end
