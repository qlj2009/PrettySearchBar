//
//  ViewController.m
//  SearchDemo
//
//  Created by lijian qiu on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchDisplayController;
@synthesize allItems,searchResults;

- (void)dealloc {
	[allItems release];
	[searchResults release];
	[searchDisplayController release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.tableView.scrollEnabled = YES;
	self.allItems = [NSArray arrayWithObjects:
                      @"Code Geass",
                      @"Asura Cryin'",
                      @"Voltes V",
                      @"Mazinger Z",
                      @"Daimos",
                      nil];
	[self.tableView reloadData];
}

- (void)viewDidUnload
{
	[self setSearchDisplayController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger rows = 0;
	//显示的是searchTableView
    if (tableView == self.searchDisplayController.searchResultsTableView){
        rows = [self.searchResults count];
    }
    else{
        rows = [self.allItems count];
    }
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
		cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
	}else {
		cell.textLabel.text = [self.allItems objectAtIndex:indexPath.row];
	}
	
	
	
//    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
	
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark Search

- (void)filterContentForSearchText:(NSString*)searchText 
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
	
    self.searchResults = [self.allItems filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	UISearchBar * searchBar = [controller searchBar];
	[self filterContentForSearchText:searchString scope:[[searchBar scopeButtonTitles] objectAtIndex:[searchBar selectedScopeButtonIndex]]];
	return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
	UISearchBar * searchBar = [controller searchBar];
	[self filterContentForSearchText:[searchBar text] scope:[[searchBar scopeButtonTitles] objectAtIndex:searchOption]];
	return YES;
}

@end
