#import "ActionSelectionViewController.h"
#import "_UIDatePickerView.h"

@interface  ActionSelectionViewController ()  /*<UIPickerViewDataSource, UIPickerViewDelegate> */ {
    void (^_completionCallback)(ShutdownAction);
}
@property (strong, nonatomic) UIDatePicker *picker;
@end

@implementation ActionSelectionViewController 

- (instancetype)initWithCompletionCallback:(void (^__strong)(ShutdownAction))completionCallback {
    self = [super init];
    if (self) {
        self.view.clipsToBounds = YES;
        _completionCallback = completionCallback;
        [self loadContent];
    }
    return  self;
}
- (void)loadContent {
    self.picker = [UIDatePicker new];
    self.picker.datePickerMode = UIDatePickerModeCountDownTimer;
    [self.picker setValue:UIColor.whiteColor forKey:@"textColor"];
    self.picker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.picker];

    // flip minuts and hours to minuts and second
    _UIDatePickerView *internal_picker = [self.picker valueForKey:@"_pickerView"];
    UIButton *someBtn = [UIButton new];
    [internal_picker addSubview:someBtn];
    // UILabel *hoursLabel = [internal_picker valueForKey:@"_hourLabel"];
    // hoursLabel.text = @"minutes";s
    // hoursLabel.textColor = UIColor.systemRedColor;
    // [internal_picker setValue:hoursLabel forKey:@"_hourLabel"];

    [NSLayoutConstraint activateConstraints:@[
        [self.picker.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.picker.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.picker.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.picker.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}
- (void)viewDidLoad {
    self.view.backgroundColor = UIColor.clearColor;

}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return  2;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 61;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"Deez";
}

@end