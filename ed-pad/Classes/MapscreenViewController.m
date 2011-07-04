#import "MapscreenViewController.h"

#import "CLLocationManager_sim.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MapscreenViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//    CLLocationManager_sim* locationManager = [[CLLocationManager_sim alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0f;
    [locationManager startUpdatingLocation];
}

- (void)dealloc {
    [super dealloc];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"---------- locationManager didUpdateToLocation");

    mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsUserLocation=TRUE;
    mapView.mapType=MKMapTypeStandard;
//    mapView.mapType=MKMapTypeSatellite;
//    mapView.mapType=MKMapTypeHybrid;
    mapView.delegate=self;
    /*Region and Zoom*/
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    
    CLLocationCoordinate2D location=[newLocation coordinate];
    //    CLLocationCoordinate2D location=mapView.userLocation.coordinate;
    //    location.latitude=32;
    //    location.longitude=132;
    //    CLLocationCoordinate2D location=[[locationManager location] coordinate];
    
    region.span=span;
    region.center=location;
    
    /*Geocoder Stuff*/
    
    geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:location];
    geoCoder.delegate=self;
    [geoCoder start];
    
    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    [self.view addSubview:mapView];
    NSLog(@"Location after calibration, user location (%f, %f)", mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"Reverse Geocoder Errored");
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	NSLog(@"Geocoder completed");
	mPlacemark=placemark;
	[mapView addAnnotation:placemark];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
	NSLog(@"-------viewForAnnotation-------");
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CameraAnnotation"];
    annView.pinColor=MKPinAnnotationColorPurple;
    annView.canShowCallout=YES;
    annView.animatesDrop=TRUE;
	return annView;
}

@end