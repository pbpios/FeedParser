//
//  BaseTableViewController.m
//  FeedParser
//
//  Created by Prashant on 4/27/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


-(void)showLoadingView
{
    if(loadingIndicator == nil){
        loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingIndicator.center =  self.view.center;
        [loadingIndicator setHidesWhenStopped:YES];
        loadingIndicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview: loadingIndicator];
    }
    [loadingIndicator startAnimating];
    [loadingIndicator setHidden:NO];
}

-(void)hideLoadingView
{
    [loadingIndicator setHidden:YES];
    [loadingIndicator stopAnimating];
}

@end
