#import "ActionLabelViewController.h"

@interface  ActionLabelViewController ()
@property (strong, nonatomic) UILabel *actionLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval countdownTime;
@end

@implementation ActionLabelViewController
- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super initWithNibName:name bundle:bundle];
    if (self) {
        [self loadContent];
    }
    return self;
}
- (void)loadContent {
    self.view.clipsToBounds = YES;
    self.actionLabel = [UILabel new];
    self.actionLabel.textColor = UIColor.whiteColor;
    self.actionLabel.numberOfLines = 0;
    self.actionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.actionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.actionLabel.textAlignment = NSTextAlignmentCenter;
    self.actionLabel.font = [UIFont systemFontOfSize:14];

    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.actionLabel];

    [NSLayoutConstraint activateConstraints:@[
        [self.actionLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.actionLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.actionLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.actionLabel.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.actionLabel.text =  @"Hold me!";
}

- (void)updateTimerLabel:(NSTimer *)timer {
    if (self.countdownTime > 0) {
        self.countdownTime--;
        
        // Format the remaining time
        NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        formatter.includesApproximationPhrase = NO;
        formatter.includesTimeRemainingPhrase = NO;
        formatter.allowedUnits = NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSString *formattedTime = [formatter stringFromTimeInterval:self.countdownTime];
        
        // Update the label text
        NSString *actionString = timer.userInfo;
        self.actionLabel.text = [NSString stringWithFormat:@"%@ in %@",actionString, formattedTime];
    } else {
        [timer invalidate];
        self.timer = nil;
        self.actionLabel.text = @"Should happen anytime now";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)controlCenterDidDismiss {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.countdownTime = -1;
    self.actionLabel.text = @"Hold me!";
}

- (void)setupWithAction:(ShutdownAction *)action {
    self.countdownTime = [action.dueIn timeIntervalSinceNow];
    NSString *actionString = nil;
    switch (action.type) {
        case ShutdownActionTypeShutdown:
            actionString = @"Shutting down";
            break;
        case ShutdownActionTypeReboot:
            actionString = @"Restarting";
            break;
        case ShutdownActionTypeRespring:
            actionString = @"Respringing";
            break;
    }
    self.timer = [NSTimer 
        scheduledTimerWithTimeInterval:1.0
        target:self
        selector:@selector(updateTimerLabel:)
        userInfo:actionString 
        repeats:YES];
}
@end