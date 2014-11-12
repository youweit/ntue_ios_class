//
//  ViewPostViewController.m
//  example
//
//  Created by Youwei Teng on 11/12/14.
//  Copyright (c) 2014 NTUE. All rights reserved.
//

#import "ViewPostViewController.h"

@interface ViewPostViewController ()

@end

@implementation ViewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _content.text = _post.version;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
