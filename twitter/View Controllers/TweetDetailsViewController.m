//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Marthan Nodado on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "TweetDetailsCell.h"

@interface TweetDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    
    TweetDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetDetailsCell" forIndexPath:indexPath];
    
//    cell.usernameLabel.text = [NSString stringWithFormat:@"This is row %ld", (long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

@end
