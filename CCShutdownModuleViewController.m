#import "CCShutdownModuleViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <Foundation/NSFileManager.h>
#import <rootless.h>
#import <spawn.h>

// tell https://github.com/theos/headers/pull/84 is merged
@interface FBSSystemService (CCShutdown)
- (void)shutdown;
- (void)reboot;
@end

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
            initWithCompletionCallback:^(ShutdownAction *action){
                [self actionCallback:action];
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
    preferredExpandedContentWidth = 300;
    preferredExpandedContentHeight = 300;
}

- (void)actionCallback:(ShutdownAction*)action {
    LAContext *context = [LAContext new];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"CCShutdown Requires Authintication"reply:^(BOOL success, NSError *error){
        if (success) {
            NSDate *now = [NSDate date];
            action.dueIn =  [now dateByAddingTimeInterval:action.interval];
            self.action = action;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.actionLabelViewController setupWithAction:self.action];
                // Scheudle backend time
                [NSTimer 
                    scheduledTimerWithTimeInterval:action.interval
                    target:self
                    selector:@selector(perfromAction:)
                    userInfo:@(action.type)
                    repeats:NO];
            });
        }
    }];
}

- (void)perfromAction:(NSTimer*)timer {
    ShutdownActionType actionType = [(NSNumber*) timer.userInfo unsignedIntegerValue];

    switch (actionType) {
        case ShutdownActionTypeShutdown:
            [[FBSSystemService sharedService] shutdown];
            break;
        case ShutdownActionTypeReboot:
            [[FBSSystemService sharedService] reboot];
            break;
        case ShutdownActionTypeRespring:
            [self perfromRespring];
            break;
    }
}
// Property of NightWind on theos discord
- (void)perfromRespring {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    extern char **environ;
    pid_t pid;

    if ([fileManager fileExistsAtPath:@"/var/Liy/.procursus_strapped"] && ![fileManager fileExistsAtPath:@"/var/jb/usr/local/bin/Xinamine"]) {
        const char *args[] = {"killall", "backboardd", NULL};
        posix_spawn(&pid, ROOT_PATH("/usr/bin/killall"), NULL, NULL, (char *const *)args, environ);
    } else {
        const char *args[] = {"sbreload", NULL};
        posix_spawn(&pid, ROOT_PATH("/usr/bin/sbreload"), NULL, NULL, (char *const *)args, environ);
    }
}

- (BOOL)shouldBeginTransitionToExpandedContentModule {
    if (self.action != nil && [self.action.dueIn timeIntervalSinceNow] < 0) {
        self.action = nil;
    }
    return self.action == nil;
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

- (void)controlCenterDidDismiss {
    [self.actionLabelViewController controlCenterDidDismiss];
}

- (void)controlCenterWillPresent {
    if (self.action != nil && [self.action.dueIn timeIntervalSinceNow] >= 0) {
        [self.actionLabelViewController setupWithAction:self.action];
    } else {
        self.action = nil;
    }

}

@end