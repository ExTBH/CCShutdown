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


    // self.countdownTime = 1.1 * 60;

// Create an NSTimer to update the countdown label
    // self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimerLabel:) userInfo:nil repeats:YES];
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
        self.actionLabel.text = [NSString stringWithFormat:@"Shutting down in %@", formattedTime];
    } else {
        // Countdown reached zero, stop the timer or perform any necessary actions
        [timer invalidate];
        self.actionLabel.text = @"Countdown completed!";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}
@end