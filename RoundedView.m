#import "RoundedView.h"

@implementation RoundedView {
    UIRectCorner _cornerMask;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // UIRectCorner cornerMask = UIRectCornerTopLeft | UIRectCornerTopRight;
    CGFloat cornerRadius = 42.0;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_cornerMask cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    self.layer.mask = maskLayer;
}
- (instancetype)initWithMask:(UIRectCorner)mask {
    self = [super init];
    if (self) {
        _cornerMask = mask;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end