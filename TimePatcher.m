#import <Foundation/Foundation.h>
#import <substrate.h>

static NSString *override_hours(id self, SEL _cmd, NSInteger hour) {
    if (hour == 1) {
        return @"min";
    }
    return @"mins";
}
static NSString *override_minutes(id self, SEL _cmd, NSInteger hour, NSInteger minute) {
    if (minute == 1) {
        return @"sec";
    }
    return @"secs";
}

static NSInteger override_rows(id self, SEL _cmd, id picker, NSInteger component) {
    return 60;
}


__attribute__((constructor)) static void init(){
    Class dp_class = objc_getClass("_UIDatePickerView");
    MSHookMessageEx(dp_class, @selector(_hoursStringForHour:), (IMP) &override_hours, NULL);
    MSHookMessageEx(dp_class, @selector(_minutesStringForHour:minutes:), (IMP) &override_minutes, NULL);
    MSHookMessageEx(dp_class, @selector(pickerView:numberOfRowsInComponent:), (IMP) &override_rows, NULL);

}