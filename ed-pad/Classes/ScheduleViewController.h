#import <Three20/Three20.h>

@protocol ScheduleViewControllerDelegate;
@class MockDataSource;

@interface ScheduleViewController : TTTableViewController <TTSearchTextFieldDelegate> {
    id<ScheduleViewControllerDelegate> _delegate;
}

@property(nonatomic,assign) id<ScheduleViewControllerDelegate> delegate;

@end

@protocol ScheduleViewControllerDelegate <NSObject>

- (void)search:(ScheduleViewController*)controller didSelectObject:(id)object;

@end