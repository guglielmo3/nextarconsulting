//
//  AggiornaMessaggi.m
//  nextarconsulting
//
//  Created by Guglielmo Puglia on 03/05/14.
//  Copyright (c) 2014 Guglielmo Puglia. All rights reserved.
//

#import "AggiornaMessaggi.h"
#import "CoreDataHelper.h"
#import "Lavori.h"

@implementation AggiornaMessaggi

NSString *tipoRichiesta;
NSString *caricaDatiAggiorna = @"0";


-(BOOL) AggiornaDati
{
    caricaDatiAggiorna = @"0";
    if (_managedObjectContext == nil)
	{
        _managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext_: %@",  _managedObjectContext);
	}
    
    AnniMutableArray = [[NSMutableArray alloc] init];
    AnniTotaleMutableArray = [[NSMutableArray alloc] init];
    _MessaggiModels = [[NSMutableArray alloc] init];
    _MessaggiMakes = [[NSMutableArray alloc] init];
    _MessaggiImages = [[NSMutableArray alloc] init];
    _MessaggiDataPubblicazione = [[NSMutableArray alloc] init];
    contenutoTag = [[NSMutableString alloc] init];

    
    
   /* UIAlertView *alert;
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
    
    
    NSString *path = @"http://www.nextarconsulting.com/index.php?option=com_jobgroklist&view=postings&format=feed&type=rss";
    NSURL *url = [NSURL URLWithString:path];
    NSXMLParser *parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
    tipoRichiesta = @"rss";
    [parser setDelegate:self];
    [parser parse];
    int app0 = self.AnniMutableArray.count;
    int ciclo0 = 0;
    
    int tempNum;
    
    
    [ CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:_managedObjectContext];
    
    
    
    [self gestiscidaticore];
    
    
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    /*
     UILocalNotification *localNotification = [[UILocalNotification alloc]init];
     [localNotification setApplicationIconBadgeNumber:0];
     */
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
  //  [alert dismissWithClickedButtonIndex:0 animated:true];
    
	// Do any additional setup after loading the view, typically from a nib.
    return  true;

}
-(void) gestiscidaticore
{
    
    [CoreDataHelper deleteAllObjectsForEntity:@"Lavori" withPredicate:nil andContext:_managedObjectContext];
    
    int app0 = self.MessaggiMakes.count;
    int ciclo0 = 0;
    
    while (ciclo0 <= (app0 -1)) {
        self.currentMessaggi = (Lavori *)[NSEntityDescription insertNewObjectForEntityForName:@"Lavori" inManagedObjectContext:self.managedObjectContext];
        
        // For both new and existing pictures, fill in the details from the form
        NSNumber *prganno = [NSNumber numberWithInt:ciclo0];
        [self.currentMessaggi setProgressivo:prganno];
        [self.currentMessaggi setTitle:[self.MessaggiMakes objectAtIndex:ciclo0]];
        [self.currentMessaggi setDescription_:[self.MessaggiModels objectAtIndex:ciclo0]];
        [self.currentMessaggi setLink:[self.MessaggiImages objectAtIndex:ciclo0]];
        [self.currentMessaggi setDatapubblicazione:[self.MessaggiDataPubblicazione objectAtIndex:ciclo0]];
 
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
    
    NSRange r;
    
    
    if ([tipoRichiesta isEqualToString:@"atom"])
    {
        
        if([elementName isEqualToString:@"entry"])
        {
            caricaDatiAggiorna = @"1";
        }
        
        if([caricaDatiAggiorna isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"content"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages addObject:immutableString];
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
                [_MessaggiDataPubblicazione addObject:dateFromString];
                
            }
            
        }
    }
    else
    {
        if([elementName isEqualToString:@"item"])
        {
            caricaDatiAggiorna = @"1";
        }
        
        if([caricaDatiAggiorna isEqualToString:@"1"])
        {
            if ([elementName isEqualToString:@"title"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                NSString* noWhiteSpace =  [immutableString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                noWhiteSpace =[ noWhiteSpace stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                
                [_MessaggiMakes addObject:noWhiteSpace];
            }
            
            if ([elementName isEqualToString:@"description"]) {
                while ((r = [immutableString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
                    immutableString = [immutableString stringByReplacingCharactersInRange:r withString:@""];
                
                [_MessaggiModels addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"link"]) {
                [_MessaggiImages addObject:immutableString];
            }
            
            if ([elementName isEqualToString:@"pubDate"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd MMM yyyy"];
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                NSString *value = [immutableString substringWithRange:NSMakeRange(5, 11)];
                dateFromString = [dateFormatter dateFromString:value];
                [_MessaggiDataPubblicazione addObject:dateFromString];
                
            }
            
        }
        
    }
    
    
    contenutoTag = [[NSMutableString alloc] init];
    
    storingCharacters = NO;
}




@end
