## Build tools & versions used
-- This app is builded by Xcode version 13.2.1 (13C100)


## Steps to run the app
-- Click employees.xcodeproj -> Xcode -> Run (or Product Tab -> Run)
-- "↺" button on the up right corner to reload Table from different API endpoints. 
-- Tap table cell row ">" to display employee details.
-- This app is an iPhone only app.


## What areas of the app did you focus on?
-- I focused on modularised app features using model-view-controller, object-oriented, and singleton to manage screens and data pulling/manipulations.    

## What was the reason for your focus? What problems were you trying to solve?
-- I tried to seperate UI and data pulling/manipulating process. That way I can implement UI using local sample files for testing. I can also switch to data pulling and net working part when I see the time is fit. The Employee model class is the buffer between UI and networking. The UITableView can consume sample without networking feature is implemeted. Also, API endpoints data pulling feature can be implemented and feed to Employee model without UITableView feature is done. Once I am satisfied with the result from both sides of implementation. I can seamlessly wrap up both features for final product or tests.

## How long did you spend on this project?
-- 4 hours

## Did you make any trade-offs for this project? What would you have done differently with more time?
-- The Error messages are handled in the BaseViewController using UIAlertController and NSLog. I would implement a ErrorManager class to centralize the Error handing process if I have more time.
-- The API endpoints data pulling feature is implemented in ViewController(s) to such as sendRequestFromURL methods. I would implement a NetworkManager class to centralize the data pulling process if I have more time.
-- The reload UI feature is currently implemented using UIButton and UIAlertController in the ViewController for user to choose API endpoints. I might consider to build a separate module for this feature.  

## What do you think is the weakest part of your project?
-- This app doesn't pre-check for network reachability before sending API endpoint requests. It depends on NSURLResponse *response, and  NSError *error to determine if the networking is success or not. 

 
## Did you copy any code or dependencies? Please make sure to attribute them here!
--  I used codes from stackoverflow to implement sendRequestFromURL method in ViewController for API endpoints data pulling https://stackoverflow.com/questions/37628930/wait-for-nsurlsessiondatatask-to-come-back
-- I reuse NavManager, StartupController, BaseViewController, Constants, and UITableView (UITableViewDataSource, UITableViewDelegate) codes from my personal projects.

## Is there any other information you’d like us to know?
-- I builded a json test method in the employeesTests (testJsonResponse) using local sample json file to parse JsonResponse and build Employee model.
