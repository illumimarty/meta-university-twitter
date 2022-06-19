//
//  ComposeViewController.h
//  twitter
//
//  Created by Marthan Nodado on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
- (void)didTweet: (Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) id<ComposeViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *draftTextView;
@property (weak, nonatomic) IBOutlet UILabel *charCountLabel;


- (IBAction)didTapCloseButton:(id)sender;
- (IBAction)didTapPublishButton:(id)sender;
@end

NS_ASSUME_NONNULL_END
