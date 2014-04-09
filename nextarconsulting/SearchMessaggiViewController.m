//
//  SearchMessaggiViewController.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 29/05/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import "SearchMessaggiViewController.h"

#import "MessaggiTableViewCell.h"
#import "DettaglioMessaggi.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "Lavori.h"

@interface SearchMessaggiViewController ()

@end

@implementation SearchMessaggiViewController

@synthesize MessaggiMakes = _MessaggiMakes; 
@synthesize MessaggiModels = _MessaggiModels;
@synthesize MessaggiImages = _MessaggiImages;
@synthesize Segment;
@synthesize managedObjectContext;
@synthesize currentMessaggi;
@synthesize MessaggiListData;
@synthesize searchbar;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.MessaggiModels count];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (managedObjectContext == nil) 
	{ 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext_: %@",  managedObjectContext);
	}
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     [self.tableView reloadData];
   
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessaggiTableCell";
    
    MessaggiTableViewCell *cell = [tableView
                                   dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessaggiTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:CellIdentifier];
    }
    
    
    
    Lavori *currentCell = [MessaggiListData objectAtIndex:indexPath.row];
    
    //  Fill in the cell contents
    
    cell.makeLabel.text = [currentCell title];
    cell.modelLabel.text = [currentCell title];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMessaggiDetails"])
    {
        DettaglioMessaggi *detailViewController = 
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView 
                                    indexPathForSelectedRow];
        
        detailViewController.MessaggiDetailModel = [[NSArray alloc]
                                                    initWithObjects: [self.MessaggiMakes 
                                                                      objectAtIndex:[myIndexPath row]],
                                                    [self.MessaggiModels objectAtIndex:[myIndexPath row]],
                                                    nil];
    }
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    searchbar.showsCancelButton = NO;
    searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
    // flush the previous search content
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText];
    // Return YES to cause the search result table view to be reloaded.
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}




-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)filterContentForSearchText:(NSString*)searchText {
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(title CONTAINS[cd] %@)",searchText];
    if ([CoreDataHelper countForEntity:@"Lavori" withPredicate:pred andContext:managedObjectContext] != 0)
    {
        MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:pred andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
        int app = MessaggiListData.count;
        int ciclo = 0;
        
        self.MessaggiMakes = [NSArray alloc];
        self.MessaggiModels = [NSArray alloc];
        self.MessaggiImages = [NSArray alloc];
        self.MessaggiMakes = [self.MessaggiMakes init];
        self.MessaggiModels = [self.MessaggiModels init];
        self.MessaggiImages = [self.MessaggiImages init];
        
        Lavori *currentCell ;
        
        //  Fill in the cell contents
        
        while (ciclo <= (app -1)) {
            currentCell = [MessaggiListData objectAtIndex:ciclo];
            
            
            /* code to act on each element as it is returned */
            self.MessaggiMakes =  [self.MessaggiMakes  arrayByAddingObject:[ currentCell title]];
            self.MessaggiModels =  [self.MessaggiModels arrayByAddingObject:[ currentCell title]];
          //  self.MessaggiImages =  [self.MessaggiImages arrayByAddingObject:[ currentCell link]];
            ciclo = ciclo +1;
        }

        
    }   
     [self.tableView reloadData];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)saearchBar {

}
@end
