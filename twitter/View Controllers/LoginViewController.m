//
//  LoginViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[APIManager shared] isAuthorized]) {
        [self goToTimeline];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogin:(id)sender {
    [[APIManager shared] loginWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            [self goToTimeline];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)goToTimeline {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *tweetsNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TweetsNavigationController"];
    UITabBarController *tabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
