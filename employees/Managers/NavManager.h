//
//  NavManager.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <UIKit/UIKit.h>
#import "Constants.h"


@interface NavManager : NSObject <UINavigationControllerDelegate>
{
    UINavigationController* navController;
}

+ (NavManager*)instance;

- (void)setNavigation:(UINavigationController*)nav;
- (void)goToPage:(Page)page withVC:(id)viewController;
@end
