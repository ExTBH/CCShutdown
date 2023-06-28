#import <UIKit/UIKit.h>
#import "ActionSelectionViewController.h"

@interface ActionLabelViewController : UIViewController
-(void)controlCenterDidDismiss;
-(void)setupWithAction:(ShutdownAction*)action;
@end