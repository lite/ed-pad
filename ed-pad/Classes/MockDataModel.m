#include <Three20/Three20.h>

#import "MockDataModel.h"

@implementation MockDataModel

#pragma mark --
#pragma mark TTModel methods

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    done = NO;
	loading = YES;
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"feeds" ofType:@"xml"];
    NSData* xmlData = [NSData dataWithContentsOfFile:filePath];
    if(xmlData){
        parser = [[RSSFeedParser alloc] initWithData:xmlData];
        parser.delegate = self;
        [parser parse];

    }
}

@end
