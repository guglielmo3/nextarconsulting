 //
//  Aggiorna.m
//  Medjugorje
//
//  Created by Guglielmo Puglia on 23/07/12.
//  Copyright (c) 2012 gugosoft. All rights reserved.
//

#import "Aggiorna.h"
#import "CheckConnessione.h"
#import "CoreDataHelper.h"
#import "Lavori.h"

@interface Aggiorna ()

@end
//@implementation AppDelegate

@implementation Aggiorna

@synthesize btnAggiorna;
@synthesize btnAggiornaFoto;
@synthesize btnAggiornaVideo;
@synthesize btnAggiornaDocumenti;
@synthesize managedObjectContext;
@synthesize MessaggiListData;
@synthesize DocumentiListData;
@synthesize VideoListData;
@synthesize currentMessaggi;
@synthesize MessaggiModels;
@synthesize MessaggiMakes;
@synthesize MessaggiImages;
@synthesize AnniMutableArray;
@synthesize FotoListData;
@synthesize MAFotoAnno;
@synthesize MADocumentiAnno;
@synthesize MAvideoAnno;


NSString *tipoRichiesta;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (managedObjectContext == nil) 
	{ 
        managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext_: %@",  managedObjectContext);
	}
    
    self.view.backgroundColor = [UIColor whiteColor];
    AnniMutableArray = [[NSMutableArray alloc] init];
    AnniTotaleMutableArray = [[NSMutableArray alloc] init];
    MessaggiModels = [[NSMutableArray alloc] init];
    MessaggiMakes = [[NSMutableArray alloc] init];
    MessaggiImages = [[NSMutableArray alloc] init];
    contenutoTag = [[NSMutableString alloc] init];
 
    
   }
-(IBAction)AggiornaMessaggi:(id)sender
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
        
    
    
    NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=atom";
    NSURL *url = [NSURL URLWithString:path];
    NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
    tipoRichiesta = @"tam";
    [parser setDelegate:self];
    [parser parse];
    int app0 = self.AnniMutableArray.count;
    int ciclo0 = 0;
    
    int tempNum;
    
       
            [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];

    
        
        [self gestiscidaticore];
        
    
    
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
            [MessaggiMakes addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"content"]) {
            NSRange r;
            while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
            
            [MessaggiModels addObject:immutableString];
        }
        
        if ([elementName isEqualToString:@"link"]) {
            [MessaggiImages addObject:immutableString];
        }

 
  
  contenutoTag = [[NSMutableString alloc] init];

  storingCharacters = NO;
}


-(void) DownloadImmagine :(NSString *) immutableString
{
    /**
     * Se non devo necessariamente scaricare provo a verificare
     * se il file è già stato scaricato sul filesystem
     */
 
    NSURL *url = [NSURL URLWithString:[@"http://medjugorje.interactivecom.it/public/" stringByAppendingString:immutableString]];
    
    
    //[WEBVIEW loadRequest:reqURL];
    
    
    // Determile cache file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],immutableString];
    NSLog(immutableString);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"Image già Presente nel device");
    }
    else
    {

        // Download and write to file
    
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        [urlData writeToFile:filePath atomically:YES];
  
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"Image Caricata nel device");
        }

    }
}

-(void) gestiscidaticore
{
    
        [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:managedObjectContext];
    
      int app0 = self.MessaggiMakes.count;
        int ciclo0 = 0;
        
        while (ciclo0 <= (app0 -1)) {
            self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
            
            // For both new and existing pictures, fill in the details from the form
            NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
            [self.currentMessaggi setProgressivo:prganno];
            [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
         //   [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
           /* UIImage *MessaggiPhoto = [UIImage imageNamed: [self.MessaggiImages objectAtIndex:ciclo0]];
            
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

-(void) parser: (NSXMLParser *) parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"errore");
 /*   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Spiacente" message:@"Servizio di aggiornamento non disponibile al momento" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];  */
    
}
-(void) parserDidEndDocument:(NSXMLParser *) parser
{
    NSLog(@"Parsing finito");
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return TRUE;
}

@end
