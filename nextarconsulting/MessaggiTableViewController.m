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
//#import "Lavori.h"
#import "LavoriCompleta.h"
#import "CampiVisibili.h"
#import "CheckConnessione.h"
#import "AggiornaMessaggi.h"
#import "Parametri.h"

@interface MessaggiTableViewController ()

@end

@implementation MessaggiTableViewController
/*@synthesize MessaggiMakes = _MessaggiMakes;
@synthesize MessaggiModels = _MessaggiModels;
@synthesize MessaggiImages = _MessaggiImages;
@synthesize MessaggiDataPubblicazione = _MessaggiDataPubblicazione;
@synthesize MessaggiLink = _MessaggiLink;
 */
@synthesize Messaggicategory = _Messaggicategory;
@synthesize Messaggiclosing_date = _Messaggiclosing_date;
@synthesize Messaggicompany = _Messaggicompany;
@synthesize Messaggidepartment = _Messaggidepartment;
@synthesize Messaggiduration = _Messaggiduration;
@synthesize Messaggieducation = _Messaggieducation;
@synthesize Messaggijob_code = _Messaggijob_code;
@synthesize Messaggijob_description = _Messaggijob_description;
@synthesize Messaggijob_title = _Messaggijob_title;
@synthesize Messaggilink = _Messaggilink;
@synthesize Messaggiloc_address =_Messaggiloc_address;
@synthesize Messaggiloc_description = _Messaggiloc_description;
@synthesize Messaggilocation = _Messaggilocation;
@synthesize Messaggipay_range = _Messaggipay_range;
@synthesize Messaggipay_rate = _Messaggipay_rate;
@synthesize Messaggiposting_date = _Messaggiposting_date;
@synthesize Messaggipreferred_skills = _Messaggipreferred_skills;
@synthesize Messaggishift = _Messaggishift;
@synthesize Messaggisummary = _Messaggisummary;
@synthesize Messaggititle = _Messaggititle;
@synthesize Messaggitravel = _Messaggitravel;

//@synthesize Segment;
@synthesize managedObjectContext;
@synthesize currentLavoriCompleta;
@synthesize currentCampiVisibili;
//@synthesize currentMessaggi;
@synthesize MessaggiListData;
//@synthesize indicatore;
@synthesize alert;
@synthesize AnniMutableArray;
@synthesize AnniTotaleMutableArray;
//@synthesize NumUltimaPubblicazione;
@synthesize searchbar;

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
    return [self.Messaggititle count];
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
- (void)stopRefresh

{
    
    [self.refreshControl endRefreshing];
    
}

-(void)Aggiorna
{
    BOOL controllo;
    controllo = [[CheckConnessione alloc] eseguiControllo];
    if (controllo) {
        
        
        
    /*    UIAlertView *alert;
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
      */
        Parametri *parametri = [Parametri alloc];
        
        NSString *path = parametri.Web_Service;
        NSURL *url = [NSURL URLWithString:path];
        NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
        tipoRichiesta = @"rss";
        [parser setDelegate:self];
        [parser parse];
        int app0 = self.AnniMutableArray.count;
        int ciclo0 = 0;
        
        int tempNum;
 
        AggiornaMessaggi *agg = [AggiornaMessaggi alloc];
        
        [agg AggiornaDati];
        
        
   //     [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];
        
        
        
     //   [self gestiscidaticoreAggiorna];
        
        
        
       // [[UIApplication sharedApplication]cancelAllLocalNotifications];
        
        /*
         UILocalNotification *localNotification = [[UILocalNotification alloc]init];
         [localNotification setApplicationIconBadgeNumber:0];
         */
        //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        
   //     [alert dismissWithClickedButtonIndex:0 animated:true];
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Non sono presenti connessioni internet attive al momento, riprovare più tardi." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    [self stopRefresh];
    [self gestiscidaticore];
    
    
}
-(void) gestiscidaticoreAggiorna
{
    //NON USATA E NON IMPLEMENTATA
    
    int app0 = self.Messaggititle.count;
    int ciclo0 = 0;
    
    while (ciclo0 <= (app0 -1)) {
        //Preparo la nuova riga in LavoriCompleta
        self.currentLavoriCompleta = (LavoriCompleta *) [NSEntityDescription insertNewObjectForEntityForName:@"LavoriCompleta" inManagedObjectContext:self.managedObjectContext];
        
        //preparo la nuova riga in campi visibili
        
        self.currentCampiVisibili = (CampiVisibili *) [NSEntityDescription insertNewObjectForEntityForName:@"CampiVisibili" inManagedObjectContext:self.managedObjectContext];
      
         //Inserisco in LavoriCompleta
        
        
        /*self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
        
        // For both new and existing pictures, fill in the details from the form
        NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
        [self.currentMessaggi setProgressivo:prganno];
        [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
        [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
        [self.currentMessaggi setLink:[self.MessaggiLink objectAtIndex:ciclo0]];
        [self.currentMessaggi setDatapubblicazione:[self.MessaggiDataPubblicazione objectAtIndex:ciclo0]];
         */
         
          ciclo0 = ciclo0 +1;
        //  Commit item to core data
        NSError *error;
        if (![self.managedObjectContext save:&error])
            NSLog(@"Failed to add new picture with error: %@", [error domain]);
    }
    
    [self gestiscidaticore];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Aggiorna Offerte"];
    
    
    
    [refresh addTarget:self action:@selector(Aggiorna)
     
      forControlEvents:UIControlEventValueChanged];
    
    
    
    self.refreshControl = refresh;
    [self.tableView reloadData];
    
    
    
    
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
   
    
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"LavoriCompleta" withPredicate:nil  andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    
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
            Parametri *parametri = [Parametri alloc];
            
            
            
            
            //NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=rss";
            NSString *path = parametri.Web_Service;
            NSURL *url = [NSURL URLWithString:path];
            NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
            tipoRichiesta = @"tam";
            [parser setDelegate:self];
            [parser parse];
            
            int tempNum;
            
            
            [CoreDataHelper deleteAllObjectsForEntity:@"LavoriCompleta" withPredicate:nil andContext:managedObjectContext];
            
            
            
            
            
            int app0 = self.Messaggititle1.count;
            int ciclo0 = 0;
            
            while (ciclo0 <= (app0 -1)) {
                //Inserisco i nuovi valori in tabella
                
                self.currentLavoriCompleta = (LavoriCompleta *)[NSEntityDescription insertNewObjectForEntityForName:@"LavoriCompleta" inManagedObjectContext:self.managedObjectContext];
                
                NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
                [self.currentLavoriCompleta setProgressivo:prganno];
                [self.currentLavoriCompleta setCategory:[self.Messaggicategory objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setClosing_date:[self.Messaggiclosing_date objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setCompany:[self.Messaggicompany objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setDepartment:[self.Messaggidepartment objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setDuration:[self.Messaggiduration objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setEducation:[self.Messaggieducation objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setJob_code:[self.Messaggijob_code objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setJob_description:[self.Messaggijob_description objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setJob_title:[self.Messaggijob_title objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setLink:[self.Messaggilink objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setLoc_address :[self.Messaggiloc_address objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setLoc_description:[self.Messaggiloc_description objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setLocation:[self.Messaggilocation objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setPay_range:[self.Messaggipay_range objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setPay_rate:[self.Messaggipay_rate objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setPosting_date:[self.Messaggiposting_date objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setPreferred_skills:[self.Messaggipreferred_skills objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setShift:[self.Messaggishift objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setSummary:[self.Messaggisummary objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setTitle:[self.Messaggititle objectAtIndex:ciclo0]];
                [self.currentLavoriCompleta setTravel:[self.Messaggitravel objectAtIndex:ciclo0]];
                
             /*   // For both new and existing pictures, fill in the details from the form
                NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
                [self.currentMessaggi setProgressivo:prganno];
                [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
                [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
                [self.currentMessaggi setDatapubblicazione:[self.MessaggiDataPubblicazione objectAtIndex:ciclo0]];
                [self.currentMessaggi setLink:[self.MessaggiLink objectAtIndex:ciclo0]];
              */
                ciclo0 = ciclo0 +1;
                //  Commit item to core data
                NSError *error;
                if (![self.managedObjectContext save:&error])
                    NSLog(@"Impossibile salvare il record: %@", [error domain]);
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
                reuseIdentifier:CellIdentifier
                ];
    }
    
    cell.autoresizesSubviews = YES;
    
    LavoriCompleta *currentCell = [MessaggiListData objectAtIndex:indexPath.row];
    
    //Riempio la cella in griglia
    
    cell.link.text = [currentCell link];
    cell.title.text = [currentCell title];
    cell.company.text = [currentCell company];
    cell.job_title.text = [currentCell job_title];
    cell.location.text = [currentCell location];
    cell.loc_description.text = [currentCell loc_description];
    cell.loc_address.text = [currentCell loc_address];
    cell.summary.text = [currentCell summary];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *DataPubblicazione = [dateFormatter stringFromDate:[currentCell posting_date]];
    NSString *DataChiusura = [dateFormatter stringFromDate:[currentCell posting_date]];

    cell.posting_date.text = DataPubblicazione;
    cell.closing_date.text = DataChiusura;
    
    cell.job_code.text = [currentCell job_code];
    cell.category.text = [currentCell category];
    cell.department.text = [currentCell department];
    cell.shift.text = [currentCell shift];
    cell.education.text = [currentCell education];
    cell.pay_rate.text = [currentCell pay_rate];
    cell.pay_range.text = [currentCell pay_range];
    cell.duration.text = [currentCell duration];
    cell.travel.text = [currentCell travel];
    cell.job_description.text = [currentCell job_description];
    cell.preferred_skills.text = [currentCell preferred_skills];

    
   /*
    //  Fill in the cell contents
    
    cell.makeLabel.text = [currentCell title];
    cell.makeLabel.autoresizesSubviews = YES;
//    cell.modelLabel.text = [currentCell description_];
    cell.modelLabel.text = [currentCell title];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
   NSString *DataPubblicazione = [dateFormatter stringFromDate:[currentCell datapubblicazione]];
    
    cell.datapubb.text = DataPubblicazione;
    cell.luogo.text = @"";
    cell.MessaggiImage.contentMode = UIViewContentModeScaleAspectFit;
   // cell.MessaggiImage.image = [UIImage imageWithData:[currentCell smallpicture]];
    */
    
    
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


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
    
    if ([CoreDataHelper countForEntity:@"LavoriCompletati" andContext:managedObjectContext ] !=1)
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
        
            if ([CoreDataHelper countForEntity:@"LavoriCompletati"  andContext:managedObjectContext] == 0)
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
        
        //Passo tutti i record della pagina del dettaglio
        
        detailViewController.MessaggiDetailModel = [[NSArray alloc]
                                               initWithObjects: [self.Messaggititle
                                                                 objectAtIndex:[myIndexPath row]],
                                               [self.Messaggijob_description objectAtIndex:[myIndexPath row]],
                                               [self.Messaggijob_title objectAtIndex:[myIndexPath row]],
                                               [self.Messaggiposting_date objectAtIndex:[myIndexPath row]],
                                               [self.Messaggipay_range objectAtIndex:[myIndexPath row]],
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
    MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"LavoriCompleta" withPredicate:nil andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
    int app ;
    app = MessaggiListData.count;
    int ciclo = 0;
    
    /*
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
    */
    
    //Inizializzo gli array
    
    self.Messaggicategory = [NSArray alloc];
    self.Messaggiclosing_date = [NSArray alloc];
    self.Messaggicompany = [NSArray alloc];
    self.Messaggidepartment = [NSArray alloc];
    self.Messaggiduration = [NSArray alloc];
    self.Messaggieducation = [NSArray alloc];
    self.Messaggijob_code = [NSArray alloc];
    self.Messaggijob_description = [NSArray alloc];
    self.Messaggijob_title = [NSArray alloc];
    self.Messaggilink = [NSArray alloc];
    self.Messaggiloc_address = [NSArray alloc];
    self.Messaggiloc_description = [NSArray alloc];
    self.Messaggilocation = [NSArray alloc];
    self.Messaggipay_range = [NSArray alloc];
    self.Messaggipay_rate = [NSArray alloc];
    self.Messaggiposting_date = [NSArray alloc];
    self.Messaggipreferred_skills = [NSArray alloc];
    self.Messaggishift = [NSArray alloc];
    self.Messaggisummary = [NSArray alloc];
    self.Messaggititle = [NSArray alloc];
    self.Messaggitravel = [NSArray alloc];
    
    
    self.Messaggicategory = [self.Messaggicategory init];
    self.Messaggiclosing_date = [self.Messaggiclosing_date init];
    self.Messaggicompany = [self.Messaggicompany init];
    self.Messaggidepartment = [self.Messaggidepartment init];
    self.Messaggiduration = [self.Messaggiduration init];
    self.Messaggieducation = [self.Messaggieducation init];
    self.Messaggijob_code = [self.Messaggijob_code init];
    self.Messaggijob_description = [self.Messaggijob_description init];
    self.Messaggijob_title = [self.Messaggijob_title init];
    self.Messaggilink = [self.Messaggilink init];
    self.Messaggiloc_address = [self.Messaggiloc_address init];
    self.Messaggiloc_description = [self.Messaggiloc_description init];
    self.Messaggilocation = [self.Messaggilocation init];
    self.Messaggipay_range = [self.Messaggipay_range init];
    self.Messaggipay_rate = [self.Messaggipay_rate init];
    self.Messaggiposting_date = [self.Messaggiposting_date init];
    self.Messaggipreferred_skills = [self.Messaggipreferred_skills init];
    self.Messaggishift = [self.Messaggishift init];
    self.Messaggisummary = [self.Messaggisummary init];
    self.Messaggititle = [self.Messaggititle init];
    self.Messaggitravel = [self.Messaggitravel init];

    
    LavoriCompleta *currentCell ;
    
    //  Fill in the cell contents
    
    while (ciclo < (app )) {
        currentCell = [MessaggiListData objectAtIndex:ciclo];
        
        /*
        self.MessaggiMakes =  [self.MessaggiMakes  arrayByAddingObject:[ currentCell title]];
        self.MessaggiModels =  [self.MessaggiModels  arrayByAddingObject:[ currentCell description_]];
        self.MessaggiImages = [self.MessaggiImages arrayByAddingObject: [currentCell progressivo]];
        self.MessaggiDataPubblicazione = [self.MessaggiDataPubblicazione arrayByAddingObject:[currentCell datapubblicazione]];
        self.MessaggiLink = [self.MessaggiLink arrayByAddingObject:[currentCell link]];
        
        //  self.MessaggiModels =  [self.MessaggiModels arrayByAddingObject:[ currentCell description_]];
     //   self.MessaggiImages =  [self.MessaggiImages arrayByAddingObject:[ currentCell link]];
         */
        
        
        //Riempio gli array con il contenuto della cella
        self.Messaggicategory = [self.Messaggicategory arrayByAddingObject:[ currentCell category]];
        self.Messaggiclosing_date = [self.Messaggiclosing_date arrayByAddingObject:[ currentCell closing_date]];
        self.Messaggicompany = [self.Messaggicompany arrayByAddingObject:[ currentCell company]];
        self.Messaggidepartment = [self.Messaggidepartment arrayByAddingObject:[ currentCell department]];
        self.Messaggiduration = [self.Messaggiduration arrayByAddingObject:[ currentCell duration]];
        self.Messaggieducation = [self.Messaggieducation arrayByAddingObject:[ currentCell education]];
        self.Messaggijob_code = [self.Messaggijob_code arrayByAddingObject:[ currentCell job_code]];
        self.Messaggijob_description = [self.Messaggijob_description arrayByAddingObject:[ currentCell job_description]];
        self.Messaggijob_title = [self.Messaggijob_title arrayByAddingObject:[ currentCell job_title]];
        self.Messaggilink = [self.Messaggilink arrayByAddingObject:[ currentCell link]];
        self.Messaggiloc_address = [self.Messaggiloc_address arrayByAddingObject:[ currentCell loc_address]];
        self.Messaggiloc_description = [self.Messaggiloc_description arrayByAddingObject:[ currentCell loc_description]];
        self.Messaggilocation = [self.Messaggilocation arrayByAddingObject:[ currentCell location]];
        self.Messaggipay_range = [self.Messaggipay_range arrayByAddingObject:[ currentCell pay_range]];
        self.Messaggipay_rate = [self.Messaggipay_rate arrayByAddingObject:[ currentCell pay_rate]];
        self.Messaggiposting_date = [self.Messaggiposting_date arrayByAddingObject:[ currentCell posting_date]];
        self.Messaggipreferred_skills = [self.Messaggipreferred_skills arrayByAddingObject:[ currentCell preferred_skills]];
        self.Messaggishift = [self.Messaggishift arrayByAddingObject:[ currentCell shift]];
        self.Messaggisummary = [self.Messaggisummary arrayByAddingObject:[ currentCell summary]];
        self.Messaggititle = [self.Messaggititle  arrayByAddingObject:[ currentCell title]];
        self.Messaggitravel = [self.Messaggitravel arrayByAddingObject:[ currentCell travel]];

        
        
        ciclo = ciclo +1;
    }

}
 



/*
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
 */
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
    
    
  /*  if ([tipoRichiesta isEqualToString:@"atom"])
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
    */
    
    //Faccio il parse del contenuto
    
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
            
            
            [_Messaggititle1 addObject:noWhiteSpace];
        }
        

        
        if ([elementName isEqualToString:@"link"]) {
            [_Messaggilink1 addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"company"]) {
            while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
           [_Messaggicompany1 addObject:noWhiteSpace];
        }

        if ([elementName isEqualToString:@"job_title"]) {
            [_Messaggijob_title1 addObject:immutableString];
        }
        
        
        if ([elementName isEqualToString:@"location"]) {
            [_Messaggilocation1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"loc_description"]) {
            [_Messaggiloc_description1 addObject:immutableString];
        }
        if ([elementName isEqualToString:@"loc_address"]) {
            [_Messaggiloc_address1 addObject:immutableString];
        }
        if ([elementName isEqualToString:@"summary"]) {
            [_Messaggisummary1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"posting_date"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            NSString *value = [immutableString substringWithRange:NSMakeRange(5, 11)];
            dateFromString = [dateFormatter dateFromString:value];
           [_Messaggiposting_date1 addObject:dateFromString];
        }
        if ([elementName isEqualToString:@"closing_date"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
            NSDate *dateFromString = [[NSDate alloc] init];
            // voila!
            NSString *value = [immutableString substringWithRange:NSMakeRange(5, 11)];
            dateFromString = [dateFormatter dateFromString:value];
          [_Messaggiclosing_date1 addObject:dateFromString];
        }

        if ([elementName isEqualToString:@"job_code"]) {
            [_Messaggijob_code1 addObject:immutableString];
        }
        if ([elementName isEqualToString:@"category"]) {
            [_Messaggicategory1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"department"]) {
            [_Messaggidepartment1 addObject:immutableString];
        }
        if ([elementName isEqualToString:@"shift"]) {
            [_Messaggishift1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"education"]) {
            [_Messaggieducation1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"pay_rate"]) {
            [_Messaggipay_rate1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"pay_range"]) {
            [_Messaggipay_range1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"duration"]) {
            [_Messaggiduration1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"travel"]) {
            [_Messaggitravel1 addObject:immutableString];
        }
        if ([elementName isEqualToString:@"job_description"]) {
            while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            [_Messaggijob_description1 addObject:immutableString];
        }

        if ([elementName isEqualToString:@"preferred_skills"]) {
            [_Messaggipreferred_skills1 addObject:immutableString];
        }

        
/*        if ([elementName isEqualToString:@"description"]) {
            while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            
            [_MessaggiModels1 addObject:immutableString];
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
 */
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
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    searchbar.showsCancelButton = YES;
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

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    self.searchbar.text = @"";

    self.Messaggicategory = [NSArray alloc];
    self.Messaggiclosing_date = [NSArray alloc];
    self.Messaggicompany = [NSArray alloc];
    self.Messaggidepartment = [NSArray alloc];
    self.Messaggiduration = [NSArray alloc];
    self.Messaggieducation = [NSArray alloc];
    self.Messaggijob_code = [NSArray alloc];
    self.Messaggijob_description = [NSArray alloc];
    self.Messaggijob_title = [NSArray alloc];
    self.Messaggilink = [NSArray alloc];
    self.Messaggiloc_address = [NSArray alloc];
    self.Messaggiloc_description = [NSArray alloc];
    self.Messaggilocation = [NSArray alloc];
    self.Messaggipay_range = [NSArray alloc];
    self.Messaggipay_rate = [NSArray alloc];
    self.Messaggiposting_date = [NSArray alloc];
    self.Messaggipreferred_skills = [NSArray alloc];
    self.Messaggishift = [NSArray alloc];
    self.Messaggisummary = [NSArray alloc];
    self.Messaggititle = [NSArray alloc];
    self.Messaggitravel = [NSArray alloc];
    
    
    self.Messaggicategory = [self.Messaggicategory init];
    self.Messaggiclosing_date = [self.Messaggiclosing_date init];
    self.Messaggicompany = [self.Messaggicompany init];
    self.Messaggidepartment = [self.Messaggidepartment init];
    self.Messaggiduration = [self.Messaggiduration init];
    self.Messaggieducation = [self.Messaggieducation init];
    self.Messaggijob_code = [self.Messaggijob_code init];
    self.Messaggijob_description = [self.Messaggijob_description init];
    self.Messaggijob_title = [self.Messaggijob_title init];
    self.Messaggilink = [self.Messaggilink init];
    self.Messaggiloc_address = [self.Messaggiloc_address init];
    self.Messaggiloc_description = [self.Messaggiloc_description init];
    self.Messaggilocation = [self.Messaggilocation init];
    self.Messaggipay_range = [self.Messaggipay_range init];
    self.Messaggipay_rate = [self.Messaggipay_rate init];
    self.Messaggiposting_date = [self.Messaggiposting_date init];
    self.Messaggipreferred_skills = [self.Messaggipreferred_skills init];
    self.Messaggishift = [self.Messaggishift init];
    self.Messaggisummary = [self.Messaggisummary init];
    self.Messaggititle = [self.Messaggititle init];
    self.Messaggitravel = [self.Messaggitravel init];
    
    if ([CoreDataHelper countForEntity:@"LavoriCompleta" withPredicate:nil andContext:managedObjectContext] != 0)
    {
        MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"LavoriCompleta" withPredicate:nil andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
        int app = MessaggiListData.count;
        int ciclo = 0;
        
        
        
        LavoriCompleta *currentCell ;
        
        //  Fill in the cell contents
        
        while (ciclo < (app)) {
            currentCell = [MessaggiListData objectAtIndex:ciclo];
            
            
            //Riempio gli array con il contenuto della cella
            self.Messaggicategory = [self.Messaggicategory arrayByAddingObject:[ currentCell category]];
            self.Messaggiclosing_date = [self.Messaggiclosing_date arrayByAddingObject:[ currentCell closing_date]];
            self.Messaggicompany = [self.Messaggicompany arrayByAddingObject:[ currentCell company]];
            self.Messaggidepartment = [self.Messaggidepartment arrayByAddingObject:[ currentCell department]];
            self.Messaggiduration = [self.Messaggiduration arrayByAddingObject:[ currentCell duration]];
            self.Messaggieducation = [self.Messaggieducation arrayByAddingObject:[ currentCell education]];
            self.Messaggijob_code = [self.Messaggijob_code arrayByAddingObject:[ currentCell job_code]];
            self.Messaggijob_description = [self.Messaggijob_description arrayByAddingObject:[ currentCell job_description]];
            self.Messaggijob_title = [self.Messaggijob_title arrayByAddingObject:[ currentCell job_title]];
            self.Messaggilink = [self.Messaggilink arrayByAddingObject:[ currentCell link]];
            self.Messaggiloc_address = [self.Messaggiloc_address arrayByAddingObject:[ currentCell loc_address]];
            self.Messaggiloc_description = [self.Messaggiloc_description arrayByAddingObject:[ currentCell loc_description]];
            self.Messaggilocation = [self.Messaggilocation arrayByAddingObject:[ currentCell location]];
            self.Messaggipay_range = [self.Messaggipay_range arrayByAddingObject:[ currentCell pay_range]];
            self.Messaggipay_rate = [self.Messaggipay_rate arrayByAddingObject:[ currentCell pay_rate]];
            self.Messaggiposting_date = [self.Messaggiposting_date arrayByAddingObject:[ currentCell posting_date]];
            self.Messaggipreferred_skills = [self.Messaggipreferred_skills arrayByAddingObject:[ currentCell preferred_skills]];
            self.Messaggishift = [self.Messaggishift arrayByAddingObject:[ currentCell shift]];
            self.Messaggisummary = [self.Messaggisummary arrayByAddingObject:[ currentCell summary]];
            self.Messaggititle = [self.Messaggititle  arrayByAddingObject:[ currentCell title]];
            self.Messaggitravel = [self.Messaggitravel arrayByAddingObject:[ currentCell travel]];
            
            ciclo = ciclo +1;
        }
        
        
    }
    [self.tableView reloadData];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)filterContentForSearchText:(NSString*)searchText {
    
    self.Messaggicategory = [NSArray alloc];
    self.Messaggiclosing_date = [NSArray alloc];
    self.Messaggicompany = [NSArray alloc];
    self.Messaggidepartment = [NSArray alloc];
    self.Messaggiduration = [NSArray alloc];
    self.Messaggieducation = [NSArray alloc];
    self.Messaggijob_code = [NSArray alloc];
    self.Messaggijob_description = [NSArray alloc];
    self.Messaggijob_title = [NSArray alloc];
    self.Messaggilink = [NSArray alloc];
    self.Messaggiloc_address = [NSArray alloc];
    self.Messaggiloc_description = [NSArray alloc];
    self.Messaggilocation = [NSArray alloc];
    self.Messaggipay_range = [NSArray alloc];
    self.Messaggipay_rate = [NSArray alloc];
    self.Messaggiposting_date = [NSArray alloc];
    self.Messaggipreferred_skills = [NSArray alloc];
    self.Messaggishift = [NSArray alloc];
    self.Messaggisummary = [NSArray alloc];
    self.Messaggititle = [NSArray alloc];
    self.Messaggitravel = [NSArray alloc];
    
    
    self.Messaggicategory = [self.Messaggicategory init];
    self.Messaggiclosing_date = [self.Messaggiclosing_date init];
    self.Messaggicompany = [self.Messaggicompany init];
    self.Messaggidepartment = [self.Messaggidepartment init];
    self.Messaggiduration = [self.Messaggiduration init];
    self.Messaggieducation = [self.Messaggieducation init];
    self.Messaggijob_code = [self.Messaggijob_code init];
    self.Messaggijob_description = [self.Messaggijob_description init];
    self.Messaggijob_title = [self.Messaggijob_title init];
    self.Messaggilink = [self.Messaggilink init];
    self.Messaggiloc_address = [self.Messaggiloc_address init];
    self.Messaggiloc_description = [self.Messaggiloc_description init];
    self.Messaggilocation = [self.Messaggilocation init];
    self.Messaggipay_range = [self.Messaggipay_range init];
    self.Messaggipay_rate = [self.Messaggipay_rate init];
    self.Messaggiposting_date = [self.Messaggiposting_date init];
    self.Messaggipreferred_skills = [self.Messaggipreferred_skills init];
    self.Messaggishift = [self.Messaggishift init];
    self.Messaggisummary = [self.Messaggisummary init];
    self.Messaggititle = [self.Messaggititle init];
    self.Messaggitravel = [self.Messaggitravel init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(title CONTAINS[cd] %@) ",searchText];
    if ([CoreDataHelper countForEntity:@"LavoriCompleta" withPredicate:pred andContext:managedObjectContext] != 0)
    {
        MessaggiListData = [CoreDataHelper searchObjectsForEntity:@"LavoriCompleta" withPredicate:pred andSortKey:@"progressivo" andSortAscending:YES andContext:managedObjectContext];
        int app = MessaggiListData.count;
        int ciclo = 0;
        
 
        
        LavoriCompleta *currentCell ;
        
        //  Fill in the cell contents
        
        while (ciclo < (app)) {
            currentCell = [MessaggiListData objectAtIndex:ciclo];
            
            
            //Riempio gli array con il contenuto della cella
            self.Messaggicategory = [self.Messaggicategory arrayByAddingObject:[ currentCell category]];
            self.Messaggiclosing_date = [self.Messaggiclosing_date arrayByAddingObject:[ currentCell closing_date]];
            self.Messaggicompany = [self.Messaggicompany arrayByAddingObject:[ currentCell company]];
            self.Messaggidepartment = [self.Messaggidepartment arrayByAddingObject:[ currentCell department]];
            self.Messaggiduration = [self.Messaggiduration arrayByAddingObject:[ currentCell duration]];
            self.Messaggieducation = [self.Messaggieducation arrayByAddingObject:[ currentCell education]];
            self.Messaggijob_code = [self.Messaggijob_code arrayByAddingObject:[ currentCell job_code]];
            self.Messaggijob_description = [self.Messaggijob_description arrayByAddingObject:[ currentCell job_description]];
            self.Messaggijob_title = [self.Messaggijob_title arrayByAddingObject:[ currentCell job_title]];
            self.Messaggilink = [self.Messaggilink arrayByAddingObject:[ currentCell link]];
            self.Messaggiloc_address = [self.Messaggiloc_address arrayByAddingObject:[ currentCell loc_address]];
            self.Messaggiloc_description = [self.Messaggiloc_description arrayByAddingObject:[ currentCell loc_description]];
            self.Messaggilocation = [self.Messaggilocation arrayByAddingObject:[ currentCell location]];
            self.Messaggipay_range = [self.Messaggipay_range arrayByAddingObject:[ currentCell pay_range]];
            self.Messaggipay_rate = [self.Messaggipay_rate arrayByAddingObject:[ currentCell pay_rate]];
            self.Messaggiposting_date = [self.Messaggiposting_date arrayByAddingObject:[ currentCell posting_date]];
            self.Messaggipreferred_skills = [self.Messaggipreferred_skills arrayByAddingObject:[ currentCell preferred_skills]];
            self.Messaggishift = [self.Messaggishift arrayByAddingObject:[ currentCell shift]];
            self.Messaggisummary = [self.Messaggisummary arrayByAddingObject:[ currentCell summary]];
            self.Messaggititle = [self.Messaggititle  arrayByAddingObject:[ currentCell title]];
            self.Messaggitravel = [self.Messaggitravel arrayByAddingObject:[ currentCell travel]];

            ciclo = ciclo +1;
        }
        
        
    }
    [self.tableView reloadData];
    
}

@end
