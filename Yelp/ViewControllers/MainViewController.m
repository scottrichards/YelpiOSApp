//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "FilterViewController.h"
#import "YelpBusiness.h"
#import "YelpClient.h"
#import "Yelp-Swift.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *businesses;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessCellTableViewCell"];
    [YelpBusiness searchWithTerm:@"Restaurants"
                        sortMode:YelpSortModeBestMatched
                      categories:@[@"burgers"]
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          for (YelpBusiness *business in businesses) {
                              NSLog(@"%@", business);
                          }
                          [self.tableView reloadData];
                      }];
    self.title = @"Yelp";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    
//    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self];
//    // [self.navigationController presentModalViewController:passcodeNavigationController animated:YES];
//    [self presentViewController:mainNavigationController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onSearch:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCellTableViewCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

#pragma mark - Private methods

- (void) onFilterButton
{
    FilterViewController *filterViewController = [[FilterViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:filterViewController];
    [self presentViewController:navController animated:YES completion:nil];
}
@end
