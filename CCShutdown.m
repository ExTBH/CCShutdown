#import "CCShutdown.h"
#import <UIKit/UIKit.h>
#import <objc/objc-runtime.h>
#import "CCShutdownModuleViewController.h"

@implementation CCShutdown  
@synthesize contentViewController;
@synthesize backgroundViewController;
- (instancetype)init {
    self = [super init];
    if (self) {
        contentViewController = [CCShutdownModuleViewController new];
	}
    return self;
}
- (CCUILayoutSize)moduleSizeForOrientation:(int)orientation {
    return (CCUILayoutSize){2, 1};
}

@end

