//
//  ViewController.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//
#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Employee.h"
#import "EmployeeDetailsViewController.h"

@implementation ViewController

NSString *URLString = @"https://s3.amazonaws.com/sq-mobile-interview/employees.json";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    title.text = @"Employees";
    [self enableReloadButton];
    
    empListView = [[UITableView alloc] initWithFrame:bodyFrame];
    empListView.dataSource = self;
    empListView.delegate=  self;
    [self.view addSubview:empListView];
    
    [self sendRequestFromURL:URLString completion: ^{
        //The code that you want to run when the data task is complete, using
        [self->empListView reloadData];
    }];
}

- (void)enableReloadButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"↺" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake( title.frame.size.width - 50-10, 0, 50, title.frame.size.height);
    [title setUserInteractionEnabled:YES];
    [title addSubview:button];
}
- (void)buttonClicked:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"API"
                                          message:@"Please select a reload site."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *normalAction = [UIAlertAction
                        actionWithTitle:NSLocalizedString(@"Normal", @"Normal action")
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"normal action");
                                    [self endpointTapped: @"https://s3.amazonaws.com/sq-mobile-interview/employees.json"];
                                }];
    UIAlertAction *emptyAction = [UIAlertAction
                actionWithTitle:NSLocalizedString(@"Empty", @"Empty action")
                          style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction *action)
                        {
                            NSLog(@"empty action");
                            [self endpointTapped:@"https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"];
                        }];
    UIAlertAction *malformedAction = [UIAlertAction
                actionWithTitle:NSLocalizedString(@"Malformed", @"Empty action")
                          style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction *action)
                        {
                            NSLog(@"empty action");
                            [self endpointTapped:@"https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"];
                        }];
            [alertController addAction:normalAction];
            [alertController addAction:malformedAction];
            [alertController addAction:emptyAction];
            [self presentViewController:alertController animated:NO completion:nil];
}

- (void)endpointTapped:(NSString*)url
{
    URLString = url;
    [self sendRequestFromURL:URLString completion: ^{
        
        [self->empListView reloadData];
    }];
}

- (void)sendRequestFromURL:(NSString*)url completion:(void (^)(void)) completion
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithRequest: request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
        if (error != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlert:error.localizedDescription withMessage:error.localizedFailureReason];
            });
        }
        [self prepareData:data];
          
        if (completion != nil)
        {
           //The data task's completion block runs on a background thread
           //by default, so invoke the completion handler on the main thread
           //for safety
           dispatch_async(dispatch_get_main_queue(), completion);
        }
      }];
      [task resume];
}

- (void)prepareData:(NSData*)jsonResponse
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonResponse options:kNilOptions error:&error];
    if (error != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlert:error.localizedDescription withMessage:error.localizedFailureReason];
        });
    }
    NSArray *employees = json[@"employees"];
    if (employees == nil || employees.count == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlert:@"Empty List" withMessage:@"The employee list is empty."];
        });
    }
    empList = [NSMutableArray new];
    [employees enumerateObjectsUsingBlock:^(NSDictionary* emp, NSUInteger idx, BOOL *stop) {
        Employee *e = [[Employee alloc] initWithDictionary:emp];
        if (e.malformed)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlert:@"Malformed List" withMessage:@"The employee list is malformed."];
            });
            empList = nil;
            return;
        }
        else
        {
            [empList addObject:e];
        }
    }];
}

#pragma mark Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 1;
    return empList.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    int index = (int)indexPath.row;
    Employee *emp = [empList objectAtIndex:index];
    cell.textLabel.text = emp.fullname;
    cell.detailTextLabel.text = emp.emailAddress;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"user_icon.png"];
    // lazy loading image
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: emp.photoUrlSmall]];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithRequest: request
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
        // Now it is done. Tell the main thread to update cell image.
        if (error == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                    cell.imageView.image = [[UIImage alloc] initWithData:data];
                
            });
        }
      }];
      [task resume];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"selected order = %d",(int)indexPath.row);
    EmployeeDetailsViewController *empVC = [EmployeeDetailsViewController new];
    [empVC setBackButton];
    [empVC setEmployeeDetails:[empList objectAtIndex:(int)indexPath.row]];
    
    [NavManager.instance goToPage:EmplyeeDetails withVC:empVC];
}



@end
