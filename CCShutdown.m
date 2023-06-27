#import "CCShutdown.h"
#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>


@interface UptimeModuleContentViewController : UIViewController <CCUIContentModuleContentViewController>
@property (nonatomic, readonly) CGFloat preferredExpandedContentHeight;
@property (nonatomic, readonly) CGFloat preferredExpandedContentWidth;
@property (nonatomic, readonly) BOOL expanded;
- (void)controlCenterDidDismiss;
- (void)controlCenterWillPresent;
@end

// @interface CCUILabeledRoundButtonViewController : UIViewController
// -(void)buttonTapped:(id)arg1;
// @end

@interface SomeButton : CCUILabeledRoundButtonViewController
@end

@implementation SomeButton
- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = UIColor.redColor;
}

// -(void)buttonTapped:(id)arg1 {
//     [super buttonTapped:arg1];
// }
@end


@implementation CCShutdown
@synthesize contentViewController;
@synthesize backgroundViewController;

- (instancetype)init {
    self = [super init];
    if (self) {
        contentViewController = [[UptimeModuleContentViewController alloc] init];
	}
    return self;
}
- (CCUILayoutSize)moduleSizeForOrientation:(int)orientation {
    return (CCUILayoutSize){2, 1};
}
@end


@implementation UptimeModuleContentViewController
@synthesize providesOwnPlatter;

- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super initWithNibName:name bundle:bundle];
    if (self) {
        self.view.clipsToBounds = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _preferredExpandedContentWidth = 200;
    _preferredExpandedContentHeight = 80;
    // SomeButton *btn = [SomeButton new];
    // [self addChildViewController:btn];
    // [self.view addSubview:btn.view];

    // btn.view.translatesAutoresizingMaskIntoConstraints = NO;
    // [NSLayoutConstraint activateConstraints:@[
    //     [btn.view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    //     [btn.view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
    //     [btn.view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
    //     [btn.view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor],
    // ]];
}
- (BOOL)_canShowWhileLocked {
	return YES;
}
- (BOOL)shouldPerformClickInteraction {
    return NO;
}

@end
