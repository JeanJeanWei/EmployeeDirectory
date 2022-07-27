//
//  ViewController.h
//  employees
//
//  Created by Jean-Jean Wei on 2022-07-15.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *empList;
    UITableView *empListView;
    UIPopoverPresentationController *poppy;
}


@end

