#import "RidersViewController.h"

#import "MockPhotoSource.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation RidersViewController

- (void)viewDidLoad {
    self.photoSource = [[MockPhotoSource alloc]
                        initWithType:MockPhotoSourceNormal
                        //initWithType:MockPhotoSourceDelayed
                        // initWithType:MockPhotoSourceLoadError
                        // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
                        title:@"Photos"
                        photos:[[NSArray alloc] initWithObjects:
                                [[[MockPhoto alloc] initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg" smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg" size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc] initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg" smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg" size:CGSizeMake(320, 480) caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc] initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0" smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg" size:CGSizeMake(320, 480) caption:@"A hike."] autorelease],
                                nil] 
                         photos2:[[NSArray alloc] initWithObjects:
                            [[[MockPhoto alloc] initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg" smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg" size:CGSizeMake(800, 533)] autorelease],
                            nil]
                        ];
}
@end
