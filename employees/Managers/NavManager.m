//
//  NavManager.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <Foundation/Foundation.h>
#import "NavManager.h"
#import "Employee.h"

@implementation NavManager

+ (NavManager*)instance
{
    static NavManager* instance = nil;
    
    if (!instance)
    {
        instance = [NavManager new];
    }
    return instance;
}


- (void)setNavigation:(UINavigationController*)nav
{
    navController = nav;
}
- (void)goToPage:(Page)page withVC:(id)viewController
{
    if (page == EmployeeList)
    {
        [navController popToRootViewControllerAnimated:YES];
    }
    else if (page == EmplyeeDetails)
    {
        [navController popToRootViewControllerAnimated:NO];
 
        [navController pushViewController:viewController animated:NO];
    }
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
