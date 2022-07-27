//
//  EmployeeDetailsViewController.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-16.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Employee.h"

@interface  EmployeeDetailsViewController : BaseViewController
{
    __unsafe_unretained Employee *employee;
    UIView *container;
}
@property (assign) Employee *employee;

- (void)setEmployeeDetails:(Employee*)emp;

@end
