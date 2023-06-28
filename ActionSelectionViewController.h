#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShutdownActionType) {
    Shutdown,
    Reboot,
    Respring
};

typedef struct {
    ShutdownActionType type;
    NSTimeInterval dueIn;
} ShutdownAction;

@interface ActionSelectionViewController : UIViewController
- (instancetype)initWithCompletionCallback:(void (^)(ShutdownAction action))completionCallback;
- (instancetype)init NS_UNAVAILABLE;
@end