//
//  EmployeeDetailsViewController.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-16.
//

#import "EmployeeDetailsViewController.h"
#import "Constants.h"

@implementation EmployeeDetailsViewController

@synthesize employee;

const int Margin = 20;
const int Space = 10;
int width;
int photoWidth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    title.text = @"Employee Deatils";
    
    container = [[UIView alloc] initWithFrame:bodyFrame];
    container.backgroundColor = UIColor.whiteColor;
    width = bodyFrame.size.width - Margin*2 ;
    photoWidth = (width - Space) / 2;
    int rowHeight = 40;
    int pos_x = Margin;
    int pos_y = Margin;
    
    UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(pos_x, pos_y, photoWidth, photoWidth)];
    [photo setImage:[UIImage imageNamed:@"user_icon.png"]];
    [self loadImage:photo];
    pos_y += Space + photoWidth;
    [container addSubview:photo];
    
    [self addLabel:CGRectMake(pos_x, pos_y, width, rowHeight) withText:employee.fullname];
    pos_y += Space + rowHeight;
    
    [self addLabel:CGRectMake(pos_x, pos_y, width, rowHeight) withText:employee.team];
    pos_y += Space + rowHeight;
    
    NSString *type = @"";
    switch (employee.employeeType)
    {
        case FullTime:
        type = @"Full Time";
        break;
            
        case PartTime:
        type = @"Part Time";
        break;
            
        case Contractor:
        type = @"Contractor";
        break;
            
        default:
            NSLog(@"Unknown employee type");
            return;
            break;
    }
    [self addLabel:CGRectMake(pos_x, pos_y, width, rowHeight) withText:type];
    pos_y += Space + rowHeight;
    
    [self addLabel:CGRectMake(pos_x, pos_y, width, rowHeight) withText:employee.phoneNumber];
    pos_y += Space + rowHeight;
    
    [self addLabel:CGRectMake(pos_x, pos_y, width, rowHeight) withText:employee.emailAddress];
    
    pos_x += photoWidth + Space;
    pos_y = Margin;
    UITextView *bio = [[UITextView alloc] initWithFrame:CGRectMake(pos_x, pos_y, photoWidth, photoWidth)];
    bio.editable = false;
    bio.text = employee.biography;
    [container addSubview:bio];
    
    [self.view addSubview:container];
}

- (void)setEmployeeDetails:(Employee*)emp
{
    employee = emp;
}

- (void)addLabel:(CGRect)rect withText:(NSString*)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    [container addSubview:label];
}

- (void)loadImage:(UIImageView*)imgView
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: employee.photoUrlLarge]];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithRequest: request
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
        if (error == nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                imgView.image = [[UIImage alloc] initWithData:data];
            });
        }
      }];
      [task resume];
}
@end

