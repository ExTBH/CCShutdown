#import "CCShutdownModuleViewController.h"


@implementation CCShutdownModuleViewController
@synthesize preferredExpandedContentWidth;
@synthesize preferredExpandedContentHeight;
@synthesize providesOwnPlatter;

- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super initWithNibName:name bundle:bundle];
    if (self) {
        self.view.clipsToBounds = YES;
        self.actionLabelViewController = [ActionLabelViewController new];
        self.actionSelectionViewController = [[ActionSelectionViewController alloc]
            initWithCompletionCallback:^(ShutdownAction action){
                [self setAction:action];
        }];
        [self loadContent];
    }
    return self;
}

-(void)loadContent {
    [self addChildViewController:self.actionLabelViewController];
    [self.view addSubview:self.actionLabelViewController.view];

    [self addChildViewController:self.actionSelectionViewController];
    [self.view addSubview:self.actionSelectionViewController.view];
    self.actionSelectionViewController.view.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    preferredExpandedContentWidth = 250;
    preferredExpandedContentHeight = 300;
}

- (void)setAction:(ShutdownAction)action {

}

- (void)willTransitionToExpandedContentMode:(BOOL)willTransition {
    if (willTransition) {
        self.actionLabelViewController.view.hidden = YES;
        self.actionSelectionViewController.view.hidden = NO;
    } else {
        self.actionLabelViewController.view.hidden = NO;
        self.actionSelectionViewController.view.hidden = YES;
    }
}

- (BOOL)_canShowWhileLocked {
	return YES;
}
// When on we can Expand on long press
- (BOOL)shouldPerformClickInteraction {
    return YES;
}


@end