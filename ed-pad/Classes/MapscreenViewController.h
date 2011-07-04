#import <Three20/Three20.h>

#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>

@interface MapscreenViewController : TTViewController <MKReverseGeocoderDelegate,MKMapViewDelegate,CLLocationManagerDelegate> {
	MKMapView *mapView;
	MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
}
@end