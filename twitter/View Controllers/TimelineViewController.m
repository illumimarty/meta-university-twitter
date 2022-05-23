//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    APIManager *manager = [APIManager new];
//    [manager getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
//        self.tweetsArray = tweets;
//        [self.tableView reloadData];
//    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self loadTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTweets {
    // Get timeline
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//
//                Tweet *tweet = [Tweet]
//                [self.tweetsArray addObject: dictionary];
//            }

            self.tweetsArray = (NSMutableArray *)tweets;
//            self.tweetsArray = [Tweet tweetsWithArray:tweets];
            
            
            [self.tableView reloadData];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
//    Tweet *tweet = [Tweet ini]
    NSDictionary *tweet = self.tweetsArray[indexPath.row];
    NSDictionary *user = tweet[@"user"];
    
    NSString *username = user[@"screen_name"];
    NSString *tweetContent = tweet[@"text"];
    
    cell.usernameLabel.text = username;
    cell.tweetLabel.text = tweetContent;
//    cell.tweetLabel = tweet[@"text"];
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
