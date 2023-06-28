#import <Foundation/Foundation.h>
#import <substrate.h>
// -(NSString*)_hoursStringForHour:(NSInteger)hour {
//     return @"minutes";
// }

static NSString *override_hours(id self, SEL _cmd, NSInteger hour) {
    return @"minutes";
}

__attribute__((constructor)) static void init(){
    Class dp_class = objc_getClass("_UIDatePickerView");
    MSHookMessageEx(dp_class, @selector(_hoursStringForHour:), (IMP) &override_hours, NULL);
}