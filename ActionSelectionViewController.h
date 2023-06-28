#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShutdownActionType) {
    ShutdownActionTypeShutdown,
    ShutdownActionTypeReboot,
    ShutdownActionTypeRespring
};
@interface ShutdownAction : NSObject
@property (nonatomic, assign) ShutdownActionType type;
@property (strong, nonatomic) NSDate *dueIn;
@property (nonatomic, assign) NSTimeInterval interval;
+ (instancetype)actionWithType:(ShutdownActionType)type dueIn:(NSTimeInterval)dueTime;
@end
@interface ActionSelectionViewController : UIViewController
- (instancetype)initWithCompletionCallback:(void (^)(ShutdownAction *action))completionCallback;
- (instancetype)init NS_UNAVAILABLE;
@end