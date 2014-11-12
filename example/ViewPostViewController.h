//
//  ViewPostViewController.h
//  example
//
//  Created by Youwei Teng on 11/12/14.
//  Copyright (c) 2014 NTUE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"

@interface ViewPostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) PostModel *post;

@end
