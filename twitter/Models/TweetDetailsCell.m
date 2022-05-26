//
//  TweetDetailsCell.m
//  twitter
//
//  Created by Marthan Nodado on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsCell.h"

@implementation TweetDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweetForCell:(Tweet *)tweet {
    self.tweet = tweet;
    User *user = tweet.user;

    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    self.usernameLabel.text = user.name;
    self.tweetLabel.text = tweet.text;
//    self.dateLabel.text = tweet.createdAtString; // formatted date to DD/MM/YY
    self.profileImageView.image = [UIImage imageWithData:urlData];
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
//    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
//    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
}


@end
