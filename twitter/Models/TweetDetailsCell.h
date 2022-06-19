//
//  TweetDetailsCell.h
//  twitter
//
//  Created by Marthan Nodado on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetDetailsCell : UITableViewCell
@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel; // TODO: refactor name to "tweetTextView" to be more consistent


- (void)setTweetForCell:(Tweet *)tweet;


@end

NS_ASSUME_NONNULL_END
