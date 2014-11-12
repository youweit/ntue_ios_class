//
//  ViewController.m
//  example
//
//  Created by Youwei Teng on 11/12/14.
//  Copyright (c) 2014 NTUE. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "CustomViewCell.h"
#import "PostModel.h"
#import "ViewPostViewController.h"
@interface ViewController (){
    NSMutableArray *postsList;
    int pageCount;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    pageCount = 1;
    postsList = [NSMutableArray new];
    
    [self GetPostsFromServerAt: pageCount];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewPost"]) {
        if ([sender class] == [PostModel class]){
            ViewPostViewController *controller = segue.destinationViewController;
            controller.post = sender;
        }
    }
}

#pragma mark - UITableView delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"ViewPost" sender:(PostModel *)[postsList objectAtIndex: indexPath.row]];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return [_posts count];
    return [postsList count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   //@"CustomViewCell";
    CustomViewCell *cell = (CustomViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"CustomViewCell"];
    PostModel *tmp = ((PostModel *)postsList[indexPath.row]);
    NSString *schoolinfo = [NSString stringWithFormat:@"%@ %@",tmp.member_school, tmp.member_department];
    cell.title.text = tmp.post_title;
    cell.schoolInfo.text = schoolinfo;
    cell.category.text = tmp.forum_name;
    if (indexPath.row == [postsList count] - 1)
    {
        [self loadMorePosts];
    }
    
    return cell;
}



-(void) GetPostsFromServerAt:(int) page {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET: [NSString stringWithFormat:@"http://www.dcard.tw/api/forum/all/%d/", page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        
        NSArray *postsArray = responseObject;
        
        for( NSDictionary *postDic in postsArray){
            PostModel *post = [[PostModel alloc]init];
            for(NSString *key in postDic){
                //NSLog(@"%@ %@", key, [postDic valueForKey:key]);
                if([key isEqualToString:@"member"]){
                    NSDictionary *memberDic = postDic[key];
                    for(NSString *mkey in memberDic){
                        NSString *model_mkey = [NSString stringWithFormat:@"member_%@",mkey];
                        if([post respondsToSelector:NSSelectorFromString(model_mkey)]){
                            [post setValue:[memberDic valueForKey:mkey] forKey:model_mkey];
                            //NSLog(@"%@ %@",model_mkey, [post valueForKey:model_mkey]);
                        }
                    }
                }
                
                if([post respondsToSelector:NSSelectorFromString(key)]){
                    if([key isEqualToString:@"version"]){
                        NSArray *versions = postDic[@"version"];
                        for(NSDictionary *postInfoDic in versions){
                            for(NSString *postInfoKey in postInfoDic){
                                //NSLog(@"%@ %@",postInfoKey,[postInfoDic valueForKey:postInfoKey]);
                                if([postInfoKey isEqualToString:@"title"]){
                                    post.post_title  = [postInfoDic valueForKey:postInfoKey];
                                }else if([postInfoKey isEqualToString:@"createdAt"]){
                                    post.post_createdAt  = [postInfoDic valueForKey:postInfoKey];
                                }else if([postInfoKey isEqualToString:@"content"]){
                                    post.version = [postInfoDic valueForKey:postInfoKey];
                                }
                                
                            }
                        }
                    } else {
                        [post setValue:[postDic valueForKey:key] forKey:key];
                    }
                }
                //NSLog(@"%@ %@", key, [friendDic valueForKey:key]);
            }
            [postsList addObject:post];
            
            [_tableView reloadData];
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}


-(void) loadMorePosts
{
    pageCount++;
    NSLog(@"page = %d", pageCount);
    [self GetPostsFromServerAt: pageCount];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
