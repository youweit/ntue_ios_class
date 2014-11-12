//
//  ViewController.h
//  example
//
//  Created by Youwei Teng on 11/12/14.
//  Copyright (c) 2014 NTUE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

