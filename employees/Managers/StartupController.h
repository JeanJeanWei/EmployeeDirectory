//
//  StartupController.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StartupController : NSObject
{

}
+ (StartupController*)instance;

// update to specify the starting view controller for the application
- (UIViewController*)startingViewController;

@end
