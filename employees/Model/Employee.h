//
//  Employee.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//
#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Employee : NSObject

@property bool malformed;
@property NSString *uuid;
@property NSString *fullname;
@property NSString *phoneNumber;
@property NSString *emailAddress;
@property NSString *biography;
@property NSString *photoUrlSmall;
@property NSString *photoUrlLarge;
@property NSString *team;
@property EmpType employeeType;

- (instancetype)initWithDictionary:(NSDictionary *)employee;

@end
