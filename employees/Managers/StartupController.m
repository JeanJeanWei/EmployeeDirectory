//
//  StartupController.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import "StartupController.h"
#import "NavManager.h"
#import "ViewController.h"

@implementation StartupController

+ (StartupController*)instance
{
    static StartupController* instance = nil;
    
    if (!instance)
    {
        instance = [StartupController new];
    }
    
    return instance;
}

- (UIViewController*)startingViewController
{
    ViewController* vc = [ViewController new];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [navigationController setNavigationBarHidden:YES];
 
    [NavManager.instance setNavigation:navigationController];
    
    return navigationController;
}

@end
