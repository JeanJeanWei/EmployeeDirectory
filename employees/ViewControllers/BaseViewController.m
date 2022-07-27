//
//  BaseViewController.m
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//


#import "BaseViewController.h"

@implementation BaseViewController

const int navBarHeight = 70;
const int statusBarHeight = 20;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // setup BaseView title, navbar, and container CGRect after loading the view.
    CGRect rec = [[UIScreen mainScreen] bounds];
    bodyFrame = CGRectMake(rec.origin.x, rec.origin.y + navBarHeight, rec.size.width, rec.size.height - navBarHeight);
    rec.size.height = navBarHeight;
    UIView *navBar = [[UIView alloc] initWithFrame:rec];
    navBar.backgroundColor = UIColor.tintColor;
    rec.size.height = navBarHeight - statusBarHeight;
    rec.origin.y = statusBarHeight;
    title = [[UILabel alloc] initWithFrame:rec];
    title.textColor = UIColor.whiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.numberOfLines = 0;
    
    [navBar addSubview:title];
    [self.view addSubview:navBar];
    
    if (enableBackButton)
    {
        [self enableBackButton];
    }
}
- (void)setBackButton
{
    enableBackButton = YES;
}
- (void)enableBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"❮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, title.frame.size.height);
    [title setUserInteractionEnabled:YES];
    [title addSubview:button];
}
    
- (void)buttonClicked:(UIButton *)sender
{
    NSLog(@"back button clicked");
    [NavManager.instance goToPage:EmployeeList withVC:nil];
}

- (void)showAlert:(NSString*)title withMessage:(NSString*)msg
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                        actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                  NSLog(@"OK action");
                                }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
}

@end

