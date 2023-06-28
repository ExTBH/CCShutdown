#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUIContentModuleContentViewController-Protocol.h>
#import "ActionLabelViewController.h"
#import "ActionSelectionViewController.h"

typedef struct CCUILayoutSize {
	unsigned long long width;
	unsigned long long height;
} CCUILayoutSize;


@interface CCShutdownModuleViewController : UIViewController <CCUIContentModuleContentViewController>
@property (nonatomic, strong) ActionLabelViewController *actionLabelViewController;
@property (nonatomic, strong) ActionSelectionViewController *actionSelectionViewController;
@property (strong, nonatomic) ShutdownAction *action;


@end