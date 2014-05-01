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
#import "Aggiorna.h"
#import "CheckConnessione.h"


@interface MessaggiTableViewController ()

@end

@implementation MessaggiTableViewController
@synthesize MessaggiMakes = _MessaggiMakes; 
@synthesize MessaggiModels = _MessaggiModels;
@synthesize MessaggiImages = _MessaggiImages;
@synthesize MessaggiDataPubblicazione = _MessaggiDataPubblicazione;
@synthesize MessaggiLink = _MessaggiLink;
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
NSString *caricaDatiAGG = @"0";


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
    
    
  /*  alert.title =@"Attendere";
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
   */
   [self gestiscidaticore];
    
  	
    //[alert dismissWithClickedButtonIndex:0 animated:true];
    [self.tableView reloadData];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];

}
-(void)Aggiorna
{
    BOOL controllo;
    controllo = [[CheckConnessione alloc] eseguiControllo];
    if (controllo) {
        
        
        
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"Attendere"
                                           message:@"Download e Installazione ultime Offerte"
                                          delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [alert show];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [indicator startAnimating];
        [alert addSubview:indicator];
        
        indicator.center = CGPointMake(140, 90);
        
        int n = 0;
        while (n<50)
        {
            [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
            [NSThread sleepForTimeInterval:0.001];
            n++;
        }
        
        
        
        NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=rss";
        NSURL *url = [NSURL URLWithString:path];
        NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
        tipoRichiesta = @"rss";
        [parser setDelegate:self];
        [parser parse];
        int app0 = self.AnniMutableArray.count;
        int ciclo0 = 0;
        
        int tempNum;
        
        
        [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];
        
        
        
        [self gestiscidaticoreAggiorna];
        
        
        
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        
        /*
         UILocalNotification *localNotification = [[UILocalNotification alloc]init];
         [localNotification setApplicationIconBadgeNumber:0];
         */
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        
        [alert dismissWithClickedButtonIndex:0 animated:true];
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Non sono presenti connessioni internet attive al momento, riprovare più tardi." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    
}
-(void) gestiscidaticoreAggiorna
{
    
    
    int app0 = self.MessaggiMakes.count;
    int ciclo0 = 0;
    
    while (ciclo0 <= (app0 -1)) {
        self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
        
        // For both new and existing pictures, fill in the details from the form
        NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
        [self.currentMessaggi setProgressivo:prganno];
        [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
        [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
        [self.currentMessaggi setLink:[self.MessaggiLink objectAtIndex:ciclo0]];
        [self.currentMessaggi setDatapubblicazione:[self.MessaggiDataPubblicazione objectAtIndex:ciclo0]];
          ciclo0 = ciclo0 +1;
        //  Commit item to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add new picture with error: %@", [error domain]);
    }
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Aggiorna Offerte"];
    
    
    
    [refresh addTarget:self action:@selector(Aggiorna)
     
      forControlEvents:UIControlEventValueChanged];
    
    
    
    self.refreshControl = refresh;
    
    
    
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
   
    
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:nil  andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    
    int app = MessaggiListData.count;
    
    
    
    
    if ( app == 0)
    {
        BOOL controllo;
        controllo = [[CheckConnessione alloc] eseguiControllo];
        if (controllo) {
            
            
            
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Attendere"
                                               message:@"Download e Installazione ultime Offerte"
                                              delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [alert show];
            
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            [indicator startAnimating];
            [alert addSubview:indicator];
            
            indicator.center = CGPointMake(140, 90);
            
            int n = 0;
            while (n<50)
            {
                [[NSRunLoop currentRunLoop] limitDateForMode:NSDefaultRunLoopMode];
                [NSThread sleepForTimeInterval:0.001];
                n++;
            }
            
            
            
            NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=rss";
            NSURL *url = [NSURL URLWithString:path];
            NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
            tipoRichiesta = @"tam";
            [parser setDelegate:self];
            [parser parse];
            
            int tempNum;
            
            
            [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];
            
            
            
            
            
            int app0 = self.MessaggiMakes1.count;
            int ciclo0 = 0;
            
            while (ciclo0 <= (app0 -1)) {
                self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
                
                // For both new and existing pictures, fill in the details from the form
                NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
                [self.currentMessaggi setProgressivo:prganno];
                [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
                [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
                [self.currentMessaggi setDatapubblicazione:[self.MessaggiDataPubblicazione objectAtIndex:ciclo0]];
                [self.currentMessaggi setLink:[self.MessaggiLink objectAtIndex:ciclo0]];
                ciclo0 = ciclo0 +1;
                //  Commit item to core data
                NSError *error;
                if (![self.managedObjectContext save:&error])
                    NSLog(@"Failed to add new picture with error: %@", [error domain]);
            }

            
            
            
            [[UIApplication sharedApplication]cancelAllLocalNotifications];
            
            /*
             UILocalNotification *localNotification = [[UILocalNotification alloc]init];
             [localNotification setApplicationIconBadgeNumber:0];
             */
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            
            
            [alert dismissWithClickedButtonIndex:0 animated:true];
            
            // Do any additional setup after loading the view, typically from a nib.
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Non sono presenti connessioni internet attive al momento, riprovare più tardi." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }

        
        
        
    }
    
    
}

- (void)stopRefresh

{
    
    [self.refreshControl endRefreshing];
    
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
//    cell.modelLabel.text = [currentCell description_];
    cell.modelLabel.text = [currentCell title];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
   NSString *DataPubblicazione = [dateFormatter stringFromDate:[currentCell datapubblicazione]];
    
    cell.datapubb.text = DataPubblicazione;
    cell.luogo.text = @"";
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
                                               [self.MessaggiDataPubblicazione objectAtIndex:[myIndexPath row]],
                                               [self.MessaggiLink objectAtIndex:[myIndexPath row]],
                                               nil];
    }
    else {
        [self verificadati];
    }
    
}

-(void) gestiscidaticore
{
  /*  MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:nil  andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    
    int app = MessaggiListData.count;
    
    
   
    
    if ( app == 0)
    {
              
              [self VerficaAggiornamenti];

     
    }
   */
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"Lavori" withPredicate:nil andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    int app ;
    app = MessaggiListData.count;
    int ciclo = 0;
    
    self.MessaggiMakes = [NSArray alloc];
    self.MessaggiModels = [NSArray alloc];
    self.MessaggiImages = [NSArray alloc];
    self.MessaggiDataPubblicazione = [NSArray alloc];
    self.MessaggiLink = [NSArray alloc];
    
    
    self.MessaggiMakes = [self.MessaggiMakes init];
    self.MessaggiModels = [self.MessaggiModels init];
    self.MessaggiImages = [self.MessaggiImages init];
    self.MessaggiDataPubblicazione = [self.MessaggiDataPubblicazione init];
    self.MessaggiLink = [self.MessaggiLink init ];
    
    Lavori *currentCell ;
    
    //  Fill in the cell contents
    
    while (ciclo < (app -1)) {
        currentCell = [MessaggiListData objectAtIndex:ciclo];
        
        
        self.MessaggiMakes =  [self.MessaggiMakes  arrayByAddingObject:[ currentCell title]];
        self.MessaggiModels =  [self.MessaggiModels  arrayByAddingObject:[ currentCell description_]];
        self.MessaggiImages = [self.MessaggiImages arrayByAddingObject: [currentCell progressivo]];
        self.MessaggiDataPubblicazione = [self.MessaggiDataPubblicazione arrayByAddingObject:[currentCell datapubblicazione]];
        self.MessaggiLink = [self.MessaggiLink arrayByAddingObject:[currentCell link]];
        
        //  self.MessaggiModels =  [self.MessaggiModels arrayByAddingObject:[ currentCell description_]];
     //   self.MessaggiImages =  [self.MessaggiImages arrayByAddingObject:[ currentCell link]];
        ciclo = ciclo +1;
    }

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
        NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=atom";
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
 /*
  NSString *immutableString = [NSString stringWithString:contenutoTag];
    
    if ([elementName isEqualToString:@"title"]) {
        [_MessaggiMakes1 addObject:immutableString];
    }
    
    if ([elementName isEqualToString:@"content"]) {
        NSRange r;
        while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
        
        [_MessaggiModels1 addObject:immutableString];
    }
    
    if ([elementName isEqualToString:@"link"]) {
        [_MessaggiImages1 addObject:immutableString];
    }
  */
    NSString *immutableString = [NSString stringWithString:contenutoTag];
    
    NSRange r;
    
    
    if ([tipoRichiesta isEqualToString:@"atom"])
    {
        
        if([elementName isEqualToString:@"entry"])
        {
            caricaDatiAGG = @"1";
        }
        
        if([caricaDatiAGG isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes1 addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"content"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels1 addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages1 addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"published"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                NSString *value = [immutableString substringWithRange:NSMakeRange(0, 10)];
                dateFromString = [dateFormatter dateFromString:value];
                [_MessaggiDataPubblicazione1 addObject:dateFromString];
                
            }
            
        }
    }
    else
    {
        if([elementName isEqualToString:@"item"])
        {
            caricaDatiAGG = @"1";
        }
        
        if([caricaDatiAGG isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes1 addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"description"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels1 addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages1 addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"pubDate"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd MMM yyyy"];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                NSString *value = [immutableString substringWithRange:NSMakeRange(5, 11)];
                dateFromString = [dateFormatter dateFromString:value];
                [_MessaggiDataPubblicazione1 addObject:dateFromString];
                
            }
            
        }
        
    }
    
    
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
