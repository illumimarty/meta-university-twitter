//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "LoginViewController.h"
#import "TimelineViewController.h"
#import "TweetDetailsViewController.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "AppDelegate.h"


@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweetsArray;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self loadTweets:20];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButton:(UIBarButtonItem *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}


- (void)logout {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}



- (void)loadTweets:(int)tweetCountNumber {
    // Get timeline
    
    NSString *tweetCount = [NSString stringWithFormat:@"%d", tweetCountNumber];
    
    [[APIManager shared] getHomeTimelineWithCompletion:tweetCount completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetsArray = (NSMutableArray *)tweets;
            self.isMoreDataLoading = NO;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // Loading new tweets
    [self loadTweets:20];

    // ... Use the new data to update the data source ...

    // Reload the tableView now that there is new data
    [self.tableView reloadData];

    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];

}

- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"timelineToDetail"]){
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        TweetDetailsViewController *vc = [segue destinationViewController];
        Tweet *tweetToPass = self.tweetsArray[indexPath.row];
        vc.tweet = tweetToPass;
//        DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
//        controller.isDetailingEnabled = YES;
    }
    
    if ([segue.identifier isEqualToString:@"timelineToCompose"]) {
        UINavigationController *nav = [segue destinationViewController];
        ComposeViewController *composeVC = (ComposeViewController*)nav.topViewController;
        composeVC.delegate = self;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.tweetsArray[indexPath.row];  // Extracting tweet and user data to models
    [cell setTweetForCell:tweet]; // Assigning values to TweetCell properties

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row + 1 == [self.tweetsArray count] && self.isMoreDataLoading == NO){
        self.isMoreDataLoading = YES;
        [self loadTweets:(int)[self.tweetsArray count] + 20];
    }
}

- (void)didTweet:(nonnull Tweet *)tweet {
    
    // MARK: run method after current user publishes a tweet
    
    
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

@end
