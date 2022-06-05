//
//  User.h
//  twitter
//
//  Created by Marty Nodado on 5/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// MARK: Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic) int *tweetCount;
@property (nonatomic) int *followersCount;
@property (nonatomic) int *friendsCount;
//@property (nonatomic, strong) NSString *profilePicture;

// MARK: Initializer Method
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
