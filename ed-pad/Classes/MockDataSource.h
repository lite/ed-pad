#import <Three20/Three20.h>

@class Model;
//TTListDataSource
@interface MockDataSource : TTSectionedDataSource {
    Model* _feed_model;
}

- (id)initWithSearchQuery:(NSString*)searchQuery;

@end                                               

@interface Feed : NSObject {
    NSString* _text;
    NSString* _source;
    NSString* _ftype;
    NSString* _img;
}

@property (nonatomic, copy)   NSString* text;
@property (nonatomic, copy)   NSString* source;
@property (nonatomic, copy)   NSString* ftype;
@property (nonatomic, copy)   NSString* img;

@end

@interface Model : TTURLRequestModel {
    NSString* _searchQuery;
    NSArray*  _feeds;
}

@property (nonatomic, copy)     NSString* searchQuery;
@property (nonatomic, readonly) NSArray*  feeds;

- (id)initWithSearchQuery:(NSString*)searchQuery;

@end