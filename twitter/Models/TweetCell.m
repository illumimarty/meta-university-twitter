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
    self.dateLabel.text = tweet.createdAtString; // formatted date to DD/MM/YY
    self.profileImageView.image = [UIImage imageWithData:urlData];
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    if (tweet.mediaURLString.length != 0) {
        NSURL *url = [NSURL URLWithString:tweet.mediaURLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        self.mediaImageView.image = [UIImage imageWithData:urlData];
    }
    
}

- (IBAction)didTapFavorite:(id)sender {
    
    // MARK: Update the local tweet model
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }

    // MARK: Update cell UI
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    
    // MARK: Send a POST request to the POST favorites/create or favorites/destroy endpoint
    if (self.tweet.favorited) {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully UNfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    
    // MARK: Update the local tweet model
    if (self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
    } else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
    }

    // MARK: Update cell UI
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    
    // MARK: Send a POST request to the POST favorites/create or favorites/destroy endpoint
    if (self.tweet.retweeted) {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeted tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully UNretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
}

@end
