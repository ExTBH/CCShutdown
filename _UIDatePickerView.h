#import <UIKit/UIKit.h>

@interface _UIDatePickerView : UIPickerView {
    UILabel *_hourLabel;
    UILabel *_minuteLabel;
}
-(NSString*)_hoursStringForHour:(NSInteger)hour;
-(NSString*)_minutesStringForHour:(NSInteger)hour minutes:(NSInteger)minute;
- (NSInteger)pickerView:(UIPickerView *)pickerView 
numberOfRowsInComponent:(NSInteger)component;
@end