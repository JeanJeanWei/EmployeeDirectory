//
//  BaseViewController.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <UIKit/UIKit.h>
#import "NavManager.h"
#import "Constants.h"
@interface BaseViewController : UIViewController
{
    UILabel *title;
    CGRect bodyFrame;
    bool enableBackButton;
}

- (void)setBackButton;
- (void)showAlert:(NSString*)title withMessage:(NSString*)msg;
@end
