//
//  MessaggiTableViewController.m
//  MedjugorjeLite
//
//  Created by Guglielmo Puglia on 21/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessaggiTableViewController.h"
#import "MessaggiTableViewCell.h"
#import "DettaglioMessaggi.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "Lavori.h"
#import "CheckConnessione.h"


@interface MessaggiTableViewController ()

@end

@implementation MessaggiTableViewController
@synthesize MessaggiMakes = _MessaggiMakes; 
@synthesize MessaggiModels = _MessaggiModels;
@synthesize MessaggiImages = _MessaggiImages;
@synthesize Segment;
@synthesize managedObjectContext;
@synthesize currentMessaggi;
@synthesize MessaggiListData;
@synthesize LblAttesa;
@synthesize indicatore;
@synthesize alert;
@synthesize AnniMutableArray;
@synthesize AnniTotaleMutableArray;
@synthesize NumUltimaPubblicazione;

NSString *tipoRichiesta;


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

-(void)viewDidAppear:(BOOL)animated
{
   [self changeSeg];
 
    
}
-(IBAction)changeSeg{
    
    
    alert.title =@"Attendere";
    alert.message = @"Caricamento Offerte";
    [alert show];
    
    
    int n = 0;
    while (n<50)
    {
        [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
        [NSThread sleepForTimeInterval:0.001];
        n++;
    }
    
  //  [self SelAuto:[Segment titleForSegmentAtIndex:1] :@"1"];
    [self gestiscidaticore:[NSString stringWithFormat:@"%d",2014] annoint:2014 cancella:0];
    
  	
    [alert dismissWithClickedButtonIndex:0 animated:true];
    [self.tableView reloadData];
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
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Attendere"
                                       message:@"Verifica Disponibilità Nuove Offerte"
                                      delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    indicator.center = CGPointMake(140, 90);
    self.view.backgroundColor = [UIColor whiteColor];
    AnniMutableArray = [[NSMutableArray alloc] init];
    AnniTotaleMutableArray = [[NSMutableArray alloc] init];
    contenutoTag = [[NSMutableString alloc] init];
   
    
    [self VerficaAggiornamenti];
    
    
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
    cell.modelLabel.text = [currentCell description_];
    
    cell.MessaggiImage.contentMode = UIViewContentModeScaleAspectFit;
   // cell.MessaggiImage.image = [UIImage imageWithData:[currentCell smallpicture]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
-(void) verificadati
{
    
    if ([CoreDataHelper countForEntity:@"Lavori" andContext:managedObjectContext ] !=10)
    {
        
        [alert dismissWithClickedButtonIndex:0 animated:true];
        
        alert.title =@"Attendi";
        alert.message = @"Caricamento Dati per la ricerca, potrebbe durare alcuni secondi .\n Grazie";
        [alert show];
        
        
        int n = 0;
        while (n<50)
        {
            [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
            [NSThread sleepForTimeInterval:0.001];
            n++;
        }
        
            if ([CoreDataHelper countForEntity:@"Lavori"  andContext:managedObjectContext] == 0)
            {
                
                }
        }
        [alert dismissWithClickedButtonIndex:0 animated:true];
        
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
                                               [self.MessaggiImages objectAtIndex:[myIndexPath row]],
                                               nil];
    }
    else {
        [self verificadati];
    }
    
}

-(void) gestiscidaticore :(NSString *) annoStr annoint:(int) annoint cancella:(int) cancella
{
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:nil  andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    
    int app = MessaggiListData.count;
    if ([CoreDataHelper countForEntity:@"Lavori"
                            andContext:managedObjectContext] != app) {
        [CoreDataHelper deleteAllObjectsForEntity:@"Lavori"
                                       andContext:managedObjectContext];
        app=0;
    }
    
    /*
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"(username == %@ )", annoStr];
    if ([CoreDataHelper countForEntity:@"Users"  withPredicate:pred1 andContext:managedObjectContext] == 0) {
        [CoreDataHelper deleteAllObjectsForEntity:@"Messaggi" withPredicate:pred andContext:managedObjectContext];
        app=0;
    }
    */
    
    if (cancella == 1) {
        [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];
        app=0;
    }
    NSNumber *anno  =[NSNumber numberWithInt:annoint];
    
    if ( app == 0)
    {
        int app0 = self.MessaggiImages.count;
        int ciclo0 = 0;
        
        while (ciclo0 <= (app0 -1)) {
            self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
            
            // For both new and existing pictures, fill in the details from the form
            NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
            [self.currentMessaggi setProgressivo:prganno];
            [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
            [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
          /*  UIImage *MessaggiPhoto = [UIImage imageNamed: [self.MessaggiImages objectAtIndex:ciclo0]];
            
            // Resize and save a smaller version for the table
            float resize = 74.0;
            float actualWidth = MessaggiPhoto.size.height;
            float actualHeight = MessaggiPhoto.size.height;
            float divBy, newWidth, newHeight;
            if (actualWidth > actualHeight) {
                divBy = (actualWidth / resize);
                newWidth = resize;
                newHeight = (actualHeight / divBy);
            } else {
                divBy = (actualHeight / resize);
                newWidth = (actualWidth / divBy);
                newHeight = resize;
            }
            CGRect rect = CGRectMake(0.0, 0.0, newWidth, newHeight);
            UIGraphicsBeginImageContext(rect.size);
            [MessaggiPhoto drawInRect:rect];
            UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            // Save the small image version
            NSData *smallImageData = UIImageJPEGRepresentation(smallImage, 1.0);
            [self.currentMessaggi setSmallpicture:smallImageData];*/
            ciclo0 = ciclo0 +1;
            //  Commit item to core data
            NSError *error;
            if (![self.managedObjectContext save:&error])
                NSLog(@"Failed to add new picture with error: %@", [error domain]);
        }
        
        
    
    
    }
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:nil andSortKey:@"progressivo" andSortAscending:NO andContext:managedObjectContext];
    app = MessaggiListData.count;
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
        
        
        self.MessaggiMakes =  [self.MessaggiMakes  arrayByAddingObject:[ currentCell title]];
        self.MessaggiModels =  [self.MessaggiModels arrayByAddingObject:[ currentCell description_]];
      //  self.MessaggiImages =  [self.MessaggiImages arrayByAddingObject:[ currentCell smallpicture]];
        self.MessaggiImages = nil;
        ciclo = ciclo +1;
    }


    [self gestiscidaticore:[NSString stringWithFormat:@"%d",2014] annoint:2014 cancella:0];

}
 



-(void) VerficaAggiornamenti
{
    BOOL controllo;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL verifica;
   // verifica  =![defaults boolForKey:@"ril_agg"] ;
    verifica = TRUE;
    int tempNum;
    
   
    alert.title =@"Attendere";
    alert.message = @"Verifica Disponibilità Nuove Offerte";
    [alert show];
    int n = 0;
    while (n<50)
    {
        [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
        [NSThread sleepForTimeInterval:0.001];
        n++;
    }
    
    if (verifica) {
        
    
    controllo = [[CheckConnessione alloc] eseguiControllo];
    if (controllo) {
        
        
        
       
        //verifico Aggiornamento Messaggi
        NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=rss";
        NSURL *url = [NSURL URLWithString:path];
        NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
        tipoRichiesta = @"up";
        [parser setDelegate:self];
        [parser parse];
        int app0 = 1;
        int ciclo0 = 0;
        int badges = 0;
        int notifica = 0;
        NSPredicate *pred;
        int tempNum;
        
                if (notifica == 0) {
                    //Non sono mai stati fatti aggiornamenti quindi setto la notifica
                    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
                    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
                    //  [dateComps setDay:0];
                    //[dateComps setMonth:0];
                    //[dateComps setYear:0];
                    //[dateComps setHour:0];
                    [dateComps setMinute:10];
                    NSDate *now = [NSDate date]; // Grab current time
                    //    NSDate *newDate = [now addTimeInterval:120]; // Add XXX seconds to *now
                    NSDate *date = [calendar dateByAddingComponents:dateComps toDate:now options:0];
                    
                    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
                    
                    [localNotification setFireDate:date];
                    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
                    
                    [localNotification setAlertBody:@"Sono Disponibili Aggiornamenti"];
                    [localNotification setAlertAction:@"Apri app"];
                    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
                    [localNotification setApplicationIconBadgeNumber:app0];
                    
                    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"Lavori", nil] forKeys:[NSArray arrayWithObjects:@"Azione1", nil]];
                    
                    [localNotification setUserInfo:dictionary];
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                    notifica +=1;
                    badges = badges + 1;
                    

                    
                    
        
            }
    
        if (badges != 0) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = badges;
        }
        else
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            
        }
 
    }
    else
    {
        
    }
  }
    
}
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Inizio Tag%@",elementName);
    storingCharacters = YES;
}

-(void) parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
    if (storingCharacters) [contenutoTag appendString:string];
    
}
-(void) parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *immutableString = [NSString stringWithString:contenutoTag];
    
    
    if ([elementName isEqualToString:@"title"]) {
        [_MessaggiMakes1 addObject:immutableString];
    }
    
    if ([elementName isEqualToString:@"description"]) {
        NSRange r;
        while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
        
        [_MessaggiModels1 addObject:immutableString];
    }
    
    if ([elementName isEqualToString:@"link"]) {
        [_MessaggiImages1 addObject:immutableString];
    }
    
    
    
            /*   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:[NSString stringWithFormat:@"%@: %@",elementName,contenutoTag] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alertView show];
             */
            //  [nomeTitolo setText:[NSString stringWithFormat:@"%@: %@",elementName,contenutoTag]];
            
    
    
    contenutoTag = [[NSMutableString alloc] init];
    
    storingCharacters = NO;
}
- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL *)url ofType:(NSString *)fileType modelConfiguration:(NSString *)configuration storeOptions:(NSDictionary *)storeOptions error:(NSError **)error
{
	NSLog(@"configuring store.");
	NSMutableDictionary *options = nil;
	if (storeOptions != nil)
	{
		options = [storeOptions mutableCopy];
	}
	else
	{
		options = [[NSMutableDictionary alloc] init];
	}
	
	[options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
	
	BOOL result = [self configurePersistentStoreCoordinatorForURL:url ofType:fileType modelConfiguration:configuration storeOptions:options error:error];
	//[options release], options = nil;
	return result;
}

@end
