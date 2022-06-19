//
//  Tweet.m
//  twitter
//
//  Created by Marty Nodado on 5/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"


@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        NSLog(@"%@", dictionary);
        
        // Is this a retweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary: userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        
        self.idStr = dictionary[@"id_str"];
        
        if([dictionary valueForKey:@"full_text"] != nil) {
            self.text = dictionary[@"full_text"]; // uses full text if Twitter API provided it
        } else {
            self.text = dictionary[@"text"]; // fallback to regular text that Twitter API provided
        }
        
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // TODO: Check if tweet has entities -> media object
        NSDictionary *entities = dictionary[@"entities"];
        
        if ([entities objectForKey:@"media"] != nil) { // extract media URL, if available
            NSArray *media = entities[@"media"];
            self.mediaURLString = media[0][@"media_url_https"];
        } else {
            self.mediaURLString = @"";
        }
        
        
        // TODO: initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary: user];
        
        
        // TODO: Format and set createdAtString
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
    }
    
    return self;
}

+ (NSMutableArray *)tweetsWithArray: (NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary: dictionary];
        [tweets addObject: tweet];
    }
    
    return tweets;
}


@end
