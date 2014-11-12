//
//  Posts.h
//  example
//
//  Created by Youwei Teng on 11/12/14.
//  Copyright (c) 2014 NTUE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger like;
@property (strong, nonatomic) NSString *forum_name;
@property (strong, nonatomic) NSString *forum_alias;
@property (strong, nonatomic) NSString *post_title;
@property (strong, nonatomic) NSString *post_createdAt;
@property (strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic) NSString *updatedAt;
@property (strong, nonatomic) NSString *member_school;
@property (strong, nonatomic) NSString *member_department;
@property (strong, nonatomic) NSString *member_gender;
@property (strong, nonatomic) NSString *version; //content

@property (nonatomic, assign) BOOL pinned;
@property (nonatomic, assign) BOOL anonymousDepartment;
@property (nonatomic, assign) BOOL anonymousSchool;
@property (nonatomic, assign) BOOL follow;
@property (nonatomic, assign) BOOL currentUser;
@property (strong, nonatomic) NSMutableArray *comments;



@end
