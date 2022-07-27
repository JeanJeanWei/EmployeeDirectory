//
//  Employee.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//
#import "Employee.h"

@implementation Employee

- (instancetype)initWithDictionary:(NSDictionary *)employee
{
    self = [super init];
    if (self) {
        _uuid = employee[@"uuid"];
        _fullname = employee[@"full_name"];
        _phoneNumber = employee[@"phone_number"];
        _emailAddress = employee[@"email_address"];
        _biography = employee[@"biography"];
        _photoUrlSmall = employee[@"photo_url_small"];
        _photoUrlLarge = employee[@"photo_url_large"];
        _team = employee[@"team"];
        NSString *eType = employee[@"employee_type"];
        if ([eType isEqualToString:@"FULL_TIME"])
        {
            _employeeType = FullTime;
        }
        else if ([eType isEqualToString:@"PART_TIME"])
        {
            _employeeType = PartTime;
        }
        else if ([eType isEqualToString:@"CONTRACTOR"])
        {
            _employeeType = Contractor;
        }
        if (_fullname == nil || _uuid == nil || _emailAddress == nil || eType == nil || _team == nil)
        {
            _malformed = YES;
        }
       
    }
    return self;
}

@end
