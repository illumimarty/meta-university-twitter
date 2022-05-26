//
//  TweetCell.m
//  twitter
//
//  Created by Marty Nodado on 5/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell

// TODO: Create starting states for each cell

BOOL isFavorited = NO;



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

    NSString *date = tweet.createdAtString;
    NSString *username = user.name;
    NSString *tweetContent = tweet.text;

    self.usernameLabel.text = username;
    self.tweetLabel.text = tweetContent;
    self.profileImageView.image = [UIImage imageWithData:urlData];
    self.dateLabel.text = date;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
}

//- (instancetype)initWithTweet:(Tweet *)tweet {
//    self = [super init];
//    if (self) {
//        User *user = tweet.user;
//
//        NSString *URLString = tweet.user.profilePicture;
//        NSURL *url = [NSURL URLWithString:URLString];
//        NSData *urlData = [NSData dataWithContentsOfURL:url];
//
//        NSString *date = tweet.createdAtString;
//        NSString *username = user.name;
//        NSString *tweetContent = tweet.text;
//
//        self.usernameLabel.text = username;
//        self.tweetLabel.text = tweetContent;
//        self.profileImageView.image = [UIImage imageWithData:urlData];
//        self.dateLabel.text = date;
//        self.screennameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
//    }
//    return self;
//}
        


- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    // TODO: Update cell UI
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

@end
