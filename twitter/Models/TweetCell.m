//
//  TweetCell.m
//  twitter
//
//  Created by Marty Nodado on 5/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    
    User *user = tweet.user;
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    NSString *date = tweet.createdAtString;
    NSString *username = user.screenName;
    NSString *tweetContent = tweet.text;
    
    self.usernameLabel.text = username;
    self.tweetLabel.text = tweetContent;
    self.profileImageView.image = [UIImage imageWithData:urlData];
    self.dateLabel.text = date;
    self.screennameLabel.text = user.screenName;
}

@end
