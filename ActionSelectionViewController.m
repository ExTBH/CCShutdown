#import "ActionSelectionViewController.h"
#import "_UIDatePickerView.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import "RoundedView.h"

@implementation  ShutdownAction
+ (instancetype)actionWithType:(ShutdownActionType)type dueIn:(NSTimeInterval)dueTime {
    ShutdownAction *action = [ShutdownAction new];
    action.type = type;
    action.interval = dueTime;
    return  action;
}

@end
@interface  ActionSelectionViewController () {
    void (^_completionCallback)(ShutdownAction*);
}
@property (strong, nonatomic) UIDatePicker *picker;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) RoundedView *topView;
@property (strong, nonatomic) RoundedView *bottomView;

@end

@implementation ActionSelectionViewController 

- (instancetype)initWithCompletionCallback:(void (^__strong)(ShutdownAction*))completionCallback {
    self = [super init];
    if (self) {
        self.view.clipsToBounds = YES;
        _completionCallback = completionCallback;
        [self loadContent];
    }
    return  self;
}
- (void)loadContent {
    [self prepareTopView];
    [self prepareBottomView];

    self.picker = [UIDatePicker new];
    self.picker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.picker setValue:UIColor.whiteColor forKey:@"textColor"];
    self.picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.picker];

    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.confirmButton setTitle:@"Schedule" forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self prepareMenu];
    self.confirmButton.tintColor = UIColor.whiteColor;
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomView addSubview:self.confirmButton];

    [NSLayoutConstraint activateConstraints:@[
        [self.confirmButton.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.bottomView.safeAreaLayoutGuide.topAnchor],
        [self.confirmButton.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.bottomView.safeAreaLayoutGuide.leadingAnchor],
        [self.confirmButton.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.bottomView.safeAreaLayoutGuide.trailingAnchor],
        [self.confirmButton.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.bottomView.safeAreaLayoutGuide.bottomAnchor]
    ]];


    [NSLayoutConstraint activateConstraints:@[
        [self.picker.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.topView.safeAreaLayoutGuide.bottomAnchor constant:10],
        [self.picker.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.picker.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.picker.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.bottomView.safeAreaLayoutGuide.topAnchor constant:-10]
    ]];
}

- (void)prepareTopView {
    self.topView = [[RoundedView alloc] initWithMask:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 0.3];

    [NSLayoutConstraint activateConstraints:@[
        [self.topView.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.topView.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.topView.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.topView.safeAreaLayoutGuide.heightAnchor constraintEqualToConstant:80]
    ]];


    UILabel *topViewLabel = [UILabel new];
    topViewLabel.text = @"Select time for Count Down";
    topViewLabel.font = [UIFont systemFontOfSize:17];
    topViewLabel.textColor = UIColor.whiteColor;
    topViewLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topView addSubview:topViewLabel];

    [NSLayoutConstraint activateConstraints:@[
        [topViewLabel.centerXAnchor constraintEqualToAnchor:self.topView.centerXAnchor],
        [topViewLabel.centerYAnchor constraintEqualToAnchor:self.topView.centerYAnchor]
    ]];
}

- (void)prepareBottomView {
    self.bottomView = [[RoundedView alloc] initWithMask:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    [self.view addSubview:self.bottomView];
    self.bottomView.backgroundColor = [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 0.3];
    [NSLayoutConstraint activateConstraints:@[
        [self.bottomView.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.bottomView.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.bottomView.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [self.bottomView.safeAreaLayoutGuide.heightAnchor constraintEqualToConstant:80]
    ]];
}

- (void)prepareMenu {
    UIAction *shutdownAction = [UIAction actionWithTitle:@"Shutdown" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action){
        [self callCallbackWithType:ShutdownActionTypeShutdown];
    }];
    UIAction *ac2 = [UIAction actionWithTitle:@"Reboot" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action){
        [self callCallbackWithType:ShutdownActionTypeReboot];
    }];
    UIAction *ac3 = [UIAction actionWithTitle:@"Respring" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action){
        [self callCallbackWithType:ShutdownActionTypeRespring];
    }];
    UIMenu *menu = [UIMenu menuWithTitle:@"Schdule for" children:@[shutdownAction, ac2, ac3]];
    
    self.confirmButton.menu = menu;
    self.confirmButton.showsMenuAsPrimaryAction = YES;
}
- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)callCallbackWithType:(ShutdownActionType)actionType {
    ShutdownAction *action = [ShutdownAction actionWithType:actionType dueIn:[self getDueTime]];
    _completionCallback(action);
}

- (NSTimeInterval)getDueTime {
    _UIDatePickerView *internal_picker = [self.picker valueForKey:@"_pickerView"];
    NSInteger mints = [internal_picker selectedRowInComponent:0];
    NSInteger secs = [internal_picker selectedRowInComponent:1];
    NSTimeInterval due = (mints * 60) + secs;
    return  due;
}

@end