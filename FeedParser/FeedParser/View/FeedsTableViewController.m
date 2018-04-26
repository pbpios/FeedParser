//
//  FeedsTableViewController.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "FeedsTableViewController.h"

@interface FeedsTableViewController ()

@end

@implementation FeedsTableViewController
static NSString *CELLIDENTIFIER = @"CellIdentifier";

- (instancetype)initWithViewModel:(FeedViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStylePlain];
    if (!self) return nil;
    
    _feedViewModel = viewModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tableView.rowHeight = 60;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];
    [self.tableView reloadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(bindViewModel)];

    if (refreshControl == nil) {
        refreshControl = [[UIRefreshControl alloc]init];
        [self.tableView addSubview:refreshControl];
        [refreshControl addTarget:self action:@selector(bindViewModel) forControlEvents:UIControlEventValueChanged];
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self bindViewModel];
}


-(void)bindViewModel {
    [self showLoadingView];
    [self.feedViewModel pullFeedWithCompletionHandler:^(FeedData *feedData, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingView];
            if (refreshControl) {
                [refreshControl endRefreshing];
            }
            [self setTitle:self.feedViewModel.feedData.navigationTitle];
            [self.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedViewModel.feedData.feedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER forIndexPath:indexPath];
    [cell setFeedData:[self.feedViewModel.feedData.feedArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table view data delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feed *feedObject = self.feedViewModel.feedData.feedArray[indexPath.row];
    NSString *descriptionString = feedObject.descriptionString;
    UIFont *cellLabelFont = [UIFont systemFontOfSize:16];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGRect labelSize = [descriptionString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cellLabelFont} context:nil];
    CGFloat height = labelSize.size.height + 45;
    if (height < 80) {
        return 80;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
