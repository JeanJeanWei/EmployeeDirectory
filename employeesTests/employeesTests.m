//
//  employeesTests.m
//  employeesTests
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <XCTest/XCTest.h>

@interface employeesTests : XCTestCase

@end
#import "Employee.h"
#import <Foundation/Foundation.h>
@implementation employeesTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testJsonResponse {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"sample" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *employees = json[@"employees"];
    
    [employees enumerateObjectsUsingBlock:^(NSDictionary* emp, NSUInteger idx, BOOL *stop) {
        Employee *e = [[Employee alloc] initWithDictionary:emp];
        //NSString *full_name = emp[@"full_name"];
        NSLog(@"full_name: %@", e.fullname);
        NSLog(@"employee_type: %u", e.employeeType);
    }];
    XCTAssert(json != nil);
}

- (void)test
{
    //NSString *URLString = @"https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json";
    //NSString *URLString = @"https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json";
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
