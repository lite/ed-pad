#import "AboutViewController.h"

#import "UIDevice-Reachability.h"
#import "UIDevice-IOKitExtensions.h"
#import "UIDevice-Hardware.h"
#import "UIDevice-Capabilities.h"
#import "UIDevice-Orientation.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation AboutViewController

@synthesize log;
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void) doLog: (NSString *) formatstring, ...
{
	va_list arglist;
	if (!formatstring) return;
	va_start(arglist, formatstring);
	NSString *outstring = [[[NSString alloc] initWithFormat:formatstring arguments:arglist] autorelease];
	va_end(arglist);

	NSLog(@"%@", outstring);

	[self.log appendString:outstring];
	[self.log appendString:@"\n"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.title = @"About";

    [[UIDevice currentDevice] scanCapabilities];
    self.log = [[NSMutableString alloc] initWithString:@""];

	[self doLog:@"Adjusted Orientation Angle: %f\n", [[UIDevice currentDevice] orientationAngleRelativeToOrientation:UIDeviceOrientationLandscapeLeft]];

	// TESTING REACHABILITY
	[self doLog:@"Host Name: %@", [[UIDevice currentDevice] hostname]];
	[self doLog:@"Local IP Addy: %@", [[UIDevice currentDevice] localIPAddress]];
	[self doLog:@"  Google IP Addy: %@", [[UIDevice currentDevice] getIPAddressForHost:@"www.google.com"]];
	[self doLog:@"  Amazon IP Addy: %@", [[UIDevice currentDevice] getIPAddressForHost:@"www.amazon.com"]];
	[self doLog:@"Local WiFI Addy: %@", [[UIDevice currentDevice] localWiFiIPAddress]];
	if ([[UIDevice currentDevice] networkAvailable])
		[self doLog:@"What is My IP: %@", [[UIDevice currentDevice] whatismyipdotcom]];

	// TESTING IOKIT
	[self doLog:[[UIDevice currentDevice] imei]];
	[self doLog:[[UIDevice currentDevice] serialnumber]];

	// TESTING DEVICE HARDWARE
	[self doLog:@"Platform: %@", [[UIDevice currentDevice] platform]];
	[self doLog:@"Platform String: %@", [[UIDevice currentDevice] platformString]];

	[self doLog:@"Device is%@ portrait", [UIDevice currentDevice].isPortrait ? @"" : @" not"];
	[self doLog:@"Orientation: %@", [UIDevice currentDevice].orientationString];
	[self doLog:@"Platform: %@", [[UIDevice currentDevice] platform]];
	[self doLog:@"Platform String: %@", [[UIDevice currentDevice] platformString]];
	[self doLog:@"Platform Code: %@", [[UIDevice currentDevice] platformCode]];
	[self doLog:@"CPU Freq: %.2fG", [[UIDevice currentDevice] cpuFrequency]/1024/1024/1024];
    [self doLog:@"Bus Freq: %.2fM",[[UIDevice currentDevice] busFrequency]/1024/1024];
    [self doLog:@"Total Memory: %.2fMB",[[UIDevice currentDevice] totalMemory]/1024/1024];
    [self doLog:@"nUser Memory: %.2fMB",[[UIDevice currentDevice] userMemory]/1024/1024];

	[self doLog:@"Mac addy: %@", [[UIDevice currentDevice] macaddress]];

    UITextView *view = [[UITextView alloc] initWithFrame:TTScreenBounds()];
    [view setText:self.log];

    {
        //turning off bounds clipping allows the shadow to extend beyond the rect of the view
        [view setClipsToBounds:NO];
        //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
        UIColor * highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
        UIColor * lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
        //The gradient, simply enough.  It is a rectangle
        CAGradientLayer * gradient = [CAGradientLayer layer];
        [gradient setFrame:[view bounds]];
        [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
        //the rounded rect, with a corner radius of 6 points.
        //this *does* maskToBounds so that any sublayers are masked
        //this allows the gradient to appear to have rounded corners
        CALayer * roundRect = [CALayer layer];
        [roundRect setFrame:[view bounds]];
        [roundRect setCornerRadius:6.0f];
        [roundRect setMasksToBounds:YES];
        [roundRect addSublayer:gradient];
        //add the rounded rect layer underneath all other layers of the view
        [[view layer] insertSublayer:roundRect atIndex:0];
        //set the shadow on the view's layer
        [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
        [[view layer] setShadowOffset:CGSizeMake(0, 6)];
        [[view layer] setShadowOpacity:1.0];
        [[view layer] setShadowRadius:10.0];
        }

    [self setView:view];
    [view autorelease];

    return self;
}

- (void)dealloc {
    [self.log autorelease];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
    [super loadView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation { return YES; }

@end
