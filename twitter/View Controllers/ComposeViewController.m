//
//  ComposeViewController.m
//  twitter
//
//  Created by Marthan Nodado on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"


@interface ComposeViewController ()
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)publishTweet {
    NSString *tweetDraftString = self.draftTextView.text;
    
    // MARK: if draft is filled with text, post tweet!
    if (tweetDraftString) {
        NSLog(@"%@", tweetDraftString);
        [[APIManager shared]postStatusWithText:@"apparently my code doesnt work 🥲" completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            }
            else{
                [self.delegate didTweet:tweet];
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Compose Tweet Success!");
            }
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Draft is empty" message:@"Type out a tweet before publishing!" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    
}

- (IBAction)didTapPublishButton:(id)sender {
    [self publishTweet];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
