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


@interface ComposeViewController () <UITextViewDelegate>
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.draftTextView.delegate = self;
    [self.charCountLabel setText:[NSString stringWithFormat:@"%d", 280]];
    // Do any additional setup after loading the view.
}


// Updates text label with the remaining characters left before maxing out char limit
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // TODO: check the proposed new text char count
    
    int charLimit = 280;
    int charsLeft = charLimit - (int)self.draftTextView.text.length;

    // Construct what new text would be if we allowed the user's latest edit
    NSString *newText = [self.draftTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: update character count
    [self.charCountLabel setText:[NSString stringWithFormat:@"%d", charsLeft]];
    
    // SHould the new text be allowed to show on the view?
    return newText.length < charLimit;

}

- (void)publishTweet {
    NSString *tweetDraftString = self.draftTextView.text;
    
    // MARK: if draft is filled with text, post tweet!
    if (tweetDraftString) {
        NSLog(@"%@", tweetDraftString);
        [[APIManager shared]postStatusWithText: self.draftTextView.text completion:^(Tweet *tweet, NSError *error) {
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
