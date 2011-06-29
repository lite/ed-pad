#import "MockDataSource.h"

@implementation MockDataSource

- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self = [super init]) {
        _feed_model = [[Model alloc] initWithSearchQuery:searchQuery];
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_feed_model);
    
    [super dealloc];
}

- (id<TTModel>)model {
    return _feed_model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for(Feed *f in _feed_model.feeds) {
        [items addObject:[TTTableTextItem itemWithText:f.text]];
    }
    self.items = items;
}

- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return NSLocalizedString(@"Updating feed...", @"Feed updating text");
    } else {
        return NSLocalizedString(@"Loading feed...", @"Feed loading text");
    }
}

- (NSString*)titleForEmpty {
    return NSLocalizedString(@"No feed found.", @"Feed no results");
}

- (NSString*)subtitleForError:(NSError*)error {
    return NSLocalizedString(@"Sorry, there was an error loading the Feed stream.", @"");
}
@end

@implementation Feed

@synthesize text      = _text;
@synthesize source    = _source;
@synthesize ftype    = _ftype;
@synthesize img = _img;

- (void) dealloc {
    TT_RELEASE_SAFELY(_text);
    TT_RELEASE_SAFELY(_source);
    TT_RELEASE_SAFELY(_ftype);
    TT_RELEASE_SAFELY(_img);
    [super dealloc];
}

@end  

@implementation Model

@synthesize searchQuery = _searchQuery;
@synthesize feeds      = _feeds;

- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self = [super init]) {
        self.searchQuery = searchQuery;
    }
    
    return self;
}

- (void) dealloc {
    TT_RELEASE_SAFELY(_searchQuery);
    TT_RELEASE_SAFELY(_feeds);
    [super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading && TTIsStringWithAnyText(_searchQuery)) {
        NSString* url = @"http://api.douban.com/people/2449296/miniblog/contacts/merged?alt=json&max-results=20";
        
        TTURLRequest* request = [TTURLRequest
                                 requestWithURL: url
                                 delegate: self];
        
        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
        [request send];
    }
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
    NSMutableArray* feeds = [[NSMutableArray alloc] initWithCapacity:1];
    Feed* f = [[Feed alloc] init];
    f.text = @"Hi";
    [feeds addObject:f];
    _feeds = feeds;
    [super requestDidFinishLoad:request];
}

@end 

