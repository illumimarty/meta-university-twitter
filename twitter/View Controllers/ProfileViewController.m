//
//  ProfileViewController.m
//  twitter
//
//  Created by Marthan Nodado on 6/5/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "User.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self fetchCurrentUserData];
//    self.user = [[User alloc] initWithDictionary:self.userDictionary];
    
    // Do any additional setup after loading the view.
    

}

- (void)fetchCurrentUserData {
    [[APIManager shared] getCurrentUserProfile:^(User *user, NSError *error) {
        if (user) {
            NSLog(@"😎😎😎 Successfully fetched user data!");
            
//            self.userDictionary = user;
//            User* newUser = [[User alloc] initWithDictionary:user];
            
            [self setUser:user];
            [self initalizeViewController];
            
//            NSLog(@"%@", user);
//            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error fetching user data: %@", error.localizedDescription);
        }
    }];
}

- (void)initalizeViewController {
    self.usernameLabel.text = self.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.bioLabel.text = self.user.bio;
    self.tweetCountLabel.text = [NSString stringWithFormat:@"%d Tweets", self.user.tweetCount];
    self.followerCountLabel.text = [NSString stringWithFormat:@"%d Followers", self.user.followersCount];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%d Following", self.user.friendsCount];

    
    NSURL *url = [NSURL URLWithString:self.user.profilePicture];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profileImageView.image = [UIImage imageWithData:urlData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
